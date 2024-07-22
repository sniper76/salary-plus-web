// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _contentFromJson)
  String get content => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  UserProfile? get userProfile => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;
  bool get reported => throw _privateConstructorUsedError;
  bool get liked => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get replyCommentCount => throw _privateConstructorUsedError;
  List<Comment> get replyComments => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get editedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(fromJson: _contentFromJson) String content,
      int userId,
      UserProfile? userProfile,
      bool deleted,
      bool reported,
      bool liked,
      int likeCount,
      int replyCommentCount,
      List<Comment> replyComments,
      DateTime createdAt,
      DateTime editedAt});

  $UserProfileCopyWith<$Res>? get userProfile;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? userId = null,
    Object? userProfile = freezed,
    Object? deleted = null,
    Object? reported = null,
    Object? liked = null,
    Object? likeCount = null,
    Object? replyCommentCount = null,
    Object? replyComments = null,
    Object? createdAt = null,
    Object? editedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      reported: null == reported
          ? _value.reported
          : reported // ignore: cast_nullable_to_non_nullable
              as bool,
      liked: null == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      replyCommentCount: null == replyCommentCount
          ? _value.replyCommentCount
          : replyCommentCount // ignore: cast_nullable_to_non_nullable
              as int,
      replyComments: null == replyComments
          ? _value.replyComments
          : replyComments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      editedAt: null == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(fromJson: _contentFromJson) String content,
      int userId,
      UserProfile? userProfile,
      bool deleted,
      bool reported,
      bool liked,
      int likeCount,
      int replyCommentCount,
      List<Comment> replyComments,
      DateTime createdAt,
      DateTime editedAt});

  @override
  $UserProfileCopyWith<$Res>? get userProfile;
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? userId = null,
    Object? userProfile = freezed,
    Object? deleted = null,
    Object? reported = null,
    Object? liked = null,
    Object? likeCount = null,
    Object? replyCommentCount = null,
    Object? replyComments = null,
    Object? createdAt = null,
    Object? editedAt = null,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      reported: null == reported
          ? _value.reported
          : reported // ignore: cast_nullable_to_non_nullable
              as bool,
      liked: null == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      replyCommentCount: null == replyCommentCount
          ? _value.replyCommentCount
          : replyCommentCount // ignore: cast_nullable_to_non_nullable
              as int,
      replyComments: null == replyComments
          ? _value._replyComments
          : replyComments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      editedAt: null == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl extends _Comment {
  const _$CommentImpl(
      {required this.id,
      @JsonKey(fromJson: _contentFromJson) required this.content,
      required this.userId,
      this.userProfile,
      this.deleted = false,
      this.reported = false,
      this.liked = false,
      this.likeCount = 0,
      this.replyCommentCount = 0,
      final List<Comment> replyComments = const [],
      required this.createdAt,
      required this.editedAt})
      : _replyComments = replyComments,
        super._();

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(fromJson: _contentFromJson)
  final String content;
  @override
  final int userId;
  @override
  final UserProfile? userProfile;
  @override
  @JsonKey()
  final bool deleted;
  @override
  @JsonKey()
  final bool reported;
  @override
  @JsonKey()
  final bool liked;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final int replyCommentCount;
  final List<Comment> _replyComments;
  @override
  @JsonKey()
  List<Comment> get replyComments {
    if (_replyComments is EqualUnmodifiableListView) return _replyComments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replyComments);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime editedAt;

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, userId: $userId, userProfile: $userProfile, deleted: $deleted, reported: $reported, liked: $liked, likeCount: $likeCount, replyCommentCount: $replyCommentCount, replyComments: $replyComments, createdAt: $createdAt, editedAt: $editedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.deleted, deleted) || other.deleted == deleted) &&
            (identical(other.reported, reported) ||
                other.reported == reported) &&
            (identical(other.liked, liked) || other.liked == liked) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.replyCommentCount, replyCommentCount) ||
                other.replyCommentCount == replyCommentCount) &&
            const DeepCollectionEquality()
                .equals(other._replyComments, _replyComments) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      content,
      userId,
      userProfile,
      deleted,
      reported,
      liked,
      likeCount,
      replyCommentCount,
      const DeepCollectionEquality().hash(_replyComments),
      createdAt,
      editedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment extends Comment {
  const factory _Comment(
      {required final int id,
      @JsonKey(fromJson: _contentFromJson) required final String content,
      required final int userId,
      final UserProfile? userProfile,
      final bool deleted,
      final bool reported,
      final bool liked,
      final int likeCount,
      final int replyCommentCount,
      final List<Comment> replyComments,
      required final DateTime createdAt,
      required final DateTime editedAt}) = _$CommentImpl;
  const _Comment._() : super._();

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(fromJson: _contentFromJson)
  String get content;
  @override
  int get userId;
  @override
  UserProfile? get userProfile;
  @override
  bool get deleted;
  @override
  bool get reported;
  @override
  bool get liked;
  @override
  int get likeCount;
  @override
  int get replyCommentCount;
  @override
  List<Comment> get replyComments;
  @override
  DateTime get createdAt;
  @override
  DateTime get editedAt;
  @override
  @JsonKey(ignore: true)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
