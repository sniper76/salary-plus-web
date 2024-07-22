import 'package:act_web/core/util/logo_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ActLogoWidget extends StatelessWidget {
  final double width;
  final double height;
  final String stockCode;

  const ActLogoWidget({
    super.key,
    this.width = 32,
    this.height = 32,
    required this.stockCode,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: width,
        height: height,
        color: Colors.grey.shade100,
        child: CachedNetworkImage(
          imageUrl: LogoUtils.getLogoUrl(stockCode),
          placeholder: (context, url) => CircleAvatar(
            backgroundColor: Colors.white,
            radius: width / 2,
            child: const Icon(
              Icons.account_balance_sharp,
              color: Colors.black,
            ),
          ),
          errorWidget: (context, url, data) => CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: width / 2,
            child: Icon(
              Icons.account_balance_sharp,
              color: Colors.black,
              size: width * 0.7,
            ),
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
