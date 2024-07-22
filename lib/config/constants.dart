import 'package:flutter/material.dart';

enum Environment {
  local,
  dev,
  prod,
}

class Constants {
  static late Map<String, dynamic> _config;
  static late MaterialColor _primaryColor;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.local:
        _config = _Config.localConstants;
        _primaryColor = _Config.localPrimaryColor;
        break;
      case Environment.dev:
        _config = _Config.debugConstants;
        _primaryColor = _Config.debugPrimaryColor;
        break;
      case Environment.prod:
        _config = _Config.prodConstants;
        _primaryColor = _Config.prodPrimaryColor;
        break;
    }
  }

  static String get getEnvironment {
    return _config[_Config.flavor] as String;
  }

  static MaterialColor get getPrimaryColor {
    return _primaryColor;
  }
}

class _Config {
  static const flavor = 'flavor';

  static Map<String, dynamic> localConstants = {
    flavor: 'local',
  };

  static Map<String, dynamic> debugConstants = {
    flavor: 'dev',
  };

  static Map<String, dynamic> prodConstants = {
    flavor: 'prod',
  };

  static MaterialColor localPrimaryColor = const MaterialColor(
    0xFFFFCA28,
    <int, Color>{
      50: Color(0xFFFFFCF2),
      100: Color(0xFFFFF7E0),
      200: Color(0xFFFFE69C),
      300: Color(0xFFFFDF7E),
      400: Color(0xFFFFDF7E),
      500: Color(0xFFFFCA28),
      600: Color(0xFFE1B223),
      700: Color(0xFF9B7B18),
      800: Color(0xFF614D0F),
      900: Color(0xFF4C3C0C),
    },
  );
  static MaterialColor debugPrimaryColor = const MaterialColor(
    0xFF54BD71,
    <int, Color>{
      50: Color(0xFFF5FBF7),
      100: Color(0xFFE6F5EA),
      200: Color(0xFFCFEDD7),
      300: Color(0xFFB0E0BD),
      400: Color(0xFF98D7AA),
      500: Color(0xFF54BD71),
      600: Color(0xFF409056),
      700: Color(0xFF337345),
      800: Color(0xFF285A36),
      900: Color(0xFF193822),
    },
  );

  static MaterialColor prodPrimaryColor = const MaterialColor(
    0xFF355CE9,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFD7DEFB),
      200: Color(0xFFAEBEF6),
      300: Color(0xFF869DF2),
      400: Color(0xFF5D7DED),
      500: Color(0xFF355CE9),
      600: Color(0xFF2A4ABA),
      700: Color(0xFF20378C),
      800: Color(0xFF15255D),
      900: Color(0xFF0B122F),
    },
  );
}

extension FlavorTypeExtension on String {
  String getDynamicLinkUrlPrefix() {
    switch (this) {
      case 'dev':
        return 'https://devconduit.page.link';
      case 'prod':
        return 'https://conduit.page.link';
      default:
        throw Exception('Invalid environment: $this');
    }
  }

  String getPackageName() {
    switch (this) {
      case 'dev':
        return 'com.conduit.act.dev';
      case 'prod':
        return 'com.conduit.act';
      default:
        throw Exception('Invalid environment: $this');
    }
  }

  String getAppStoreId() {
    switch (this) {
      case 'dev':
        return '6469601144';
      case 'prod':
        return '6444644879';
      default:
        throw Exception('Invalid environment: $this');
    }
  }

  String getApiBaseUrl() {
    switch (this) {
      case 'local':
        return 'http://localhost:${AppConfig.kApiPort}/api';
      case 'dev':
        return 'https://devapi.act.ag/api';
      case 'prod':
        return 'https://api.act.ag/api';
      default:
        throw Exception('Invalid environment: $this');
    }
  }

  bool isRelease() {
    switch (this) {
      case 'local':
        return false;
      case 'dev':
        return false;
      case 'prod':
        return true;
      default:
        throw Exception('Invalid environment: $this');
    }
  }

  bool isDev() => this == 'dev';

  bool isLocal() => this == 'local';
}

class AppConfig {
  static const String downloadUrl = 'https://www.act.ag/';
  static const String baseWebViewUrl = 'https://conduit.cafe24.com/webview';
  static const String channelTalkUrl = 'https://conduit.channel.io/home';
  static const int maxPinNumberLength = 6;
  static const String appScheme = 'actapp';
  static const List<String> stockTabMenuNames = [
    'home',
    'analysis',
    'debate',
    'action',
  ];
  static const List<String> jobItems = ['전문직', '(전,현) 상장사 임원', '교수, 연구원, 박사', '회사원', '자영업', '기타'];
  static const Duration backgroundGuardDuration = Duration(minutes: 10);

  static const bool skipLogin = true;

  static const String globalBoardCode = 'Z00001';
  static const String stopWordText = '금칙어';

  static bool isRelease = Constants.getEnvironment.isRelease();
  static const double loadMoreScrollPosition = 300;
  static const String dateTimeFormatPattern = 'yyyy-MM-dd HH:mm';
  static const String dateTimeWithSecondFormatPattern = 'yyyy-MM-dd HH:mm:ss';
  static const String kApiPort = String.fromEnvironment('SERVER_PORT', defaultValue: '8080');
  static const String defaultUserProfileImageUrl =
      "https://act-prod-files.s3.ap-northeast-2.amazonaws.com/static/default-user-profile-images/act_man_01.png";
  static const int oneHundredMillion = 100000000;

  static const double defaultPadding = 16.0;
  static const double cmsTitleFontSize = 24.0;
  static const double maxWidth = 1200.0;
  static const double rankingWidgetWidth = 300.0;
  static const double leftSectionWidth = 800.0;

  static const String policyUrl = 'https://act-prod-files.s3.ap-northeast-2.amazonaws.com/static/policy/terms.html';
  static const String privacyUrl = 'https://act-prod-files.s3.ap-northeast-2.amazonaws.com/static/policy/privacy.html';

  static const String iosDownloadLink = 'https://apps.apple.com/app/id6444644879';
  static const String androidDownloadLink = 'https://play.google.com/store/apps/details?id=com.conduit.act';

  static const String holderListReadAndCopyName = 'HOLDER_LIST_READ_AND_COPY';

  static const String globalBoardTitle = '주주행동 News';
  static const String globalCommunityTitle = '자유게시판';

  static const String infoPageUrl = 'https://web.act.ag/';
}

class AnimationDuration {
  static const Duration zero = Duration.zero;
  static const Duration shortest = Duration(milliseconds: 150);
  static const Duration short = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration long = Duration(milliseconds: 850);
}
