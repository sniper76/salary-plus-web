enum KcbTermsAgreementType { agree1, agree2, agree3, agree4 }

extension KcbTermsAgreementTypeExtension on KcbTermsAgreementType {
  String get title {
    switch (this) {
      case KcbTermsAgreementType.agree1:
        return 'KCB 개인정보 이용동의';
      case KcbTermsAgreementType.agree2:
        return 'KCB 본인확인 서비스 이용약관';
      case KcbTermsAgreementType.agree3:
        return 'KCB 고유식별 정보처리 동의';
      case KcbTermsAgreementType.agree4:
        return '통신사 이용약관';
    }
  }

  String get url {
    switch (this) {
      case KcbTermsAgreementType.agree1:
        return 'https://safe.ok-name.co.kr/eterms/agreement001.jsp';
      case KcbTermsAgreementType.agree2:
        return 'https://safe.ok-name.co.kr/eterms/agreement003.jsp';
      case KcbTermsAgreementType.agree3:
        return 'https://safe.ok-name.co.kr/eterms/agreement003.jsp';
      case KcbTermsAgreementType.agree4:
        return 'https://safe.ok-name.co.kr/eterms/agreement004.jsp';
    }
  }

  bool get isRequired {
    return true;
  }
}
