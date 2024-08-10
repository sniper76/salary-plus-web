import 'package:act_cms/config/constants.dart';
import 'package:act_cms/main_common.dart';

void main() async {
  Constants.setEnvironment(Environment.prod);
  mainCommon();
}
