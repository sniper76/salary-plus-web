import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:html/parser.dart' show parse;

RegExp _urlRegExp =
    RegExp(r"(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");

extension StringExtension on String {
  bool get isEmail {
    return EmailValidator.validate(this);
  }

  bool get isPhoneNumber {
    final reg = RegExp(r'^010?([0-9]{4})?([0-9]{4})$');
    return reg.hasMatch(this);
  }

  bool get isUrl {
    return _urlRegExp.hasMatch(this);
  }

  Color toColor() {
    final hexCode = this;
    final buffer = StringBuffer();
    if (hexCode.length == 6 || hexCode.length == 7) {
      buffer.write('FF');
    }
    buffer.write(hexCode.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String ext() {
    return p.extension(this).toLowerCase();
  }

  List<String> convertToArray({RegExp? regExp}) {
    return split(regExp ?? ',').where((item) => item.isNotEmpty).toList();
  }

  String convertUrlLink() {
    String convertUrl = this;

    try {
      if (_urlRegExp.hasMatch(this)) {
        final convertStrings = [];
        final matches = _urlRegExp.allMatches(this);
        for (var e in matches) {
          final originText = substring(e.start, e.end);
          int startIndex = e.start - 1;
          int endIndex = e.end + 1;
          var startChar = '';
          var endChar = '';
          if (startIndex > -1) {
            startChar = substring(startIndex, e.start);
          }

          if (endIndex > -1 && endIndex < length) {
            endChar = substring(e.end, endIndex);
          }

          if (!convertStrings.contains(originText) && startChar != '"' && endChar != '"') {
            convertUrl = convertUrl.replaceAll(originText, '<a href="$originText">$originText</a>');
            convertStrings.add(originText);
          }
        }
      }

      return convertUrl;
    } catch (e) {
      return convertUrl;
    }
  }

  String get wordBreak => replaceAllMapped(RegExp(r'(\S)(?=\S)'), (m) => '${m[1]}\u200D');

  String get unEscapedString {
    return parse(this).body!.text;
  }
}
