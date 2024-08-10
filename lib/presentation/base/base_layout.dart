import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final AppBar? appBar;
  final Color? backgroundColor;

  const BaseLayout({
    Key? key,
    required this.body,
    this.scaffoldKey,
    this.appBar,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor ?? context.colorScheme.background,
      appBar: appBar,
      body: SafeArea(
        child: body,
      ),
    );
  }
}
