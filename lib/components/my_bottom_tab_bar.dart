import 'package:demo/screens/Auth/posts/my_posts_screen.dart';
import 'package:demo/screens/Auth/users/my_home_screen.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({Key? key}) : super(key: key);

  @override
  State<MyBottomBar> createState() => MyBottomBarState();
}

class MyBottomBarState extends State<MyBottomBar> {
  int pageIndex = 0;

  final pages = [const MyHomeScreen(), const MyPostsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? Icon(
                      Icons.home,
                      color: Colors.amber[400],
                      size: 35,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.grey,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? Icon(
                      Icons.perm_media,
                      color: Colors.amber[400],
                      size: 35,
                    )
                  : const Icon(
                      Icons.perm_media_outlined,
                      color: Colors.grey,
                      size: 35,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
