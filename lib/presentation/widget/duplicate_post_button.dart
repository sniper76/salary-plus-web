import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DuplicatePostButton extends StatelessWidget {
  final PageRouteInfo Function() route;
  final void Function(dynamic value) doneCallback;
  final String title;

  const DuplicatePostButton({
    super.key,
    required this.route,
    required this.doneCallback,
    this.title = "게시글 복제",
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.router.push(route.call()).then(doneCallback);
      },
      child: Text(title),
    );
  }
}
