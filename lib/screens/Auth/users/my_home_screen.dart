// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:demo/components/my_alert.dart';
import 'package:demo/components/my_custom_list_view.dart';
import 'package:demo/components/my_custom_sheet.dart';
import 'package:demo/components/my_loader.dart';
import 'package:demo/screens/Auth/posts/my_posts_screen.dart';
import 'package:demo/screens/Auth/users/my_create_edit_screen.dart';
import 'package:demo/screens/Auth/users/my_user_detail_screen.dart';
import 'package:demo/screens/UnAuth/my_login.dart';
import 'package:demo/services/users_api.dart';
import 'package:demo/utils/Constants/const.dart';
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
  bool isMoreData = true;
  var page = 1;
  var selectedUser;

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
      body: MyCustomListView(
        items: users,
        onTap: onTapTile,
        onPressIconButton: onPressDetailIcon,
        onEndReached: loadMore,
        onRefresh: onRefresh,
        isMoreData: isMoreData,
        itemExtent: 110.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToPostsScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigateToPostsScreen() {
    Route route = MaterialPageRoute(
      builder: (context) => const MyPostsScreen(),
    );
    Navigator.push(
      context,
      route,
    );
  }

  void onTapTile(user) {
    setState(() {
      selectedUser = user;
    });
    onPressTile();
  }

  void onPressDetailIcon(BuildContext context, user) {
    setState(() {
      selectedUser = user;
      isCreate = false;
    });
    showActionSheet(
      context,
      onPressAction,
      onPressDelete,
      'Cancel',
      'Update User',
      'Delete User',
    );
  }

  Future<void> onRefresh() async {
    setState(() {
      users = [];
      isLoading = false;
      isCreate = false;
      isMoreData = true;
      page = 1;
      selectedUser = null;
    });
    displayLoader();
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
        refresh: refresh,
      ),
    );
    Navigator.push(
      context,
      route,
    );
  }

  void loadMore() {
    setState(() {
      page = page + 1;
    });
    fetchRandomUsers(page);
  }

  Future<void> onPressDelete() async {
    final response =
        await UserApi().deleteUserAPI(selectedUser['id']?.toString());
    if (response.statusCode == 204) {
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

  void getAPIError() {
    setState(() {
      isLoading = false;
    });
  }

  void refresh() {
    setState(() {
      page = 1;
      users = [];
    });
    fetchRandomUsers(page);
  }

  Future<void> fetchRandomUsers(page) async {
    try {
      final response = await UserApi().fetchUserAPI(page);
      if (response.isEmpty) {
        getAPIError();
        setState(() {
          isMoreData = false;
        });
        dismissLoader();
      } else {
        setState(() {
          users = [...users, ...response];
          isLoading = false;
          isMoreData = response.isNotEmpty ? true : false;
        });
        dismissLoader();
      }
    } catch (error) {
      dismissLoader();
    }
  }
}
