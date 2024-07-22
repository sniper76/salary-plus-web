import 'package:act_web/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static MaterialColor primaryColor = Constants.getPrimaryColor;

  static const TextStyle defaultTextStyle = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 18,
    wordSpacing: 1,
    color: Color(0xff333333),
    height: 1.4,
  );

  static final ColorScheme defaultColorScheme = ColorScheme(
    primary: primaryColor.shade500,
    onPrimary: Colors.white,
    secondary: const Color(0xFF439CFB),
    onSecondary: Colors.white,
    error: const Color(0xFFFF0000),
    onError: Colors.white,
    surface: const Color(0xffF9FAFC),
    onSurface: Colors.black54,
    brightness: Brightness.light,
    outline: Colors.grey.shade200,
  );

  static final TextTheme defaultTextTheme = TextTheme(
    displayLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 36, height: 1.55),
    displayMedium: defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
    // h1
    displaySmall: defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
    // h2
    headlineMedium: defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18, height: 1.44),
    // h3
    headlineSmall: defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, height: 1.5),
    // h4
    titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15, height: 1.46),
    // h5
    titleMedium: defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, height: 1.44),
    // h6
    titleSmall: defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 13, height: 1.42),
    // h7
    bodyLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, height: 1.5),
    bodyMedium: defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 15, height: 1.42),
    bodySmall: defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14, height: 1.42),
    labelLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13, height: 1.38),
    // caption
    labelMedium: defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 12, height: 1.38),
  );

  // ElevatedButton의 기본 스타일 추가
  static final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      // 버튼의 배경색 설정
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return const Color(0xffD9D9D9); // 비활성화 상태일 때의 배경색
        }
        return primaryColor.shade600; // 기본 배경색
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade400; // 비활성화 상태일 때의 배경색
        }
        return Colors.white; // 기본 배경색
      }),
      // 버튼의 모양 설정: 둥근 모서리를 가진 사각형
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      // 버튼 텍스트 스타일 설정
      textStyle: WidgetStateProperty.all<TextStyle>(
        defaultTextStyle.copyWith(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      // 기타 스타일 설정...
    ),
  );

  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor.shade500,
    primaryColorDark: primaryColor.shade600,
    primaryColorLight: primaryColor.shade400,
    iconTheme: IconThemeData(color: Colors.grey.shade900),
    scaffoldBackgroundColor: Colors.grey.shade100,
    brightness: Brightness.light,
    secondaryHeaderColor: Colors.grey.shade600,
    shadowColor: Colors.grey.shade200,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.grey.shade900,
      ),
      actionsIconTheme: IconThemeData(color: Colors.grey.shade900),
      titleTextStyle: defaultTextStyle,
    ),
    textTheme: defaultTextTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey.shade500,
    ),
    colorScheme: defaultColorScheme,
    elevatedButtonTheme: elevatedButtonTheme,
    useMaterial3: false,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  static final ThemeData light = themeData;

  static final ThemeData dark = themeData.copyWith(
    brightness: Brightness.dark,
    primaryColorDark: Colors.grey.shade300,
    primaryColorLight: Colors.grey.shade800,
    secondaryHeaderColor: Colors.grey.shade400,
    shadowColor: const Color(0xff282828),
    colorScheme: defaultColorScheme.copyWith(brightness: Brightness.dark),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: Colors.grey.shade900,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: defaultTextStyle.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: defaultTextTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade900,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey.shade500,
    ),
  );
}

class AppPadding {
  static const double small = 4;
  static const double normal = 8;
  static const double large = 12;
  static const double xlarge = 16;
}
