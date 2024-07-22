import 'package:act_web/config/constants.dart';

extension UriExtension on Uri {
  bool get isAppScheme => scheme.isEmpty || [AppConfig.appScheme].contains(scheme);

  bool get isWebScheme => ['https', 'http'].contains(scheme);
}
