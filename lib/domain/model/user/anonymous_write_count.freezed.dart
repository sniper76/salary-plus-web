// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anonymous_write_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnonymousWriteCount _$AnonymousWriteCountFromJson(Map<String, dynamic> json) {
  return _AnonymousWriteCount.fromJson(json);
}

/// @nodoc
mixin _$AnonymousWriteCount {
  WriteCount get post => throw _privateConstructorUsedError;
  WriteCount get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnonymousWriteCountCopyWith<AnonymousWriteCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnonymousWriteCountCopyWith<$Res> {
  factory $AnonymousWriteCountCopyWith(
          AnonymousWriteCount value, $Res Function(AnonymousWriteCount) then) =
      _$AnonymousWriteCountCopyWithImpl<$Res, AnonymousWriteCount>;
  @useResult
  $Res call({WriteCount post, WriteCount comment});

  $WriteCountCopyWith<$Res> get post;
  $WriteCountCopyWith<$Res> get comment;
}

/// @nodoc
class _$AnonymousWriteCountCopyWithImpl<$Res, $Val extends AnonymousWriteCount>
    implements $AnonymousWriteCountCopyWith<$Res> {
  _$AnonymousWriteCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
    Object? comment = null,
  }) {
    return _then(_value.copyWith(
      post: null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as WriteCount,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as WriteCount,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WriteCountCopyWith<$Res> get post {
    return $WriteCountCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WriteCountCopyWith<$Res> get comment {
    return $WriteCountCopyWith<$Res>(_value.comment, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnonymousWriteCountImplCopyWith<$Res>
    implements $AnonymousWriteCountCopyWith<$Res> {
  factory _$$AnonymousWriteCountImplCopyWith(_$AnonymousWriteCountImpl value,
          $Res Function(_$AnonymousWriteCountImpl) then) =
      __$$AnonymousWriteCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WriteCount post, WriteCount comment});

  @override
  $WriteCountCopyWith<$Res> get post;
  @override
  $WriteCountCopyWith<$Res> get comment;
}

/// @nodoc
class __$$AnonymousWriteCountImplCopyWithImpl<$Res>
    extends _$AnonymousWriteCountCopyWithImpl<$Res, _$AnonymousWriteCountImpl>
    implements _$$AnonymousWriteCountImplCopyWith<$Res> {
  __$$AnonymousWriteCountImplCopyWithImpl(_$AnonymousWriteCountImpl _value,
      $Res Function(_$AnonymousWriteCountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
    Object? comment = null,
  }) {
    return _then(_$AnonymousWriteCountImpl(
      post: null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as WriteCount,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as WriteCount,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnonymousWriteCountImpl implements _AnonymousWriteCount {
  const _$AnonymousWriteCountImpl({required this.post, required this.comment});

  factory _$AnonymousWriteCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnonymousWriteCountImplFromJson(json);

  @override
  final WriteCount post;
  @override
  final WriteCount comment;

  @override
  String toString() {
    return 'AnonymousWriteCount(post: $post, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnonymousWriteCountImpl &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, post, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnonymousWriteCountImplCopyWith<_$AnonymousWriteCountImpl> get copyWith =>
      __$$AnonymousWriteCountImplCopyWithImpl<_$AnonymousWriteCountImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnonymousWriteCountImplToJson(
      this,
    );
  }
}

abstract class _AnonymousWriteCount implements AnonymousWriteCount {
  const factory _AnonymousWriteCount(
      {required final WriteCount post,
      required final WriteCount comment}) = _$AnonymousWriteCountImpl;

  factory _AnonymousWriteCount.fromJson(Map<String, dynamic> json) =
      _$AnonymousWriteCountImpl.fromJson;

  @override
  WriteCount get post;
  @override
  WriteCount get comment;
  @override
  @JsonKey(ignore: true)
  _$$AnonymousWriteCountImplCopyWith<_$AnonymousWriteCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
