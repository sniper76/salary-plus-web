import 'package:act_web/config/constants.dart';
import 'package:act_web/firebase_options_dev.dart' as dev_firebase;
import 'package:act_web/main_common.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  Constants.setEnvironment(Environment.dev);
  await Firebase.initializeApp(
    options: dev_firebase.DefaultFirebaseOptions.currentPlatform,
  );
  mainCommon();
}
