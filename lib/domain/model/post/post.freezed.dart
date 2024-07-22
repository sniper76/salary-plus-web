// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  UserProfile? get userProfile => throw _privateConstructorUsedError;
  @JsonKey(name: 'boardCategory')
  BoardGroupCategory? get boardGroupCategory =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown)
  BoardGroupType? get boardGroupType => throw _privateConstructorUsedError;
  Stock? get stock => throw _privateConstructorUsedError;
  int? get boardId => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  bool get liked => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;
  bool get reported => throw _privateConstructorUsedError;
  bool get isAuthorAdmin => throw _privateConstructorUsedError;
  bool get isExclusiveToHolders => throw _privateConstructorUsedError;
  bool get isNew => throw _privateConstructorUsedError;
  String? get thumbnailImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'postImageList')
  List<PostImage>? get postImages => throw _privateConstructorUsedError;
  List<Poll>? get polls => throw _privateConstructorUsedError;
  DigitalProxy? get digitalProxy => throw _privateConstructorUsedError;
  DigitalDocument? get digitalDocument => throw _privateConstructorUsedError;
  HolderListReadAndCopyDigitalDocument?
      get holderListReadAndCopyDigitalDocument =>
          throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {int id,
      String title,
      DateTime createdAt,
      DateTime updatedAt,
      String? content,
      UserProfile? userProfile,
      @JsonKey(name: 'boardCategory') BoardGroupCategory? boardGroupCategory,
      @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown)
      BoardGroupType? boardGroupType,
      Stock? stock,
      int? boardId,
      int? userId,
      int viewCount,
      int commentCount,
      int likeCount,
      bool liked,
      bool deleted,
      bool reported,
      bool isAuthorAdmin,
      bool isExclusiveToHolders,
      bool isNew,
      String? thumbnailImageUrl,
      @JsonKey(name: 'postImageList') List<PostImage>? postImages,
      List<Poll>? polls,
      DigitalProxy? digitalProxy,
      DigitalDocument? digitalDocument,
      HolderListReadAndCopyDigitalDocument?
          holderListReadAndCopyDigitalDocument});

  $UserProfileCopyWith<$Res>? get userProfile;
  $BoardGroupCategoryCopyWith<$Res>? get boardGroupCategory;
  $StockCopyWith<$Res>? get stock;
  $HolderListReadAndCopyDigitalDocumentCopyWith<$Res>?
      get holderListReadAndCopyDigitalDocument;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? content = freezed,
    Object? userProfile = freezed,
    Object? boardGroupCategory = freezed,
    Object? boardGroupType = freezed,
    Object? stock = freezed,
    Object? boardId = freezed,
    Object? userId = freezed,
    Object? viewCount = null,
    Object? commentCount = null,
    Object? likeCount = null,
    Object? liked = null,
    Object? deleted = null,
    Object? reported = null,
    Object? isAuthorAdmin = null,
    Object? isExclusiveToHolders = null,
    Object? isNew = null,
    Object? thumbnailImageUrl = freezed,
    Object? postImages = freezed,
    Object? polls = freezed,
    Object? digitalProxy = freezed,
    Object? digitalDocument = freezed,
    Object? holderListReadAndCopyDigitalDocument = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      boardGroupCategory: freezed == boardGroupCategory
          ? _value.boardGroupCategory
          : boardGroupCategory // ignore: cast_nullable_to_non_nullable
              as BoardGroupCategory?,
      boardGroupType: freezed == boardGroupType
          ? _value.boardGroupType
          : boardGroupType // ignore: cast_nullable_to_non_nullable
              as BoardGroupType?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as Stock?,
      boardId: freezed == boardId
          ? _value.boardId
          : boardId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      liked: null == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      reported: null == reported
          ? _value.reported
          : reported // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthorAdmin: null == isAuthorAdmin
          ? _value.isAuthorAdmin
          : isAuthorAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isExclusiveToHolders: null == isExclusiveToHolders
          ? _value.isExclusiveToHolders
          : isExclusiveToHolders // ignore: cast_nullable_to_non_nullable
              as bool,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnailImageUrl: freezed == thumbnailImageUrl
          ? _value.thumbnailImageUrl
          : thumbnailImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      postImages: freezed == postImages
          ? _value.postImages
          : postImages // ignore: cast_nullable_to_non_nullable
              as List<PostImage>?,
      polls: freezed == polls
          ? _value.polls
          : polls // ignore: cast_nullable_to_non_nullable
              as List<Poll>?,
      digitalProxy: freezed == digitalProxy
          ? _value.digitalProxy
          : digitalProxy // ignore: cast_nullable_to_non_nullable
              as DigitalProxy?,
      digitalDocument: freezed == digitalDocument
          ? _value.digitalDocument
          : digitalDocument // ignore: cast_nullable_to_non_nullable
              as DigitalDocument?,
      holderListReadAndCopyDigitalDocument: freezed ==
              holderListReadAndCopyDigitalDocument
          ? _value.holderListReadAndCopyDigitalDocument
          : holderListReadAndCopyDigitalDocument // ignore: cast_nullable_to_non_nullable
              as HolderListReadAndCopyDigitalDocument?,
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

  @override
  @pragma('vm:prefer-inline')
  $StockCopyWith<$Res>? get stock {
    if (_value.stock == null) {
      return null;
    }

    return $StockCopyWith<$Res>(_value.stock!, (value) {
      return _then(_value.copyWith(stock: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HolderListReadAndCopyDigitalDocumentCopyWith<$Res>?
      get holderListReadAndCopyDigitalDocument {
    if (_value.holderListReadAndCopyDigitalDocument == null) {
      return null;
    }

    return $HolderListReadAndCopyDigitalDocumentCopyWith<$Res>(
        _value.holderListReadAndCopyDigitalDocument!, (value) {
      return _then(
          _value.copyWith(holderListReadAndCopyDigitalDocument: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      DateTime createdAt,
      DateTime updatedAt,
      String? content,
      UserProfile? userProfile,
      @JsonKey(name: 'boardCategory') BoardGroupCategory? boardGroupCategory,
      @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown)
      BoardGroupType? boardGroupType,
      Stock? stock,
      int? boardId,
      int? userId,
      int viewCount,
      int commentCount,
      int likeCount,
      bool liked,
      bool deleted,
      bool reported,
      bool isAuthorAdmin,
      bool isExclusiveToHolders,
      bool isNew,
      String? thumbnailImageUrl,
      @JsonKey(name: 'postImageList') List<PostImage>? postImages,
      List<Poll>? polls,
      DigitalProxy? digitalProxy,
      DigitalDocument? digitalDocument,
      HolderListReadAndCopyDigitalDocument?
          holderListReadAndCopyDigitalDocument});

  @override
  $UserProfileCopyWith<$Res>? get userProfile;
  @override
  $BoardGroupCategoryCopyWith<$Res>? get boardGroupCategory;
  @override
  $StockCopyWith<$Res>? get stock;
  @override
  $HolderListReadAndCopyDigitalDocumentCopyWith<$Res>?
      get holderListReadAndCopyDigitalDocument;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? content = freezed,
    Object? userProfile = freezed,
    Object? boardGroupCategory = freezed,
    Object? boardGroupType = freezed,
    Object? stock = freezed,
    Object? boardId = freezed,
    Object? userId = freezed,
    Object? viewCount = null,
    Object? commentCount = null,
    Object? likeCount = null,
    Object? liked = null,
    Object? deleted = null,
    Object? reported = null,
    Object? isAuthorAdmin = null,
    Object? isExclusiveToHolders = null,
    Object? isNew = null,
    Object? thumbnailImageUrl = freezed,
    Object? postImages = freezed,
    Object? polls = freezed,
    Object? digitalProxy = freezed,
    Object? digitalDocument = freezed,
    Object? holderListReadAndCopyDigitalDocument = freezed,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      boardGroupCategory: freezed == boardGroupCategory
          ? _value.boardGroupCategory
          : boardGroupCategory // ignore: cast_nullable_to_non_nullable
              as BoardGroupCategory?,
      boardGroupType: freezed == boardGroupType
          ? _value.boardGroupType
          : boardGroupType // ignore: cast_nullable_to_non_nullable
              as BoardGroupType?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as Stock?,
      boardId: freezed == boardId
          ? _value.boardId
          : boardId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      liked: null == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      reported: null == reported
          ? _value.reported
          : reported // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthorAdmin: null == isAuthorAdmin
          ? _value.isAuthorAdmin
          : isAuthorAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isExclusiveToHolders: null == isExclusiveToHolders
          ? _value.isExclusiveToHolders
          : isExclusiveToHolders // ignore: cast_nullable_to_non_nullable
              as bool,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnailImageUrl: freezed == thumbnailImageUrl
          ? _value.thumbnailImageUrl
          : thumbnailImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      postImages: freezed == postImages
          ? _value._postImages
          : postImages // ignore: cast_nullable_to_non_nullable
              as List<PostImage>?,
      polls: freezed == polls
          ? _value._polls
          : polls // ignore: cast_nullable_to_non_nullable
              as List<Poll>?,
      digitalProxy: freezed == digitalProxy
          ? _value.digitalProxy
          : digitalProxy // ignore: cast_nullable_to_non_nullable
              as DigitalProxy?,
      digitalDocument: freezed == digitalDocument
          ? _value.digitalDocument
          : digitalDocument // ignore: cast_nullable_to_non_nullable
              as DigitalDocument?,
      holderListReadAndCopyDigitalDocument: freezed ==
              holderListReadAndCopyDigitalDocument
          ? _value.holderListReadAndCopyDigitalDocument
          : holderListReadAndCopyDigitalDocument // ignore: cast_nullable_to_non_nullable
              as HolderListReadAndCopyDigitalDocument?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl extends _Post {
  const _$PostImpl(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.updatedAt,
      this.content,
      this.userProfile,
      @JsonKey(name: 'boardCategory') this.boardGroupCategory,
      @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown)
      this.boardGroupType,
      this.stock,
      this.boardId,
      this.userId,
      this.viewCount = 0,
      this.commentCount = 0,
      this.likeCount = 0,
      this.liked = false,
      this.deleted = false,
      this.reported = false,
      this.isAuthorAdmin = false,
      this.isExclusiveToHolders = false,
      this.isNew = false,
      this.thumbnailImageUrl,
      @JsonKey(name: 'postImageList') final List<PostImage>? postImages,
      final List<Poll>? polls = const [],
      this.digitalProxy,
      this.digitalDocument,
      this.holderListReadAndCopyDigitalDocument})
      : _postImages = postImages,
        _polls = polls,
        super._();

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? content;
  @override
  final UserProfile? userProfile;
  @override
  @JsonKey(name: 'boardCategory')
  final BoardGroupCategory? boardGroupCategory;
  @override
  @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown)
  final BoardGroupType? boardGroupType;
  @override
  final Stock? stock;
  @override
  final int? boardId;
  @override
  final int? userId;
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int commentCount;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final bool liked;
  @override
  @JsonKey()
  final bool deleted;
  @override
  @JsonKey()
  final bool reported;
  @override
  @JsonKey()
  final bool isAuthorAdmin;
  @override
  @JsonKey()
  final bool isExclusiveToHolders;
  @override
  @JsonKey()
  final bool isNew;
  @override
  final String? thumbnailImageUrl;
  final List<PostImage>? _postImages;
  @override
  @JsonKey(name: 'postImageList')
  List<PostImage>? get postImages {
    final value = _postImages;
    if (value == null) return null;
    if (_postImages is EqualUnmodifiableListView) return _postImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Poll>? _polls;
  @override
  @JsonKey()
  List<Poll>? get polls {
    final value = _polls;
    if (value == null) return null;
    if (_polls is EqualUnmodifiableListView) return _polls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DigitalProxy? digitalProxy;
  @override
  final DigitalDocument? digitalDocument;
  @override
  final HolderListReadAndCopyDigitalDocument?
      holderListReadAndCopyDigitalDocument;

  @override
  String toString() {
    return 'Post(id: $id, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, content: $content, userProfile: $userProfile, boardGroupCategory: $boardGroupCategory, boardGroupType: $boardGroupType, stock: $stock, boardId: $boardId, userId: $userId, viewCount: $viewCount, commentCount: $commentCount, likeCount: $likeCount, liked: $liked, deleted: $deleted, reported: $reported, isAuthorAdmin: $isAuthorAdmin, isExclusiveToHolders: $isExclusiveToHolders, isNew: $isNew, thumbnailImageUrl: $thumbnailImageUrl, postImages: $postImages, polls: $polls, digitalProxy: $digitalProxy, digitalDocument: $digitalDocument, holderListReadAndCopyDigitalDocument: $holderListReadAndCopyDigitalDocument)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.boardGroupCategory, boardGroupCategory) ||
                other.boardGroupCategory == boardGroupCategory) &&
            (identical(other.boardGroupType, boardGroupType) ||
                other.boardGroupType == boardGroupType) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.liked, liked) || other.liked == liked) &&
            (identical(other.deleted, deleted) || other.deleted == deleted) &&
            (identical(other.reported, reported) ||
                other.reported == reported) &&
            (identical(other.isAuthorAdmin, isAuthorAdmin) ||
                other.isAuthorAdmin == isAuthorAdmin) &&
            (identical(other.isExclusiveToHolders, isExclusiveToHolders) ||
                other.isExclusiveToHolders == isExclusiveToHolders) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.thumbnailImageUrl, thumbnailImageUrl) ||
                other.thumbnailImageUrl == thumbnailImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._postImages, _postImages) &&
            const DeepCollectionEquality().equals(other._polls, _polls) &&
            const DeepCollectionEquality()
                .equals(other.digitalProxy, digitalProxy) &&
            const DeepCollectionEquality()
                .equals(other.digitalDocument, digitalDocument) &&
            (identical(other.holderListReadAndCopyDigitalDocument,
                    holderListReadAndCopyDigitalDocument) ||
                other.holderListReadAndCopyDigitalDocument ==
                    holderListReadAndCopyDigitalDocument));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        createdAt,
        updatedAt,
        content,
        userProfile,
        boardGroupCategory,
        boardGroupType,
        stock,
        boardId,
        userId,
        viewCount,
        commentCount,
        likeCount,
        liked,
        deleted,
        reported,
        isAuthorAdmin,
        isExclusiveToHolders,
        isNew,
        thumbnailImageUrl,
        const DeepCollectionEquality().hash(_postImages),
        const DeepCollectionEquality().hash(_polls),
        const DeepCollectionEquality().hash(digitalProxy),
        const DeepCollectionEquality().hash(digitalDocument),
        holderListReadAndCopyDigitalDocument
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post extends Post {
  const factory _Post(
      {required final int id,
      required final String title,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? content,
      final UserProfile? userProfile,
      @JsonKey(name: 'boardCategory')
      final BoardGroupCategory? boardGroupCategory,
      @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown)
      final BoardGroupType? boardGroupType,
      final Stock? stock,
      final int? boardId,
      final int? userId,
      final int viewCount,
      final int commentCount,
      final int likeCount,
      final bool liked,
      final bool deleted,
      final bool reported,
      final bool isAuthorAdmin,
      final bool isExclusiveToHolders,
      final bool isNew,
      final String? thumbnailImageUrl,
      @JsonKey(name: 'postImageList') final List<PostImage>? postImages,
      final List<Poll>? polls,
      final DigitalProxy? digitalProxy,
      final DigitalDocument? digitalDocument,
      final HolderListReadAndCopyDigitalDocument?
          holderListReadAndCopyDigitalDocument}) = _$PostImpl;
  const _Post._() : super._();

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get content;
  @override
  UserProfile? get userProfile;
  @override
  @JsonKey(name: 'boardCategory')
  BoardGroupCategory? get boardGroupCategory;
  @override
  @JsonKey(name: 'boardGroup', unknownEnumValue: BoardGroupType.unknown)
  BoardGroupType? get boardGroupType;
  @override
  Stock? get stock;
  @override
  int? get boardId;
  @override
  int? get userId;
  @override
  int get viewCount;
  @override
  int get commentCount;
  @override
  int get likeCount;
  @override
  bool get liked;
  @override
  bool get deleted;
  @override
  bool get reported;
  @override
  bool get isAuthorAdmin;
  @override
  bool get isExclusiveToHolders;
  @override
  bool get isNew;
  @override
  String? get thumbnailImageUrl;
  @override
  @JsonKey(name: 'postImageList')
  List<PostImage>? get postImages;
  @override
  List<Poll>? get polls;
  @override
  DigitalProxy? get digitalProxy;
  @override
  DigitalDocument? get digitalDocument;
  @override
  HolderListReadAndCopyDigitalDocument?
      get holderListReadAndCopyDigitalDocument;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
