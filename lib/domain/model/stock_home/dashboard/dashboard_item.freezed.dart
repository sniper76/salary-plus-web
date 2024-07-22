// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardItem _$DashboardItemFromJson(Map<String, dynamic> json) {
  return _DashboardItem.fromJson(json);
}

/// @nodoc
mixin _$DashboardItem {
  String get title => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  Variation get variation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardItemCopyWith<DashboardItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardItemCopyWith<$Res> {
  factory $DashboardItemCopyWith(
          DashboardItem value, $Res Function(DashboardItem) then) =
      _$DashboardItemCopyWithImpl<$Res, DashboardItem>;
  @useResult
  $Res call({String title, String value, Variation variation});

  $VariationCopyWith<$Res> get variation;
}

/// @nodoc
class _$DashboardItemCopyWithImpl<$Res, $Val extends DashboardItem>
    implements $DashboardItemCopyWith<$Res> {
  _$DashboardItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? value = null,
    Object? variation = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      variation: null == variation
          ? _value.variation
          : variation // ignore: cast_nullable_to_non_nullable
              as Variation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VariationCopyWith<$Res> get variation {
    return $VariationCopyWith<$Res>(_value.variation, (value) {
      return _then(_value.copyWith(variation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardItemImplCopyWith<$Res>
    implements $DashboardItemCopyWith<$Res> {
  factory _$$DashboardItemImplCopyWith(
          _$DashboardItemImpl value, $Res Function(_$DashboardItemImpl) then) =
      __$$DashboardItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String value, Variation variation});

  @override
  $VariationCopyWith<$Res> get variation;
}

/// @nodoc
class __$$DashboardItemImplCopyWithImpl<$Res>
    extends _$DashboardItemCopyWithImpl<$Res, _$DashboardItemImpl>
    implements _$$DashboardItemImplCopyWith<$Res> {
  __$$DashboardItemImplCopyWithImpl(
      _$DashboardItemImpl _value, $Res Function(_$DashboardItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? value = null,
    Object? variation = null,
  }) {
    return _then(_$DashboardItemImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      variation: null == variation
          ? _value.variation
          : variation // ignore: cast_nullable_to_non_nullable
              as Variation,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardItemImpl implements _DashboardItem {
  const _$DashboardItemImpl(
      {required this.title, required this.value, required this.variation});

  factory _$DashboardItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardItemImplFromJson(json);

  @override
  final String title;
  @override
  final String value;
  @override
  final Variation variation;

  @override
  String toString() {
    return 'DashboardItem(title: $title, value: $value, variation: $variation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.variation, variation) ||
                other.variation == variation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, value, variation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardItemImplCopyWith<_$DashboardItemImpl> get copyWith =>
      __$$DashboardItemImplCopyWithImpl<_$DashboardItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardItemImplToJson(
      this,
    );
  }
}

abstract class _DashboardItem implements DashboardItem {
  const factory _DashboardItem(
      {required final String title,
      required final String value,
      required final Variation variation}) = _$DashboardItemImpl;

  factory _DashboardItem.fromJson(Map<String, dynamic> json) =
      _$DashboardItemImpl.fromJson;

  @override
  String get title;
  @override
  String get value;
  @override
  Variation get variation;
  @override
  @JsonKey(ignore: true)
  _$$DashboardItemImplCopyWith<_$DashboardItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
