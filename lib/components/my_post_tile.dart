import 'package:demo/components/my_custom_clickable_icon.dart';
import 'package:flutter/material.dart';
import 'my_label.dart';
import 'my_scallable_image.dart';

class MyPostTile extends StatefulWidget {
  const MyPostTile({
    super.key,
    required this.post,
  });

  final post;

  @override
  State<MyPostTile> createState() => _MyPostTileState();
}

class _MyPostTileState extends State<MyPostTile> {
  bool isFavorite = false;

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
                text: widget.post['title'],
                fontWeight: FontWeight.bold,
                size: 18,
              ),
            ),
            MyNetworkImage(imageUri: widget.post['url']),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomClickableIcon(
                      onPressedIcon: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        size: 30,
                        color: isFavorite ? Colors.red[500] : null,
                      ),
                    ),
                    CustomClickableIcon(
                      onPressedIcon: () {},
                      icon: const Icon(
                        Icons.mode_comment_outlined,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: MyTextLabel(
                    text: widget.post['user'].toString(),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyTextLabel(text: widget.post['description']),
            )
          ],
        ),
      ),
    );
  }
}
