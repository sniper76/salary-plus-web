import 'package:act_cms/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;
  final Duration duration;

  const ScrollToHideWidget({
    super.key,
    required this.scrollController,
    required this.child,
    this.duration = AnimationDuration.short,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: duration,
          height:
              scrollController.position.userScrollDirection == ScrollDirection.reverse ? 0 : kBottomNavigationBarHeight,
          child: child,
        );
      },
      child: Wrap(
        children: [child],
      ),
    );
  }
}
