// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Variation _$VariationFromJson(Map<String, dynamic> json) {
  return _Variation.fromJson(json);
}

/// @nodoc
mixin _$Variation {
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String get colorHex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VariationCopyWith<Variation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariationCopyWith<$Res> {
  factory $VariationCopyWith(Variation value, $Res Function(Variation) then) =
      _$VariationCopyWithImpl<$Res, Variation>;
  @useResult
  $Res call({String text, @JsonKey(name: 'color') String colorHex});
}

/// @nodoc
class _$VariationCopyWithImpl<$Res, $Val extends Variation>
    implements $VariationCopyWith<$Res> {
  _$VariationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? colorHex = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: null == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VariationImplCopyWith<$Res>
    implements $VariationCopyWith<$Res> {
  factory _$$VariationImplCopyWith(
          _$VariationImpl value, $Res Function(_$VariationImpl) then) =
      __$$VariationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, @JsonKey(name: 'color') String colorHex});
}

/// @nodoc
class __$$VariationImplCopyWithImpl<$Res>
    extends _$VariationCopyWithImpl<$Res, _$VariationImpl>
    implements _$$VariationImplCopyWith<$Res> {
  __$$VariationImplCopyWithImpl(
      _$VariationImpl _value, $Res Function(_$VariationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? colorHex = null,
  }) {
    return _then(_$VariationImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: null == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VariationImpl extends _Variation {
  const _$VariationImpl(
      {required this.text, @JsonKey(name: 'color') required this.colorHex})
      : super._();

  factory _$VariationImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariationImplFromJson(json);

  @override
  final String text;
  @override
  @JsonKey(name: 'color')
  final String colorHex;

  @override
  String toString() {
    return 'Variation(text: $text, colorHex: $colorHex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariationImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, colorHex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VariationImplCopyWith<_$VariationImpl> get copyWith =>
      __$$VariationImplCopyWithImpl<_$VariationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariationImplToJson(
      this,
    );
  }
}

abstract class _Variation extends Variation {
  const factory _Variation(
          {required final String text,
          @JsonKey(name: 'color') required final String colorHex}) =
      _$VariationImpl;
  const _Variation._() : super._();

  factory _Variation.fromJson(Map<String, dynamic> json) =
      _$VariationImpl.fromJson;

  @override
  String get text;
  @override
  @JsonKey(name: 'color')
  String get colorHex;
  @override
  @JsonKey(ignore: true)
  _$$VariationImplCopyWith<_$VariationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
