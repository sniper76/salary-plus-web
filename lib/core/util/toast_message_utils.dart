import 'dart:async';

import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

class ToastMessageUtils {
  static String getDuplicateAndCampaignCreateTimeoutMessage(Result res) {
    var errorToastMessage = "";
    if (res.tryGetError() is TimeoutException){
      errorToastMessage = '데이터 생성중 입니다\n잠시후 목록을 확인해 주세요.';
    }
    else {
      errorToastMessage = res.tryGetError().toString();
    }
    return errorToastMessage;
  }
}
