import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileImage extends StatefulWidget {
  final String imageUrl;
  final File imageFile;
  const ProfileImage({
    Key key,
    this.imageUrl,
    this.imageFile,
  }) : super(key: key);
  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  double height = 60;
  double width = 60;

  @override
  Widget build(BuildContext context) {
    if (widget.imageFile != null) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          border: Border.all(width: 1.5),
        ),
        padding: const EdgeInsets.all(16),
        child: Image.file(widget.imageFile),
      );
    }
    if ((widget.imageUrl ?? "").isEmpty) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          border: Border.all(width: 1.5),
        ),
        padding: const EdgeInsets.all(16),
        // child: SvgPicture.asset("assets/images/icons/user.svg"),
      );
    }
    return CachedNetworkImage(
      imageUrl: widget.imageUrl ?? "",
      fit: BoxFit.fitWidth,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(height / 2),
            border: Border.all(width: 1.5),
          ),
        );
      },
      placeholder: (context, url) {
        return Stack(
          children: <Widget>[
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height / 2),
                border: Border.all(width: 1.5),
              ),
              padding: const EdgeInsets.all(16),
              // child: SvgPicture.asset("assets/images/icons/user.svg"),
            ),
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  color: Colors.black38),
              alignment: Alignment.center,
              // child: ResizableCircularProgressIndicator(height / 3),
            )
          ],
        );
      },
      errorWidget: (context, str, obj) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
            border: Border.all(width: 1.5),
          ),
          padding: const EdgeInsets.all(16),
          // child: SvgPicture.asset("assets/images/icons/user.svg"),
        );
      },
    );
  }
}
