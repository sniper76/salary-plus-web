// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_carousel_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SectionCarouselItem _$SectionCarouselItemFromJson(Map<String, dynamic> json) {
  return _SectionCarouselItem.fromJson(json);
}

/// @nodoc
mixin _$SectionCarouselItem {
  SectionHeader get header => throw _privateConstructorUsedError;
  List<SectionItem> get listItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionCarouselItemCopyWith<SectionCarouselItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionCarouselItemCopyWith<$Res> {
  factory $SectionCarouselItemCopyWith(
          SectionCarouselItem value, $Res Function(SectionCarouselItem) then) =
      _$SectionCarouselItemCopyWithImpl<$Res, SectionCarouselItem>;
  @useResult
  $Res call({SectionHeader header, List<SectionItem> listItems});

  $SectionHeaderCopyWith<$Res> get header;
}

/// @nodoc
class _$SectionCarouselItemCopyWithImpl<$Res, $Val extends SectionCarouselItem>
    implements $SectionCarouselItemCopyWith<$Res> {
  _$SectionCarouselItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? header = null,
    Object? listItems = null,
  }) {
    return _then(_value.copyWith(
      header: null == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as SectionHeader,
      listItems: null == listItems
          ? _value.listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<SectionItem>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SectionHeaderCopyWith<$Res> get header {
    return $SectionHeaderCopyWith<$Res>(_value.header, (value) {
      return _then(_value.copyWith(header: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SectionCarouselItemImplCopyWith<$Res>
    implements $SectionCarouselItemCopyWith<$Res> {
  factory _$$SectionCarouselItemImplCopyWith(_$SectionCarouselItemImpl value,
          $Res Function(_$SectionCarouselItemImpl) then) =
      __$$SectionCarouselItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SectionHeader header, List<SectionItem> listItems});

  @override
  $SectionHeaderCopyWith<$Res> get header;
}

/// @nodoc
class __$$SectionCarouselItemImplCopyWithImpl<$Res>
    extends _$SectionCarouselItemCopyWithImpl<$Res, _$SectionCarouselItemImpl>
    implements _$$SectionCarouselItemImplCopyWith<$Res> {
  __$$SectionCarouselItemImplCopyWithImpl(_$SectionCarouselItemImpl _value,
      $Res Function(_$SectionCarouselItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? header = null,
    Object? listItems = null,
  }) {
    return _then(_$SectionCarouselItemImpl(
      header: null == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as SectionHeader,
      listItems: null == listItems
          ? _value._listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<SectionItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionCarouselItemImpl implements _SectionCarouselItem {
  const _$SectionCarouselItemImpl(
      {required this.header, required final List<SectionItem> listItems})
      : _listItems = listItems;

  factory _$SectionCarouselItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionCarouselItemImplFromJson(json);

  @override
  final SectionHeader header;
  final List<SectionItem> _listItems;
  @override
  List<SectionItem> get listItems {
    if (_listItems is EqualUnmodifiableListView) return _listItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listItems);
  }

  @override
  String toString() {
    return 'SectionCarouselItem(header: $header, listItems: $listItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionCarouselItemImpl &&
            (identical(other.header, header) || other.header == header) &&
            const DeepCollectionEquality()
                .equals(other._listItems, _listItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, header, const DeepCollectionEquality().hash(_listItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionCarouselItemImplCopyWith<_$SectionCarouselItemImpl> get copyWith =>
      __$$SectionCarouselItemImplCopyWithImpl<_$SectionCarouselItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionCarouselItemImplToJson(
      this,
    );
  }
}

abstract class _SectionCarouselItem implements SectionCarouselItem {
  const factory _SectionCarouselItem(
      {required final SectionHeader header,
      required final List<SectionItem> listItems}) = _$SectionCarouselItemImpl;

  factory _SectionCarouselItem.fromJson(Map<String, dynamic> json) =
      _$SectionCarouselItemImpl.fromJson;

  @override
  SectionHeader get header;
  @override
  List<SectionItem> get listItems;
  @override
  @JsonKey(ignore: true)
  _$$SectionCarouselItemImplCopyWith<_$SectionCarouselItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
