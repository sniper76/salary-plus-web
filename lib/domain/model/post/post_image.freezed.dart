// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostImage _$PostImageFromJson(Map<String, dynamic> json) {
  return _PostImage.fromJson(json);
}

/// @nodoc
mixin _$PostImage {
  int get imageId => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostImageCopyWith<PostImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostImageCopyWith<$Res> {
  factory $PostImageCopyWith(PostImage value, $Res Function(PostImage) then) =
      _$PostImageCopyWithImpl<$Res, PostImage>;
  @useResult
  $Res call({int imageId, String imageUrl});
}

/// @nodoc
class _$PostImageCopyWithImpl<$Res, $Val extends PostImage>
    implements $PostImageCopyWith<$Res> {
  _$PostImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageId = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      imageId: null == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImageImplCopyWith<$Res>
    implements $PostImageCopyWith<$Res> {
  factory _$$PostImageImplCopyWith(
          _$PostImageImpl value, $Res Function(_$PostImageImpl) then) =
      __$$PostImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int imageId, String imageUrl});
}

/// @nodoc
class __$$PostImageImplCopyWithImpl<$Res>
    extends _$PostImageCopyWithImpl<$Res, _$PostImageImpl>
    implements _$$PostImageImplCopyWith<$Res> {
  __$$PostImageImplCopyWithImpl(
      _$PostImageImpl _value, $Res Function(_$PostImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageId = null,
    Object? imageUrl = null,
  }) {
    return _then(_$PostImageImpl(
      imageId: null == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImageImpl implements _PostImage {
  const _$PostImageImpl({required this.imageId, required this.imageUrl});

  factory _$PostImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImageImplFromJson(json);

  @override
  final int imageId;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'PostImage(imageId: $imageId, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImageImpl &&
            (identical(other.imageId, imageId) || other.imageId == imageId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imageId, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImageImplCopyWith<_$PostImageImpl> get copyWith =>
      __$$PostImageImplCopyWithImpl<_$PostImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImageImplToJson(
      this,
    );
  }
}

abstract class _PostImage implements PostImage {
  const factory _PostImage(
      {required final int imageId,
      required final String imageUrl}) = _$PostImageImpl;

  factory _PostImage.fromJson(Map<String, dynamic> json) =
      _$PostImageImpl.fromJson;

  @override
  int get imageId;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$PostImageImplCopyWith<_$PostImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
