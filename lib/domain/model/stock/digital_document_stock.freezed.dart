// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_document_stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DigitalDocumentStock _$DigitalDocumentStockFromJson(Map<String, dynamic> json) {
  return _DigitalDocumentStock.fromJson(json);
}

/// @nodoc
mixin _$DigitalDocumentStock {
  String get code => throw _privateConstructorUsedError;
  String get standardCode => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime? get referenceDate => throw _privateConstructorUsedError;
  int? get referenceDateStockCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DigitalDocumentStockCopyWith<DigitalDocumentStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DigitalDocumentStockCopyWith<$Res> {
  factory $DigitalDocumentStockCopyWith(DigitalDocumentStock value,
          $Res Function(DigitalDocumentStock) then) =
      _$DigitalDocumentStockCopyWithImpl<$Res, DigitalDocumentStock>;
  @useResult
  $Res call(
      {String code,
      String standardCode,
      String name,
      DateTime? referenceDate,
      int? referenceDateStockCount});
}

/// @nodoc
class _$DigitalDocumentStockCopyWithImpl<$Res,
        $Val extends DigitalDocumentStock>
    implements $DigitalDocumentStockCopyWith<$Res> {
  _$DigitalDocumentStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? standardCode = null,
    Object? name = null,
    Object? referenceDate = freezed,
    Object? referenceDateStockCount = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      standardCode: null == standardCode
          ? _value.standardCode
          : standardCode // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      referenceDate: freezed == referenceDate
          ? _value.referenceDate
          : referenceDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      referenceDateStockCount: freezed == referenceDateStockCount
          ? _value.referenceDateStockCount
          : referenceDateStockCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DigitalDocumentStockImplCopyWith<$Res>
    implements $DigitalDocumentStockCopyWith<$Res> {
  factory _$$DigitalDocumentStockImplCopyWith(_$DigitalDocumentStockImpl value,
          $Res Function(_$DigitalDocumentStockImpl) then) =
      __$$DigitalDocumentStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String standardCode,
      String name,
      DateTime? referenceDate,
      int? referenceDateStockCount});
}

/// @nodoc
class __$$DigitalDocumentStockImplCopyWithImpl<$Res>
    extends _$DigitalDocumentStockCopyWithImpl<$Res, _$DigitalDocumentStockImpl>
    implements _$$DigitalDocumentStockImplCopyWith<$Res> {
  __$$DigitalDocumentStockImplCopyWithImpl(_$DigitalDocumentStockImpl _value,
      $Res Function(_$DigitalDocumentStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? standardCode = null,
    Object? name = null,
    Object? referenceDate = freezed,
    Object? referenceDateStockCount = freezed,
  }) {
    return _then(_$DigitalDocumentStockImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      standardCode: null == standardCode
          ? _value.standardCode
          : standardCode // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      referenceDate: freezed == referenceDate
          ? _value.referenceDate
          : referenceDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      referenceDateStockCount: freezed == referenceDateStockCount
          ? _value.referenceDateStockCount
          : referenceDateStockCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalDocumentStockImpl extends _DigitalDocumentStock {
  const _$DigitalDocumentStockImpl(
      {required this.code,
      required this.standardCode,
      required this.name,
      this.referenceDate,
      this.referenceDateStockCount = 0})
      : super._();

  factory _$DigitalDocumentStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalDocumentStockImplFromJson(json);

  @override
  final String code;
  @override
  final String standardCode;
  @override
  final String name;
  @override
  final DateTime? referenceDate;
  @override
  @JsonKey()
  final int? referenceDateStockCount;

  @override
  String toString() {
    return 'DigitalDocumentStock(code: $code, standardCode: $standardCode, name: $name, referenceDate: $referenceDate, referenceDateStockCount: $referenceDateStockCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalDocumentStockImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.standardCode, standardCode) ||
                other.standardCode == standardCode) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.referenceDate, referenceDate) ||
                other.referenceDate == referenceDate) &&
            (identical(
                    other.referenceDateStockCount, referenceDateStockCount) ||
                other.referenceDateStockCount == referenceDateStockCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, standardCode, name,
      referenceDate, referenceDateStockCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalDocumentStockImplCopyWith<_$DigitalDocumentStockImpl>
      get copyWith =>
          __$$DigitalDocumentStockImplCopyWithImpl<_$DigitalDocumentStockImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalDocumentStockImplToJson(
      this,
    );
  }
}

abstract class _DigitalDocumentStock extends DigitalDocumentStock {
  const factory _DigitalDocumentStock(
      {required final String code,
      required final String standardCode,
      required final String name,
      final DateTime? referenceDate,
      final int? referenceDateStockCount}) = _$DigitalDocumentStockImpl;
  const _DigitalDocumentStock._() : super._();

  factory _DigitalDocumentStock.fromJson(Map<String, dynamic> json) =
      _$DigitalDocumentStockImpl.fromJson;

  @override
  String get code;
  @override
  String get standardCode;
  @override
  String get name;
  @override
  DateTime? get referenceDate;
  @override
  int? get referenceDateStockCount;
  @override
  @JsonKey(ignore: true)
  _$$DigitalDocumentStockImplCopyWith<_$DigitalDocumentStockImpl>
      get copyWith => throw _privateConstructorUsedError;
}
