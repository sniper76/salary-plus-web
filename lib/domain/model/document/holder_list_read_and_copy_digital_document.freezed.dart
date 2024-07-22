// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holder_list_read_and_copy_digital_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HolderListReadAndCopyDigitalDocument
    _$HolderListReadAndCopyDigitalDocumentFromJson(Map<String, dynamic> json) {
  return _HolderListReadAndCopyDigitalDocument.fromJson(json);
}

/// @nodoc
mixin _$HolderListReadAndCopyDigitalDocument {
  int get digitalDocumentId => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HolderListReadAndCopyDigitalDocumentCopyWith<
          HolderListReadAndCopyDigitalDocument>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolderListReadAndCopyDigitalDocumentCopyWith<$Res> {
  factory $HolderListReadAndCopyDigitalDocumentCopyWith(
          HolderListReadAndCopyDigitalDocument value,
          $Res Function(HolderListReadAndCopyDigitalDocument) then) =
      _$HolderListReadAndCopyDigitalDocumentCopyWithImpl<$Res,
          HolderListReadAndCopyDigitalDocument>;
  @useResult
  $Res call({int digitalDocumentId, String fileName});
}

/// @nodoc
class _$HolderListReadAndCopyDigitalDocumentCopyWithImpl<$Res,
        $Val extends HolderListReadAndCopyDigitalDocument>
    implements $HolderListReadAndCopyDigitalDocumentCopyWith<$Res> {
  _$HolderListReadAndCopyDigitalDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? digitalDocumentId = null,
    Object? fileName = null,
  }) {
    return _then(_value.copyWith(
      digitalDocumentId: null == digitalDocumentId
          ? _value.digitalDocumentId
          : digitalDocumentId // ignore: cast_nullable_to_non_nullable
              as int,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HolderListReadAndCopyDigitalDocumentImplCopyWith<$Res>
    implements $HolderListReadAndCopyDigitalDocumentCopyWith<$Res> {
  factory _$$HolderListReadAndCopyDigitalDocumentImplCopyWith(
          _$HolderListReadAndCopyDigitalDocumentImpl value,
          $Res Function(_$HolderListReadAndCopyDigitalDocumentImpl) then) =
      __$$HolderListReadAndCopyDigitalDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int digitalDocumentId, String fileName});
}

/// @nodoc
class __$$HolderListReadAndCopyDigitalDocumentImplCopyWithImpl<$Res>
    extends _$HolderListReadAndCopyDigitalDocumentCopyWithImpl<$Res,
        _$HolderListReadAndCopyDigitalDocumentImpl>
    implements _$$HolderListReadAndCopyDigitalDocumentImplCopyWith<$Res> {
  __$$HolderListReadAndCopyDigitalDocumentImplCopyWithImpl(
      _$HolderListReadAndCopyDigitalDocumentImpl _value,
      $Res Function(_$HolderListReadAndCopyDigitalDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? digitalDocumentId = null,
    Object? fileName = null,
  }) {
    return _then(_$HolderListReadAndCopyDigitalDocumentImpl(
      digitalDocumentId: null == digitalDocumentId
          ? _value.digitalDocumentId
          : digitalDocumentId // ignore: cast_nullable_to_non_nullable
              as int,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HolderListReadAndCopyDigitalDocumentImpl
    extends _HolderListReadAndCopyDigitalDocument {
  const _$HolderListReadAndCopyDigitalDocumentImpl(
      {required this.digitalDocumentId, required this.fileName})
      : super._();

  factory _$HolderListReadAndCopyDigitalDocumentImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$HolderListReadAndCopyDigitalDocumentImplFromJson(json);

  @override
  final int digitalDocumentId;
  @override
  final String fileName;

  @override
  String toString() {
    return 'HolderListReadAndCopyDigitalDocument(digitalDocumentId: $digitalDocumentId, fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolderListReadAndCopyDigitalDocumentImpl &&
            (identical(other.digitalDocumentId, digitalDocumentId) ||
                other.digitalDocumentId == digitalDocumentId) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, digitalDocumentId, fileName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HolderListReadAndCopyDigitalDocumentImplCopyWith<
          _$HolderListReadAndCopyDigitalDocumentImpl>
      get copyWith => __$$HolderListReadAndCopyDigitalDocumentImplCopyWithImpl<
          _$HolderListReadAndCopyDigitalDocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HolderListReadAndCopyDigitalDocumentImplToJson(
      this,
    );
  }
}

abstract class _HolderListReadAndCopyDigitalDocument
    extends HolderListReadAndCopyDigitalDocument {
  const factory _HolderListReadAndCopyDigitalDocument(
          {required final int digitalDocumentId,
          required final String fileName}) =
      _$HolderListReadAndCopyDigitalDocumentImpl;
  const _HolderListReadAndCopyDigitalDocument._() : super._();

  factory _HolderListReadAndCopyDigitalDocument.fromJson(
          Map<String, dynamic> json) =
      _$HolderListReadAndCopyDigitalDocumentImpl.fromJson;

  @override
  int get digitalDocumentId;
  @override
  String get fileName;
  @override
  @JsonKey(ignore: true)
  _$$HolderListReadAndCopyDigitalDocumentImplCopyWith<
          _$HolderListReadAndCopyDigitalDocumentImpl>
      get copyWith => throw _privateConstructorUsedError;
}
