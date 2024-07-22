import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/presentation/widget/link_previewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ActHtmlWidget extends StatelessWidget {
  final String content;
  final Color? textColor;

  const ActHtmlWidget({super.key, required this.content, this.textColor});

  @override
  Widget build(BuildContext context) {
    final defaultTextColor = textColor ?? Colors.grey.shade900;
    return HtmlWidget(content,
        textStyle: context.textTheme.bodyLarge?.copyWith(color: defaultTextColor),
        buildAsync: false, customWidgetBuilder: (element) {
      switch (element.localName) {
        case 'a':
          final url = element.attributes['href'];

          return url != null ? LinkPreviewer(url: url) : null;
        case 'img':
          final imageUrl = element.attributes['src'];
          if (imageUrl != null) {
            return Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                errorWidget: (context, url, _) {
                  return Container(
                    color: Colors.grey.shade300,
                  );
                },
                placeholder: (context, url) {
                  return Container(
                    color: Colors.grey.shade300,
                  );
                },
              ),
            );
          }
          break;
        default:
          return null;
      }
      return null;
    });
  }
}
