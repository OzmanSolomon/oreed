import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImagePageRoute extends StatelessWidget {
  String imageDownloadUrl;
  FullImagePageRoute(this.imageDownloadUrl);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.clear,
                color: Colors.red,
              ),
            ),
          ),
          GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity > 0) {
                Navigator.of(context).pop();
              }
              print("${details.primaryVelocity}");
              // print("${details.velocity}");
              // print("${details}");
            },
            child: Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(imageDownloadUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
