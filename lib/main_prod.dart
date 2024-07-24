import 'package:salary_plus_web/config/constants.dart';
import 'package:salary_plus_web/firebase_options_prod.dart' as prod_firebase;
import 'package:salary_plus_web/main_common.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  Constants.setEnvironment(Environment.prod);
  await Firebase.initializeApp(
    options: prod_firebase.DefaultFirebaseOptions.currentPlatform,
  );

  mainCommon();
}
