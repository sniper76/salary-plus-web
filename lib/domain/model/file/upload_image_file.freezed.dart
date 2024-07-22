// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_image_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UploadImageFile _$UploadImageFileFromJson(Map<String, dynamic> json) {
  return _UploadImageFile.fromJson(json);
}

/// @nodoc
mixin _$UploadImageFile {
  int get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get originalFilename => throw _privateConstructorUsedError;
  String? get fileContentType => throw _privateConstructorUsedError;
  String? get fileType => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadImageFileCopyWith<UploadImageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadImageFileCopyWith<$Res> {
  factory $UploadImageFileCopyWith(
          UploadImageFile value, $Res Function(UploadImageFile) then) =
      _$UploadImageFileCopyWithImpl<$Res, UploadImageFile>;
  @useResult
  $Res call(
      {int id,
      String url,
      String originalFilename,
      String? fileContentType,
      String? fileType,
      String? description});
}

/// @nodoc
class _$UploadImageFileCopyWithImpl<$Res, $Val extends UploadImageFile>
    implements $UploadImageFileCopyWith<$Res> {
  _$UploadImageFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? originalFilename = null,
    Object? fileContentType = freezed,
    Object? fileType = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      originalFilename: null == originalFilename
          ? _value.originalFilename
          : originalFilename // ignore: cast_nullable_to_non_nullable
              as String,
      fileContentType: freezed == fileContentType
          ? _value.fileContentType
          : fileContentType // ignore: cast_nullable_to_non_nullable
              as String?,
      fileType: freezed == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UploadImageFileImplCopyWith<$Res>
    implements $UploadImageFileCopyWith<$Res> {
  factory _$$UploadImageFileImplCopyWith(_$UploadImageFileImpl value,
          $Res Function(_$UploadImageFileImpl) then) =
      __$$UploadImageFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String url,
      String originalFilename,
      String? fileContentType,
      String? fileType,
      String? description});
}

/// @nodoc
class __$$UploadImageFileImplCopyWithImpl<$Res>
    extends _$UploadImageFileCopyWithImpl<$Res, _$UploadImageFileImpl>
    implements _$$UploadImageFileImplCopyWith<$Res> {
  __$$UploadImageFileImplCopyWithImpl(
      _$UploadImageFileImpl _value, $Res Function(_$UploadImageFileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? originalFilename = null,
    Object? fileContentType = freezed,
    Object? fileType = freezed,
    Object? description = freezed,
  }) {
    return _then(_$UploadImageFileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      originalFilename: null == originalFilename
          ? _value.originalFilename
          : originalFilename // ignore: cast_nullable_to_non_nullable
              as String,
      fileContentType: freezed == fileContentType
          ? _value.fileContentType
          : fileContentType // ignore: cast_nullable_to_non_nullable
              as String?,
      fileType: freezed == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UploadImageFileImpl implements _UploadImageFile {
  const _$UploadImageFileImpl(
      {required this.id,
      required this.url,
      required this.originalFilename,
      this.fileContentType,
      this.fileType,
      this.description});

  factory _$UploadImageFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UploadImageFileImplFromJson(json);

  @override
  final int id;
  @override
  final String url;
  @override
  final String originalFilename;
  @override
  final String? fileContentType;
  @override
  final String? fileType;
  @override
  final String? description;

  @override
  String toString() {
    return 'UploadImageFile(id: $id, url: $url, originalFilename: $originalFilename, fileContentType: $fileContentType, fileType: $fileType, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadImageFileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.originalFilename, originalFilename) ||
                other.originalFilename == originalFilename) &&
            (identical(other.fileContentType, fileContentType) ||
                other.fileContentType == fileContentType) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, originalFilename,
      fileContentType, fileType, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadImageFileImplCopyWith<_$UploadImageFileImpl> get copyWith =>
      __$$UploadImageFileImplCopyWithImpl<_$UploadImageFileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UploadImageFileImplToJson(
      this,
    );
  }
}

abstract class _UploadImageFile implements UploadImageFile {
  const factory _UploadImageFile(
      {required final int id,
      required final String url,
      required final String originalFilename,
      final String? fileContentType,
      final String? fileType,
      final String? description}) = _$UploadImageFileImpl;

  factory _UploadImageFile.fromJson(Map<String, dynamic> json) =
      _$UploadImageFileImpl.fromJson;

  @override
  int get id;
  @override
  String get url;
  @override
  String get originalFilename;
  @override
  String? get fileContentType;
  @override
  String? get fileType;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$UploadImageFileImplCopyWith<_$UploadImageFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
