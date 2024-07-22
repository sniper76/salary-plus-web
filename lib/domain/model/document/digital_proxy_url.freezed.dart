// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_proxy_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DigitalProxyUrl _$DigitalProxyUrlFromJson(Map<String, dynamic> json) {
  return _DigitalProxyUrl.fromJson(json);
}

/// @nodoc
mixin _$DigitalProxyUrl {
  String get embeddedUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DigitalProxyUrlCopyWith<DigitalProxyUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DigitalProxyUrlCopyWith<$Res> {
  factory $DigitalProxyUrlCopyWith(
          DigitalProxyUrl value, $Res Function(DigitalProxyUrl) then) =
      _$DigitalProxyUrlCopyWithImpl<$Res, DigitalProxyUrl>;
  @useResult
  $Res call({String embeddedUrl});
}

/// @nodoc
class _$DigitalProxyUrlCopyWithImpl<$Res, $Val extends DigitalProxyUrl>
    implements $DigitalProxyUrlCopyWith<$Res> {
  _$DigitalProxyUrlCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? embeddedUrl = null,
  }) {
    return _then(_value.copyWith(
      embeddedUrl: null == embeddedUrl
          ? _value.embeddedUrl
          : embeddedUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DigitalProxyUrlImplCopyWith<$Res>
    implements $DigitalProxyUrlCopyWith<$Res> {
  factory _$$DigitalProxyUrlImplCopyWith(_$DigitalProxyUrlImpl value,
          $Res Function(_$DigitalProxyUrlImpl) then) =
      __$$DigitalProxyUrlImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String embeddedUrl});
}

/// @nodoc
class __$$DigitalProxyUrlImplCopyWithImpl<$Res>
    extends _$DigitalProxyUrlCopyWithImpl<$Res, _$DigitalProxyUrlImpl>
    implements _$$DigitalProxyUrlImplCopyWith<$Res> {
  __$$DigitalProxyUrlImplCopyWithImpl(
      _$DigitalProxyUrlImpl _value, $Res Function(_$DigitalProxyUrlImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? embeddedUrl = null,
  }) {
    return _then(_$DigitalProxyUrlImpl(
      embeddedUrl: null == embeddedUrl
          ? _value.embeddedUrl
          : embeddedUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalProxyUrlImpl implements _DigitalProxyUrl {
  const _$DigitalProxyUrlImpl({required this.embeddedUrl});

  factory _$DigitalProxyUrlImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalProxyUrlImplFromJson(json);

  @override
  final String embeddedUrl;

  @override
  String toString() {
    return 'DigitalProxyUrl(embeddedUrl: $embeddedUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalProxyUrlImpl &&
            (identical(other.embeddedUrl, embeddedUrl) ||
                other.embeddedUrl == embeddedUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, embeddedUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalProxyUrlImplCopyWith<_$DigitalProxyUrlImpl> get copyWith =>
      __$$DigitalProxyUrlImplCopyWithImpl<_$DigitalProxyUrlImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalProxyUrlImplToJson(
      this,
    );
  }
}

abstract class _DigitalProxyUrl implements DigitalProxyUrl {
  const factory _DigitalProxyUrl({required final String embeddedUrl}) =
      _$DigitalProxyUrlImpl;

  factory _DigitalProxyUrl.fromJson(Map<String, dynamic> json) =
      _$DigitalProxyUrlImpl.fromJson;

  @override
  String get embeddedUrl;
  @override
  @JsonKey(ignore: true)
  _$$DigitalProxyUrlImplCopyWith<_$DigitalProxyUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
