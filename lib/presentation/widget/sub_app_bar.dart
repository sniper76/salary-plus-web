import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SubAppBar extends AppBar {
  SubAppBar({
    super.key,
    required BuildContext context,
    required String title,
    bool enabledBackKey = true,
    double titleSpacing = 0,
    String? subTitle,
    List<Widget>? actions,
    VoidCallback? onBackPressed,
  }) : super(
          automaticallyImplyLeading: true,
          centerTitle: false,
          leading: enabledBackKey
              ? IconButton(
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back_ios),
                )
              : Container(),
          leadingWidth: enabledBackKey ? 50 : 0,
          title: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              Text(title, style: const TextStyle(fontSize: cmsTitleFontSize, fontWeight: FontWeight.bold)),
              if (subTitle != null)
                Text(subTitle, style: context.textTheme.titleLarge?.copyWith(color: Colors.grey.shade400)),
            ],
          ),
          titleSpacing: titleSpacing,
          actions: actions,
          toolbarHeight: 100,
        );
}
