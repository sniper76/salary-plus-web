import 'package:act_web/config/app_info.dart';

class ApiRequestHeaderHandler {
  void setHeader(options, accessToken) {
    final appInfo = AppInfo();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    options.headers['x-app-version'] = appInfo.appVersion;
  }
}
