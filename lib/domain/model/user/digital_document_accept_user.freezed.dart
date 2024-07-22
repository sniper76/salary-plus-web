// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_document_accept_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DigitalDocumentAcceptUser _$DigitalDocumentAcceptUserFromJson(
    Map<String, dynamic> json) {
  return _DigitalDocumentAcceptUser.fromJson(json);
}

/// @nodoc
mixin _$DigitalDocumentAcceptUser {
  String get name => throw _privateConstructorUsedError;
  DateTime get birthDate => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String? get corporateNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DigitalDocumentAcceptUserCopyWith<DigitalDocumentAcceptUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DigitalDocumentAcceptUserCopyWith<$Res> {
  factory $DigitalDocumentAcceptUserCopyWith(DigitalDocumentAcceptUser value,
          $Res Function(DigitalDocumentAcceptUser) then) =
      _$DigitalDocumentAcceptUserCopyWithImpl<$Res, DigitalDocumentAcceptUser>;
  @useResult
  $Res call(
      {String name,
      DateTime birthDate,
      String phoneNumber,
      String? corporateNo});
}

/// @nodoc
class _$DigitalDocumentAcceptUserCopyWithImpl<$Res,
        $Val extends DigitalDocumentAcceptUser>
    implements $DigitalDocumentAcceptUserCopyWith<$Res> {
  _$DigitalDocumentAcceptUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? birthDate = null,
    Object? phoneNumber = null,
    Object? corporateNo = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      corporateNo: freezed == corporateNo
          ? _value.corporateNo
          : corporateNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DigitalDocumentAcceptUserImplCopyWith<$Res>
    implements $DigitalDocumentAcceptUserCopyWith<$Res> {
  factory _$$DigitalDocumentAcceptUserImplCopyWith(
          _$DigitalDocumentAcceptUserImpl value,
          $Res Function(_$DigitalDocumentAcceptUserImpl) then) =
      __$$DigitalDocumentAcceptUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      DateTime birthDate,
      String phoneNumber,
      String? corporateNo});
}

/// @nodoc
class __$$DigitalDocumentAcceptUserImplCopyWithImpl<$Res>
    extends _$DigitalDocumentAcceptUserCopyWithImpl<$Res,
        _$DigitalDocumentAcceptUserImpl>
    implements _$$DigitalDocumentAcceptUserImplCopyWith<$Res> {
  __$$DigitalDocumentAcceptUserImplCopyWithImpl(
      _$DigitalDocumentAcceptUserImpl _value,
      $Res Function(_$DigitalDocumentAcceptUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? birthDate = null,
    Object? phoneNumber = null,
    Object? corporateNo = freezed,
  }) {
    return _then(_$DigitalDocumentAcceptUserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      corporateNo: freezed == corporateNo
          ? _value.corporateNo
          : corporateNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalDocumentAcceptUserImpl implements _DigitalDocumentAcceptUser {
  const _$DigitalDocumentAcceptUserImpl(
      {required this.name,
      required this.birthDate,
      required this.phoneNumber,
      this.corporateNo});

  factory _$DigitalDocumentAcceptUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalDocumentAcceptUserImplFromJson(json);

  @override
  final String name;
  @override
  final DateTime birthDate;
  @override
  final String phoneNumber;
  @override
  final String? corporateNo;

  @override
  String toString() {
    return 'DigitalDocumentAcceptUser(name: $name, birthDate: $birthDate, phoneNumber: $phoneNumber, corporateNo: $corporateNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalDocumentAcceptUserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.corporateNo, corporateNo) ||
                other.corporateNo == corporateNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, birthDate, phoneNumber, corporateNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalDocumentAcceptUserImplCopyWith<_$DigitalDocumentAcceptUserImpl>
      get copyWith => __$$DigitalDocumentAcceptUserImplCopyWithImpl<
          _$DigitalDocumentAcceptUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalDocumentAcceptUserImplToJson(
      this,
    );
  }
}

abstract class _DigitalDocumentAcceptUser implements DigitalDocumentAcceptUser {
  const factory _DigitalDocumentAcceptUser(
      {required final String name,
      required final DateTime birthDate,
      required final String phoneNumber,
      final String? corporateNo}) = _$DigitalDocumentAcceptUserImpl;

  factory _DigitalDocumentAcceptUser.fromJson(Map<String, dynamic> json) =
      _$DigitalDocumentAcceptUserImpl.fromJson;

  @override
  String get name;
  @override
  DateTime get birthDate;
  @override
  String get phoneNumber;
  @override
  String? get corporateNo;
  @override
  @JsonKey(ignore: true)
  _$$DigitalDocumentAcceptUserImplCopyWith<_$DigitalDocumentAcceptUserImpl>
      get copyWith => throw _privateConstructorUsedError;
}
