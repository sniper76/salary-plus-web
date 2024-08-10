import 'package:act_cms/config/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    super.key,
    BuildContext? context,
    String? mainTitle,
    Widget? titleWidget,
    List<Widget>? trailingWidgets,
    PreferredSizeWidget? bottomWidget,
    double? toolbarHeight,
    bool? automaticallyImplyLeading,
    bool isRefresh = false,
  })  : assert((mainTitle == null) != (titleWidget == null)),
        super(
          toolbarHeight: toolbarHeight ?? 100,
          centerTitle: false,
          automaticallyImplyLeading: automaticallyImplyLeading ?? false,
          bottom: bottomWidget,
          leading: context != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.router.pop(isRefresh);
                  },
                )
              : null,
          title: Container(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: titleWidget == null
                  ? [
                      Text(mainTitle!, style: const TextStyle(fontSize: cmsTitleFontSize, fontWeight: FontWeight.w900)),
                      if (trailingWidgets != null) Row(children: trailingWidgets)
                    ]
                  : [titleWidget, if (trailingWidgets != null) Row(children: trailingWidgets)],
            ),
          ),
        );
}
