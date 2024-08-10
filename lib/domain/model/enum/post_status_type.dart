import 'package:json_annotation/json_annotation.dart';

enum PostStatusType {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('INACTIVE_BY_USER')
  inactive_by_user,
  @JsonValue('INACTIVE_BY_ADMIN')
  inactive_by_admin,
  @JsonValue('WITHDRAWAL_REQUESTED')
  withdawal_by_request,
  @JsonValue('DELETED_BY_USER')
  deleted_by_user,
  @JsonValue('DELETED_BY_ADMIN')
  deleted_by_admin,
  @JsonValue('DELETED')
  delete,
  @JsonValue('ALL')
  all,
  @JsonValue('UNKNOWN')
  unknown,
}

extension PostStatusTypeExtension on PostStatusType {
  String get value {
    switch (this) {
      case PostStatusType.active:
        return 'ACTIVE';
      case PostStatusType.processing:
        return 'PROCESSING';
      case PostStatusType.inactive_by_user:
        return 'INACTIVE_BY_USER';
      case PostStatusType.inactive_by_admin:
        return 'INACTIVE_BY_ADMIN';
      case PostStatusType.withdawal_by_request:
        return 'WITHDRAWAL_REQUESTED';
      case PostStatusType.deleted_by_user:
        return 'DELETED_BY_USER';
      case PostStatusType.deleted_by_admin:
        return 'DELETED_BY_ADMIN';
      case PostStatusType.delete:
        return 'DELETED';
      case PostStatusType.all:
        return 'ALL';
      default:
        return 'UNKNOWN';
    }
  }

  String get title {
    switch (this) {
      case PostStatusType.active:
        return '게시';
      case PostStatusType.processing:
        return '처리중';
      case PostStatusType.inactive_by_user:
        return '비활성화_BY_USER';
      case PostStatusType.inactive_by_admin:
        return '비활성화_BY_ADMIN';
      case PostStatusType.withdawal_by_request:
        return '철회요청중';
      case PostStatusType.deleted_by_user:
        return '삭제_BY_USER';
      case PostStatusType.deleted_by_admin:
        return '삭제_BY_ADMIN';
      case PostStatusType.delete:
        return '삭제';
      case PostStatusType.all:
        return '전체';
      default:
        return 'UNKNOWN';
    }
  }
}
