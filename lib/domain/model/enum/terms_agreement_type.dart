enum TermsAgreementType { terms, privacy, text, mail }

extension TermsAgreementTypeExtension on TermsAgreementType {
  String get title {
    switch (this) {
      case TermsAgreementType.terms:
        return '서비스 이용약관';
      case TermsAgreementType.privacy:
        return '개인정보 수집 및 이용 동의';
      case TermsAgreementType.text:
        return '주주연대 공지문자 수신 동의';
      case TermsAgreementType.mail:
        return '주주연대 공지우편물 수신 동의';
    }
  }

  String get url {
    switch (this) {
      case TermsAgreementType.terms:
        return 'https://conduit.cafe24.com/webview/policy/terms.html';
      case TermsAgreementType.privacy:
        return 'https://conduit.cafe24.com/webview/policy/privacy.html';
      case TermsAgreementType.text:
        return 'https://conduit.cafe24.com/webview/policy/agreement.html';
      case TermsAgreementType.mail:
        return 'https://conduit.cafe24.com/webview/policy/agreement.html';
    }
  }

  bool get isRequired {
    return this != TermsAgreementType.mail;
  }
}
