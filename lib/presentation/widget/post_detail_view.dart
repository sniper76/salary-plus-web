import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/post_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailView extends StatelessWidget {
  final String content;
  final List<PostImage>? postImages;

  final VoidCallback? onMenuPressed;

  const PostDetailView({
    super.key,
    required this.content,
    this.postImages,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: context.colorScheme.outline,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: SelectionArea(
            child: HtmlWidget(
              content.replaceAll('\n', '<br/>') ?? '',
              textStyle: context.textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade900,
              ),
              customWidgetBuilder: (element) {
                switch (element.localName) {
                  case 'img':
                    final imageUrl = element.attributes['src'];
                    if (imageUrl != null) {
                      return Align(
                        alignment: Alignment.center,
                        child: InkWell(
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
                          onTap: () {
                            context.showFullImage(imageUrl);
                          },
                        ),
                      );
                    }
                    break;
                  default:
                    return null;
                }
                return null;
              },
              onTapUrl: (url) async {
                // URL이 상대 경로인지 확인하고, 필요한 경우 'http://' 또는 'https://'를 추가합니다.
                final Uri uri = Uri.tryParse(url)?.hasScheme ?? false ? Uri.parse(url) : Uri.parse('http://$url');

                // 외부 브라우저에서 URL 열기
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                  return true;
                } else {
                  // URL을 열 수 없는 경우
                  EasyLoading.showToast("'$url'($uri)을 열수 없습니다.");
                  return false;
                }
              },
            ),
          ),
        ),
        if (postImages?.isNotEmpty == true)
          ...postImages!.map(
            (e) => InkWell(
              onTap: () => context.showFullImage(e.imageUrl),
              child: CachedNetworkImage(
                imageUrl: e.imageUrl,
                fit: BoxFit.fill,
                errorWidget: (context, url, _) {
                  return Container();
                },
              ),
            ),
          ),
      ],
    );
  }
}
