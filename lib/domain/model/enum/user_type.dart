enum UserType {
  individual,
  corporation,
}

extension UserTypeExtension on UserType {
  String get value {
    switch (this) {
      case UserType.corporation:
        return 'CORPORATION';
      default:
        return 'USER';
    }
  }

  String get title {
    switch (this) {
      case UserType.corporation:
        return '법인';
      default:
        return '개인';
    }
  }
}
