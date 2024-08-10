enum ActionPostType { action, campaign }

extension ActionPostTypeExtension on ActionPostType {
  String get title {
    switch (this) {
      case ActionPostType.action:
        return '액션';
      case ActionPostType.campaign:
        return '캠페인';
      default:
        return '';
    }
  }

  String get value {
    switch (this) {
      case ActionPostType.action:
        return 'action';
      case ActionPostType.campaign:
        return 'campaign';
      default:
        return '';
    }
  }

  bool get isAction => this == ActionPostType.action;

  bool get isCampaign => this == ActionPostType.campaign;
}
