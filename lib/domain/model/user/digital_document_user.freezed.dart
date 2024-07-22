// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_document_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DigitalDocumentUser _$DigitalDocumentUserFromJson(Map<String, dynamic> json) {
  return _DigitalDocumentUser.fromJson(json);
}

/// @nodoc
mixin _$DigitalDocumentUser {
  String get name => throw _privateConstructorUsedError;
  DateTime get birthDate => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String? get zipcode => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get addressDetail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DigitalDocumentUserCopyWith<DigitalDocumentUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DigitalDocumentUserCopyWith<$Res> {
  factory $DigitalDocumentUserCopyWith(
          DigitalDocumentUser value, $Res Function(DigitalDocumentUser) then) =
      _$DigitalDocumentUserCopyWithImpl<$Res, DigitalDocumentUser>;
  @useResult
  $Res call(
      {String name,
      DateTime birthDate,
      String gender,
      String phoneNumber,
      String? zipcode,
      String? address,
      String? addressDetail});
}

/// @nodoc
class _$DigitalDocumentUserCopyWithImpl<$Res, $Val extends DigitalDocumentUser>
    implements $DigitalDocumentUserCopyWith<$Res> {
  _$DigitalDocumentUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? birthDate = null,
    Object? gender = null,
    Object? phoneNumber = null,
    Object? zipcode = freezed,
    Object? address = freezed,
    Object? addressDetail = freezed,
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
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      zipcode: freezed == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      addressDetail: freezed == addressDetail
          ? _value.addressDetail
          : addressDetail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DigitalDocumentUserImplCopyWith<$Res>
    implements $DigitalDocumentUserCopyWith<$Res> {
  factory _$$DigitalDocumentUserImplCopyWith(_$DigitalDocumentUserImpl value,
          $Res Function(_$DigitalDocumentUserImpl) then) =
      __$$DigitalDocumentUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      DateTime birthDate,
      String gender,
      String phoneNumber,
      String? zipcode,
      String? address,
      String? addressDetail});
}

/// @nodoc
class __$$DigitalDocumentUserImplCopyWithImpl<$Res>
    extends _$DigitalDocumentUserCopyWithImpl<$Res, _$DigitalDocumentUserImpl>
    implements _$$DigitalDocumentUserImplCopyWith<$Res> {
  __$$DigitalDocumentUserImplCopyWithImpl(_$DigitalDocumentUserImpl _value,
      $Res Function(_$DigitalDocumentUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? birthDate = null,
    Object? gender = null,
    Object? phoneNumber = null,
    Object? zipcode = freezed,
    Object? address = freezed,
    Object? addressDetail = freezed,
  }) {
    return _then(_$DigitalDocumentUserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      zipcode: freezed == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      addressDetail: freezed == addressDetail
          ? _value.addressDetail
          : addressDetail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalDocumentUserImpl extends _DigitalDocumentUser {
  const _$DigitalDocumentUserImpl(
      {required this.name,
      required this.birthDate,
      required this.gender,
      required this.phoneNumber,
      this.zipcode,
      this.address,
      this.addressDetail})
      : super._();

  factory _$DigitalDocumentUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalDocumentUserImplFromJson(json);

  @override
  final String name;
  @override
  final DateTime birthDate;
  @override
  final String gender;
  @override
  final String phoneNumber;
  @override
  final String? zipcode;
  @override
  final String? address;
  @override
  final String? addressDetail;

  @override
  String toString() {
    return 'DigitalDocumentUser(name: $name, birthDate: $birthDate, gender: $gender, phoneNumber: $phoneNumber, zipcode: $zipcode, address: $address, addressDetail: $addressDetail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalDocumentUserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.zipcode, zipcode) || other.zipcode == zipcode) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.addressDetail, addressDetail) ||
                other.addressDetail == addressDetail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, birthDate, gender,
      phoneNumber, zipcode, address, addressDetail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalDocumentUserImplCopyWith<_$DigitalDocumentUserImpl> get copyWith =>
      __$$DigitalDocumentUserImplCopyWithImpl<_$DigitalDocumentUserImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalDocumentUserImplToJson(
      this,
    );
  }
}

abstract class _DigitalDocumentUser extends DigitalDocumentUser {
  const factory _DigitalDocumentUser(
      {required final String name,
      required final DateTime birthDate,
      required final String gender,
      required final String phoneNumber,
      final String? zipcode,
      final String? address,
      final String? addressDetail}) = _$DigitalDocumentUserImpl;
  const _DigitalDocumentUser._() : super._();

  factory _DigitalDocumentUser.fromJson(Map<String, dynamic> json) =
      _$DigitalDocumentUserImpl.fromJson;

  @override
  String get name;
  @override
  DateTime get birthDate;
  @override
  String get gender;
  @override
  String get phoneNumber;
  @override
  String? get zipcode;
  @override
  String? get address;
  @override
  String? get addressDetail;
  @override
  @JsonKey(ignore: true)
  _$$DigitalDocumentUserImplCopyWith<_$DigitalDocumentUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
