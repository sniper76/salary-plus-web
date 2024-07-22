import 'package:act_web/core/extension/context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkPreviewData {
  final String title;
  final String imageUrl;

  LinkPreviewData({
    required this.title,
    required this.imageUrl,
  });
}

class LinkPreviewer extends StatelessWidget {
  final String url;

  const LinkPreviewer({
    super.key,
    required this.url,
  });

  Future<LinkPreviewData> fetchLinkPreview(String url, Dio dio) async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.data);
        final title = document.head?.querySelector('meta[property="og:title"]')?.attributes['content'] ?? '';
        final imageUrl = document.head?.querySelector('meta[property="og:image"]')?.attributes['content'] ?? '';

        return LinkPreviewData(
          title: title,
          imageUrl: imageUrl,
        );
      } else {
        throw Exception('Failed to load link preview');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> checkIsRedirectUrl(String url, Dio dio) async {
    dio.options.followRedirects = false;
    dio.options.validateStatus = (int? status) {
      return status != null && status < 400;
    };
    Response response = await dio.head(url);
    return response.statusCode! >= 300 && response.statusCode! < 400;
  }

  void openLinkUrl(BuildContext context) async {
    launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<LinkPreviewData>(
          future: fetchLinkPreview(url, Dio()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingContainer(context);
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              final isImg = data.imageUrl.isNotEmpty;
              final isTitle = data.title.isNotEmpty;

              return GestureDetector(
                onTap: () {
                  openLinkUrl(context);
                },
                child: isTitle ? _buildLinkPreviewContainer(data, isImg, context) : _buildHyperText(context),
              );
            } else {
              return _buildTapableHyperText(context);
            }
          },
        )
      ],
    );
  }

  Widget _buildTapableHyperText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openLinkUrl(context);
      },
      child: _buildHyperText(context),
    );
  }

  Widget _buildLinkPreviewContainer(LinkPreviewData data, bool isImg, BuildContext context) {
    return _buildContainer(
      height: isImg ? 260 : 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCachedNetworkImage(data.imageUrl, isImg),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context, data.title),
                _buildUrlText(context, url),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer({required double height, required Widget child}) {
    return Container(
      width: double.infinity,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12, // border 색상
          width: 1.0, // border 너비
        ),
      ),
      child: child,
    );
  }

  Widget _buildCachedNetworkImage(String imageUrl, bool isImg) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: isImg ? 200 : 0,
      errorWidget: (context, url, _) => Container(height: 0),
      placeholder: (context, url) {
        return Container(
          color: Colors.grey.shade300,
          width: double.infinity,
          height: 200,
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.textTheme.titleMedium,
      maxLines: 1,
      overflow: TextOverflow.clip,
    );
  }

  Widget _buildUrlText(BuildContext context, String url) {
    return Text(
      url,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.titleSmall?.copyWith(color: Colors.black26),
    );
  }

  Widget _buildHyperText(BuildContext context) {
    return Text(
      url,
      style: const TextStyle(
        color: Colors.blue, // 하이퍼링크 색상
        decoration: TextDecoration.underline, // 밑줄 추가
      ),
    );
  }

  Widget _buildLoadingContainer(BuildContext context) {
    return _buildContainer(
      child: Center(
        child: SpinKitCircle(
          color: context.colorScheme.primary,
          size: 50.0,
        ),
      ),
      height: 260,
    );
  }
}
