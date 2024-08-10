enum DigitalDocumentSortType { issuedNumber, name, birthDate }

extension DigitalDocumentSortTypeExtension on DigitalDocumentSortType {
  String get value {
    switch (this) {
      case DigitalDocumentSortType.issuedNumber:
        return 'issuedNumber';
      case DigitalDocumentSortType.name:
        return 'name';
      case DigitalDocumentSortType.birthDate:
        return 'birthDate';
    }
  }

  String get title {
    switch (this) {
      case DigitalDocumentSortType.issuedNumber:
        return '작성순';
      case DigitalDocumentSortType.name:
        return '조회순';
      case DigitalDocumentSortType.birthDate:
        return '좋아요순';
    }
  }
}
