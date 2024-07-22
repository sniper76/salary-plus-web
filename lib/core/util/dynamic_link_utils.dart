import 'package:act_web/config/constants.dart';

class DynamicLinkUtils {
  static String getDynamicLink([String? path]) {
    final String domain = Constants.getEnvironment.getDynamicLinkUrlPrefix();
    final String linkParam = 'https://conduit.com$path';
    final String packageName = Constants.getEnvironment.getPackageName();

    return '$domain/?link=$linkParam&apn=$packageName&ibi=$packageName&isi=${AppConfig.iosDownloadLink}&ofl=${AppConfig.infoPageUrl}&efr=1';
  }
}
