import 'package:demo/components/my_loader.dart';
import 'package:demo/services/posts_api.dart';
import 'package:flutter/material.dart';
import '../../../components/my_custom_list_view.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({super.key});

  @override
  State<MyPostsScreen> createState() => MyPostsScreenStack();
}

class MyPostsScreenStack extends State<MyPostsScreen> {
  var page = 0;
  var postsList = [];
  bool isLoadingMore = false;
  bool isMoreData = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPostsCall(page);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onEndReached() {
    if (!isLoading && isMoreData) {
      setState(() {
        isLoading = true;
        page = page + 1;
      });
      fetchPostsCall(page);
    }
  }

  Future<void> fetchPostsCall(page) async {
    if (page == 0) displayLoader();
    try {
      final response = await PostsAPI().fetchPosts(page);
      if (response.isEmpty) {
        setState(() {
          isLoading = false;
        });
        dismissLoader();
      }
      setState(() {
        postsList = [...postsList, ...response];
        isMoreData = response.isNotEmpty ? true : false;
        isLoading = false;
      });
      dismissLoader();
    } catch (error) {
      dismissLoader();
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      page = 0;
      postsList = [];
    });
    displayLoader();
    await Future<void>.delayed(const Duration(seconds: 2));
    fetchPostsCall(page);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: MyCustomListView(
        items: postsList,
        onEndReached: _onEndReached,
        onRefresh: onRefresh,
        isMoreData: isMoreData,
      ),
    );
  }
}
