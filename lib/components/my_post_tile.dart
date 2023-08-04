import 'package:flutter/material.dart';
import 'my_label.dart';
import 'my_scallable_image.dart';

class MyPostTile extends StatelessWidget {
  const MyPostTile({
    super.key,
    required this.post,
  });

  final post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shadowColor: Colors.amber[100],
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 0, bottom: 10),
              child: MyTextLabel(
                text: post['title'],
                fontWeight: FontWeight.bold,
                size: 18,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
              child: MyNetworkImage(imageUri: post['url']),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyTextLabel(text: post['description']),
            )
          ],
        ),
      ),
    );
  }
}
