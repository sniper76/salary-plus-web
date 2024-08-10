enum PhoneType { skt, kt, lguplus, sktMvno, ktMvno, lguplusMvno }

extension PhoneTypeExtension on PhoneType {
  String get title {
    switch (this) {
      case PhoneType.skt:
        return 'SKT';
      case PhoneType.kt:
        return 'KT';
      case PhoneType.lguplus:
        return 'LGU+';
      case PhoneType.sktMvno:
        return 'SKT 알뜰폰';
      case PhoneType.ktMvno:
        return 'KT 알뜰폰';
      case PhoneType.lguplusMvno:
        return 'LGU+ 알뜰폰';
    }
  }

  String get value {
    switch (this) {
      case PhoneType.skt:
        return '01';
      case PhoneType.kt:
        return '02';
      case PhoneType.lguplus:
        return '03';
      case PhoneType.sktMvno:
        return '04';
      case PhoneType.ktMvno:
        return '05';
      case PhoneType.lguplusMvno:
        return '06';
    }
  }
}
