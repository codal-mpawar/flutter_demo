import 'package:demo/components/my_alert.dart';
import 'package:demo/components/my_tile.dart';
import 'package:demo/screens/Auth/users/my_create_edit_screen.dart';
import 'package:demo/screens/Auth/users/my_user_detail_screen.dart';
import 'package:demo/screens/UnAuth/my_login.dart';
import 'package:demo/services/users_api.dart';
import 'package:demo/utils/Constants/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<dynamic> users = [];
  bool isLoading = false;
  bool isCreate = false;
  bool isLoadingMore = false;
  bool isMoreData = true;
  var page = 1;
  var selectedUser = null;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    fetchRandomUsers(page);
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      var page = 1;
    });
  }

  void onPressCreateUser(BuildContext context) {
    setState(() {
      isCreate = true;
      selectedUser = null;
    });
    onPressAction(context);
  }

  void onPressLogout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN);
    Route route = MaterialPageRoute(
      builder: (context) => const MyLoginScreen(),
    );
    Navigator.pushReplacement(
      context,
      route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        leading: const Icon(Icons.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              onPressCreateUser(context);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 25,
            ),
            onPressed: () {
              onPressLogout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 0.6,
                ),
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels >= 250 &&
                      !isLoadingMore &&
                      isMoreData) {
                    setState(() {
                      isLoadingMore = true;
                    });
                    loadMore();
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: onRefresh,
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      var userFullName = user['first_name'] + user['last_name'];
                      return MyUserTile(
                        onTap: () {
                          onTapTile(user);
                        },
                        onPressIconButton: () {
                          onPressDetailIcon(context, user);
                        },
                        userAvatar: user['avatar'],
                        userFullName: userFullName,
                        userEmail: user['email'],
                        isVisible: true,
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  void onTapTile(user) {
    setState(() {
      selectedUser = user;
    });
    onPressTile();
  }

  void onPressDetailIcon(BuildContext context, user) {
    _showActionSheet(context);
    setState(() {
      selectedUser = user;
      isCreate = false;
    });
  }

  Future<void> onRefresh() async {
    setState(() {
      users = [];
      isLoading = false;
      isCreate = false;
      isLoadingMore = false;
      isMoreData = true;
      page = 1;
      selectedUser = null;
    });
    await Future<void>.delayed(const Duration(seconds: 2));
    fetchRandomUsers(page);
    return;
  }

  void onPressTile() {
    Map<String, String> selectedUserParams = {
      "id": selectedUser['id'].toString(),
      "email": selectedUser['email'],
      "first_name": selectedUser['first_name'],
      "last_name": selectedUser['last_name'],
      "avatar": selectedUser['avatar']
    };
    Route route = MaterialPageRoute(
      builder: (context) => MyUserDetailScreen(user: selectedUserParams),
    );
    Navigator.push(
      context,
      route,
    );
  }

  void onPressAction(BuildContext context) {
    var firstName = selectedUser != null ? selectedUser['first_name'] : '';
    var lastName = selectedUser != null ? selectedUser['last_name'] : '';
    var userId = selectedUser != null ? selectedUser['id'] : '';
    Route route = MaterialPageRoute(
      builder: (context) => MyCreateEditScreen(
        isCreate: isCreate,
        firstName: firstName,
        lastName: lastName,
        userId: userId.toString(),
      ),
    );
    Navigator.push(
      context,
      route,
    ).then((value) => fetchRandomUsers(page));
  }

  void loadMore() {
    setState(() {
      page = page + 1;
    });
    fetchRandomUsers(page);
  }

  Future<void> onPressDelete() async {
    // ignore: argument_type_not_assignable_to_error_handler, body_might_complete_normally_catch_error
    final response =
        await UserApi().deleteUserAPI(selectedUser['id']?.toString());
    if (response.statusCode == 200) {
      List tempList = users;
      tempList.remove(selectedUser);
      setState(() {
        users = tempList;
      });
    } else if (response.statusCode == 404) {
      showMyDialogBox(context, 'Alert', 'User Not Found');
    } else {
      showMyDialogBox(context, 'Alert', 'Something went wrong!');
    }
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'CRUD Operations',
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onPressAction(context);
            },
            child: const Text(
              'Update User',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onPressDelete();
            },
            child: const Text(
              'Delete User',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          )
        ],
      ),
    );
  }

  void getAPIError() {
    setState(() {
      isLoading = false;
      isLoadingMore = false;
    });
  }

  Future<void> fetchRandomUsers(page) async {
    final response = await UserApi().fetchUserAPI(page);
    if (response.isEmpty) {
      getAPIError();
      setState(() {
        isMoreData = false;
      });
    } else {
      setState(() {
        users = [...users, ...response];
        isLoading = false;
        isLoadingMore = false;
        isMoreData = response.isNotEmpty ? true : false;
      });
    }
  }
}
