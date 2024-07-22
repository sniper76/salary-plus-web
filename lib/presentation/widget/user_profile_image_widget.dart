import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileImageWidget extends StatelessWidget {
  final String url;
  final double size;

  const UserProfileImageWidget({
    super.key,
    required this.url,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return ClipOval(
        child: Container(
          height: size,
          width: size,
          color: Colors.grey.shade300,
          child: Icon(
            Icons.person,
            size: size * 0.9,
            color: Colors.grey.shade100,
          ),
        ),
      );
    } else {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.fill,
          height: size,
          width: size,
          placeholder: (context, url) {
            return Container(color: Colors.grey.shade300);
          },
          errorWidget: (context, url, _) {
            return Container(
              color: Colors.grey.shade300,
              child: Icon(
                Icons.person,
                size: size * 0.9,
                color: Colors.grey.shade100,
              ),
            );
          },
        ),
      );
    }
  }
}
