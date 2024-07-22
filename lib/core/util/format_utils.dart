import 'package:intl/intl.dart';

class FormatUtils {
  static String formatPhoneNumber(String rawNumber) {
    // 숫자만 포함된 문자열을 기대합니다.
    if (rawNumber.length == 11) {
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 7)}-${rawNumber.substring(7, 11)}';
    } else if (rawNumber.length == 10) {
      // 일부 번호는 10자리일 수 있습니다.
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 6)}-${rawNumber.substring(6, 10)}';
    }
    return rawNumber; // 다른 길이의 번호는 수정하지 않고 반환합니다.
  }

  static String formatAssetAmount(int? amount) {
    if (amount == null) {
      return '-';
    } else if (amount >= 10000) {
      // 만 단위 이하가 모두 0인지 확인합니다.
      final numberFormat = NumberFormat('#,###', 'ko_KR');
      // 금액을 만으로 나누고 정수부만 취합니다.
      final formattedAmount = numberFormat.format(amount ~/ 10000);
      return '$formattedAmount만원';
    } else {
      final numberFormat = NumberFormat('#,###', 'ko_KR');
      return '${numberFormat.format(amount)}원';
    }
  }

  static String formatVerificationCode(String? verificationCode) {
    if (verificationCode == null || verificationCode.isEmpty) {
      return '';
    }
    return verificationCode.replaceRange(0, 1, '${verificationCode[0]}-');
  }
}
