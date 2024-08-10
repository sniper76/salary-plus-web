import 'package:act_cms/presentation/base/base_layout.dart';
import 'package:act_cms/presentation/widget/sub_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class WebScreen extends StatefulWidget {
  final String url;
  final String title;
  final bool hideAppBar;

  const WebScreen({
    Key? key,
    required this.url,
    this.title = '',
    this.hideAppBar = false,
  }) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _webViewKey = GlobalKey();
  final _webViewOptions = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      transparentBackground: true,
      useShouldOverrideUrlLoading: true,
      javaScriptEnabled: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
      allowsBackForwardNavigationGestures: true,
    ),
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      scaffoldKey: _scaffoldKey,
      appBar: widget.hideAppBar
          ? null
          : SubAppBar(
              context: context,
              title: widget.title,
            ),
      body: InAppWebView(
        key: _webViewKey,
        initialOptions: _webViewOptions,
        initialUrlRequest: URLRequest(
          url: Uri.parse(widget.url),
        ),
        onConsoleMessage: (controller, message) {},
        shouldOverrideUrlLoading: (controller, action) async {
          final url = action.request.url!;
          if (url.scheme == 'intent') {
            return NavigationActionPolicy.CANCEL;
          }

          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
