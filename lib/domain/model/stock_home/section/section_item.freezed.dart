// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SectionItem _$SectionItemFromJson(Map<String, dynamic> json) {
  return _SectionItem.fromJson(json);
}

/// @nodoc
mixin _$SectionItem {
  String get title => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;
  bool get reported => throw _privateConstructorUsedError;
  bool get isNew => throw _privateConstructorUsedError;
  bool get isExclusiveToHolders => throw _privateConstructorUsedError;
  String? get thumbnailImageUrl => throw _privateConstructorUsedError;
  UserProfile? get userProfile => throw _privateConstructorUsedError;
  @JsonKey(name: 'boardCategory')
  BoardGroupCategory? get boardGroupCategory =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionItemCopyWith<SectionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionItemCopyWith<$Res> {
  factory $SectionItemCopyWith(
          SectionItem value, $Res Function(SectionItem) then) =
      _$SectionItemCopyWithImpl<$Res, SectionItem>;
  @useResult
  $Res call(
      {String title,
      String link,
      DateTime createdAt,
      DateTime updatedAt,
      int viewCount,
      int likeCount,
      int commentCount,
      bool deleted,
      bool reported,
      bool isNew,
      bool isExclusiveToHolders,
      String? thumbnailImageUrl,
      UserProfile? userProfile,
      @JsonKey(name: 'boardCategory') BoardGroupCategory? boardGroupCategory});

  $UserProfileCopyWith<$Res>? get userProfile;
  $BoardGroupCategoryCopyWith<$Res>? get boardGroupCategory;
}

/// @nodoc
class _$SectionItemCopyWithImpl<$Res, $Val extends SectionItem>
    implements $SectionItemCopyWith<$Res> {
  _$SectionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? link = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? deleted = null,
    Object? reported = null,
    Object? isNew = null,
    Object? isExclusiveToHolders = null,
    Object? thumbnailImageUrl = freezed,
    Object? userProfile = freezed,
    Object? boardGroupCategory = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      reported: null == reported
          ? _value.reported
          : reported // ignore: cast_nullable_to_non_nullable
              as bool,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      isExclusiveToHolders: null == isExclusiveToHolders
          ? _value.isExclusiveToHolders
          : isExclusiveToHolders // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnailImageUrl: freezed == thumbnailImageUrl
          ? _value.thumbnailImageUrl
          : thumbnailImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      boardGroupCategory: freezed == boardGroupCategory
          ? _value.boardGroupCategory
          : boardGroupCategory // ignore: cast_nullable_to_non_nullable
              as BoardGroupCategory?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get userProfile {
    if (_value.userProfile == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_value.userProfile!, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BoardGroupCategoryCopyWith<$Res>? get boardGroupCategory {
    if (_value.boardGroupCategory == null) {
      return null;
    }

    return $BoardGroupCategoryCopyWith<$Res>(_value.boardGroupCategory!,
        (value) {
      return _then(_value.copyWith(boardGroupCategory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SectionItemImplCopyWith<$Res>
    implements $SectionItemCopyWith<$Res> {
  factory _$$SectionItemImplCopyWith(
          _$SectionItemImpl value, $Res Function(_$SectionItemImpl) then) =
      __$$SectionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String link,
      DateTime createdAt,
      DateTime updatedAt,
      int viewCount,
      int likeCount,
      int commentCount,
      bool deleted,
      bool reported,
      bool isNew,
      bool isExclusiveToHolders,
      String? thumbnailImageUrl,
      UserProfile? userProfile,
      @JsonKey(name: 'boardCategory') BoardGroupCategory? boardGroupCategory});

  @override
  $UserProfileCopyWith<$Res>? get userProfile;
  @override
  $BoardGroupCategoryCopyWith<$Res>? get boardGroupCategory;
}

/// @nodoc
class __$$SectionItemImplCopyWithImpl<$Res>
    extends _$SectionItemCopyWithImpl<$Res, _$SectionItemImpl>
    implements _$$SectionItemImplCopyWith<$Res> {
  __$$SectionItemImplCopyWithImpl(
      _$SectionItemImpl _value, $Res Function(_$SectionItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? link = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? deleted = null,
    Object? reported = null,
    Object? isNew = null,
    Object? isExclusiveToHolders = null,
    Object? thumbnailImageUrl = freezed,
    Object? userProfile = freezed,
    Object? boardGroupCategory = freezed,
  }) {
    return _then(_$SectionItemImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      reported: null == reported
          ? _value.reported
          : reported // ignore: cast_nullable_to_non_nullable
              as bool,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      isExclusiveToHolders: null == isExclusiveToHolders
          ? _value.isExclusiveToHolders
          : isExclusiveToHolders // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnailImageUrl: freezed == thumbnailImageUrl
          ? _value.thumbnailImageUrl
          : thumbnailImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      boardGroupCategory: freezed == boardGroupCategory
          ? _value.boardGroupCategory
          : boardGroupCategory // ignore: cast_nullable_to_non_nullable
              as BoardGroupCategory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionItemImpl implements _SectionItem {
  const _$SectionItemImpl(
      {required this.title,
      required this.link,
      required this.createdAt,
      required this.updatedAt,
      this.viewCount = 0,
      this.likeCount = 0,
      this.commentCount = 0,
      this.deleted = false,
      this.reported = false,
      this.isNew = false,
      this.isExclusiveToHolders = false,
      this.thumbnailImageUrl,
      this.userProfile,
      @JsonKey(name: 'boardCategory') this.boardGroupCategory});

  factory _$SectionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionItemImplFromJson(json);

  @override
  final String title;
  @override
  final String link;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final int commentCount;
  @override
  @JsonKey()
  final bool deleted;
  @override
  @JsonKey()
  final bool reported;
  @override
  @JsonKey()
  final bool isNew;
  @override
  @JsonKey()
  final bool isExclusiveToHolders;
  @override
  final String? thumbnailImageUrl;
  @override
  final UserProfile? userProfile;
  @override
  @JsonKey(name: 'boardCategory')
  final BoardGroupCategory? boardGroupCategory;

  @override
  String toString() {
    return 'SectionItem(title: $title, link: $link, createdAt: $createdAt, updatedAt: $updatedAt, viewCount: $viewCount, likeCount: $likeCount, commentCount: $commentCount, deleted: $deleted, reported: $reported, isNew: $isNew, isExclusiveToHolders: $isExclusiveToHolders, thumbnailImageUrl: $thumbnailImageUrl, userProfile: $userProfile, boardGroupCategory: $boardGroupCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.deleted, deleted) || other.deleted == deleted) &&
            (identical(other.reported, reported) ||
                other.reported == reported) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.isExclusiveToHolders, isExclusiveToHolders) ||
                other.isExclusiveToHolders == isExclusiveToHolders) &&
            (identical(other.thumbnailImageUrl, thumbnailImageUrl) ||
                other.thumbnailImageUrl == thumbnailImageUrl) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.boardGroupCategory, boardGroupCategory) ||
                other.boardGroupCategory == boardGroupCategory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      link,
      createdAt,
      updatedAt,
      viewCount,
      likeCount,
      commentCount,
      deleted,
      reported,
      isNew,
      isExclusiveToHolders,
      thumbnailImageUrl,
      userProfile,
      boardGroupCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionItemImplCopyWith<_$SectionItemImpl> get copyWith =>
      __$$SectionItemImplCopyWithImpl<_$SectionItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionItemImplToJson(
      this,
    );
  }
}

abstract class _SectionItem implements SectionItem {
  const factory _SectionItem(
      {required final String title,
      required final String link,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final int viewCount,
      final int likeCount,
      final int commentCount,
      final bool deleted,
      final bool reported,
      final bool isNew,
      final bool isExclusiveToHolders,
      final String? thumbnailImageUrl,
      final UserProfile? userProfile,
      @JsonKey(name: 'boardCategory')
      final BoardGroupCategory? boardGroupCategory}) = _$SectionItemImpl;

  factory _SectionItem.fromJson(Map<String, dynamic> json) =
      _$SectionItemImpl.fromJson;

  @override
  String get title;
  @override
  String get link;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  int get viewCount;
  @override
  int get likeCount;
  @override
  int get commentCount;
  @override
  bool get deleted;
  @override
  bool get reported;
  @override
  bool get isNew;
  @override
  bool get isExclusiveToHolders;
  @override
  String? get thumbnailImageUrl;
  @override
  UserProfile? get userProfile;
  @override
  @JsonKey(name: 'boardCategory')
  BoardGroupCategory? get boardGroupCategory;
  @override
  @JsonKey(ignore: true)
  _$$SectionItemImplCopyWith<_$SectionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
