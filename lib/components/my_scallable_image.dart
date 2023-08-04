import 'package:demo/components/my_custom_loader.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatefulWidget {
  const MyNetworkImage({super.key, required this.imageUri});
  final String imageUri;
  @override
  State<MyNetworkImage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyNetworkImage> {
  var imageHeight = 0.0;
  var imageWidth = 0.0;

  @override
  void initState() {
    super.initState();
    getImageHeightAndWidth();
  }

  void disponse() {
    super.dispose();
  }

  Future<void> getImageHeightAndWidth() async {
    try {
      Image image = Image.network(widget.imageUri);
      image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener(
          (ImageInfo image, bool synchronousCall) {
            if (mounted) {
              var myImage = image.image;
              setState(() {
                imageHeight = myImage.height.toDouble();
                imageWidth = myImage.width.toDouble();
              });
            }
          },
        ),
      );
    } catch (error) {
      Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageHeight > 0 && imageWidth > 0) {
      return AspectRatio(
        aspectRatio: imageHeight == imageWidth
            ? 1
            : imageHeight > imageWidth
                ? 0.8
                : 1.78,
        child: Image.network(widget.imageUri),
      );
    }
    return const Center(child: Loader());
  }
}
