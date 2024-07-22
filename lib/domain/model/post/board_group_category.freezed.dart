// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_group_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BoardGroupCategory _$BoardGroupCategoryFromJson(Map<String, dynamic> json) {
  return _BoardGroupCategory.fromJson(json);
}

/// @nodoc
mixin _$BoardGroupCategory {
  String get name => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  bool get isGroup => throw _privateConstructorUsedError;
  bool? get isExclusiveToHolders => throw _privateConstructorUsedError;
  String? get badgeColor => throw _privateConstructorUsedError;
  List<BoardGroupCategory>? get subCategories =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BoardGroupCategoryCopyWith<BoardGroupCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardGroupCategoryCopyWith<$Res> {
  factory $BoardGroupCategoryCopyWith(
          BoardGroupCategory value, $Res Function(BoardGroupCategory) then) =
      _$BoardGroupCategoryCopyWithImpl<$Res, BoardGroupCategory>;
  @useResult
  $Res call(
      {String name,
      String displayName,
      bool isGroup,
      bool? isExclusiveToHolders,
      String? badgeColor,
      List<BoardGroupCategory>? subCategories});
}

/// @nodoc
class _$BoardGroupCategoryCopyWithImpl<$Res, $Val extends BoardGroupCategory>
    implements $BoardGroupCategoryCopyWith<$Res> {
  _$BoardGroupCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayName = null,
    Object? isGroup = null,
    Object? isExclusiveToHolders = freezed,
    Object? badgeColor = freezed,
    Object? subCategories = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      isExclusiveToHolders: freezed == isExclusiveToHolders
          ? _value.isExclusiveToHolders
          : isExclusiveToHolders // ignore: cast_nullable_to_non_nullable
              as bool?,
      badgeColor: freezed == badgeColor
          ? _value.badgeColor
          : badgeColor // ignore: cast_nullable_to_non_nullable
              as String?,
      subCategories: freezed == subCategories
          ? _value.subCategories
          : subCategories // ignore: cast_nullable_to_non_nullable
              as List<BoardGroupCategory>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoardGroupCategoryImplCopyWith<$Res>
    implements $BoardGroupCategoryCopyWith<$Res> {
  factory _$$BoardGroupCategoryImplCopyWith(_$BoardGroupCategoryImpl value,
          $Res Function(_$BoardGroupCategoryImpl) then) =
      __$$BoardGroupCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayName,
      bool isGroup,
      bool? isExclusiveToHolders,
      String? badgeColor,
      List<BoardGroupCategory>? subCategories});
}

/// @nodoc
class __$$BoardGroupCategoryImplCopyWithImpl<$Res>
    extends _$BoardGroupCategoryCopyWithImpl<$Res, _$BoardGroupCategoryImpl>
    implements _$$BoardGroupCategoryImplCopyWith<$Res> {
  __$$BoardGroupCategoryImplCopyWithImpl(_$BoardGroupCategoryImpl _value,
      $Res Function(_$BoardGroupCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayName = null,
    Object? isGroup = null,
    Object? isExclusiveToHolders = freezed,
    Object? badgeColor = freezed,
    Object? subCategories = freezed,
  }) {
    return _then(_$BoardGroupCategoryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      isExclusiveToHolders: freezed == isExclusiveToHolders
          ? _value.isExclusiveToHolders
          : isExclusiveToHolders // ignore: cast_nullable_to_non_nullable
              as bool?,
      badgeColor: freezed == badgeColor
          ? _value.badgeColor
          : badgeColor // ignore: cast_nullable_to_non_nullable
              as String?,
      subCategories: freezed == subCategories
          ? _value._subCategories
          : subCategories // ignore: cast_nullable_to_non_nullable
              as List<BoardGroupCategory>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoardGroupCategoryImpl extends _BoardGroupCategory {
  const _$BoardGroupCategoryImpl(
      {required this.name,
      required this.displayName,
      this.isGroup = false,
      this.isExclusiveToHolders = false,
      this.badgeColor,
      final List<BoardGroupCategory>? subCategories})
      : _subCategories = subCategories,
        super._();

  factory _$BoardGroupCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoardGroupCategoryImplFromJson(json);

  @override
  final String name;
  @override
  final String displayName;
  @override
  @JsonKey()
  final bool isGroup;
  @override
  @JsonKey()
  final bool? isExclusiveToHolders;
  @override
  final String? badgeColor;
  final List<BoardGroupCategory>? _subCategories;
  @override
  List<BoardGroupCategory>? get subCategories {
    final value = _subCategories;
    if (value == null) return null;
    if (_subCategories is EqualUnmodifiableListView) return _subCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BoardGroupCategory(name: $name, displayName: $displayName, isGroup: $isGroup, isExclusiveToHolders: $isExclusiveToHolders, badgeColor: $badgeColor, subCategories: $subCategories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardGroupCategoryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.isGroup, isGroup) || other.isGroup == isGroup) &&
            (identical(other.isExclusiveToHolders, isExclusiveToHolders) ||
                other.isExclusiveToHolders == isExclusiveToHolders) &&
            (identical(other.badgeColor, badgeColor) ||
                other.badgeColor == badgeColor) &&
            const DeepCollectionEquality()
                .equals(other._subCategories, _subCategories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      displayName,
      isGroup,
      isExclusiveToHolders,
      badgeColor,
      const DeepCollectionEquality().hash(_subCategories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardGroupCategoryImplCopyWith<_$BoardGroupCategoryImpl> get copyWith =>
      __$$BoardGroupCategoryImplCopyWithImpl<_$BoardGroupCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoardGroupCategoryImplToJson(
      this,
    );
  }
}

abstract class _BoardGroupCategory extends BoardGroupCategory {
  const factory _BoardGroupCategory(
          {required final String name,
          required final String displayName,
          final bool isGroup,
          final bool? isExclusiveToHolders,
          final String? badgeColor,
          final List<BoardGroupCategory>? subCategories}) =
      _$BoardGroupCategoryImpl;
  const _BoardGroupCategory._() : super._();

  factory _BoardGroupCategory.fromJson(Map<String, dynamic> json) =
      _$BoardGroupCategoryImpl.fromJson;

  @override
  String get name;
  @override
  String get displayName;
  @override
  bool get isGroup;
  @override
  bool? get isExclusiveToHolders;
  @override
  String? get badgeColor;
  @override
  List<BoardGroupCategory>? get subCategories;
  @override
  @JsonKey(ignore: true)
  _$$BoardGroupCategoryImplCopyWith<_$BoardGroupCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
