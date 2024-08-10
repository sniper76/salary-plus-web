import 'package:act_cms/core/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtension Tests', () {
    test('isEmail 테스트 true', () {
      expect('example@example.com'.isEmail, isTrue);
    });

    test('isEmail 테스트 false', () {
      expect('example.com'.isEmail, isFalse);
    });

    test('isPhoneNumber 테스트 true', () {
      expect('01012341234'.isPhoneNumber, isTrue);
    });

    test('isPhoneNumber 테스트 false', () {
      expect('12345678'.isPhoneNumber, isFalse);
    });

    test('isUrl  테스트 true', () {
      expect('https://www.example.com'.isUrl, isTrue);
    });

    test('isUrl 테스트 false', () {
      expect('example'.isUrl, isFalse);
    });

    test('toColor 테스트 true', () {
      expect('#FFFFFF'.toColor(), equals(Colors.white));
    });

    test('convertToArray 테스트', () {
      final array = 'one,two,three'.convertToArray();
      expect(array, equals(['one', 'two', 'three']));
    });

    test('convertToArray(test,      test,  test, test	gsdgsdg		   test,testsettest,teststes,  test) 테스트', () {
      final reg = RegExp(r',\s*|\s');
      final array =
          'test,      test,  test, test	gsdgsdg		   test,testsettest,teststes,  test'.convertToArray(regExp: reg);
      expect(array, equals(['test', 'test', 'test', 'test', 'gsdgsdg', 'test', 'testsettest', 'teststes', 'test']));
    });

    test('convertToArray(test,      ) 테스트', () {
      final reg = RegExp(r',\s*|\s');
      final array = 'test,      '.convertToArray(regExp: reg);
      expect(array, equals(['test']));
    });

    test('convertToArray(test,      test,  test gsdgsdg) 테스트', () {
      final reg = RegExp(r',\s*|\s');
      final array = 'test,      test,  test gsdgsdg'.convertToArray(regExp: reg);
      expect(array, equals(['test', 'test', 'test', 'gsdgsdg']));
    });
  });
}
