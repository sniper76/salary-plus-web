import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostToolBar extends StatelessWidget {
  final int likeCount;
  final bool liked;
  final VoidCallback? onLikePressed;
  final VoidCallback? onSharePressed;

  const PostToolBar({
    super.key,
    this.likeCount = 0,
    this.liked = false,
    this.onLikePressed,
    this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Container(
            height: 1,
            color: context.colorScheme.outline,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Wrap(
                  spacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    TextButton(
                      onPressed: onLikePressed,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Icon(
                            liked ? Icons.favorite_outlined : Icons.favorite_border,
                            color: Colors.red,
                            size: 20,
                          ),
                          Text(
                            likeCount.toNumberFormat,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onSharePressed,
                      icon: SvgPicture.asset(
                        'assets/images/ic_share.svg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
