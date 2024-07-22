// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Section _$SectionFromJson(Map<String, dynamic> json) {
  return _Section.fromJson(json);
}

/// @nodoc
mixin _$Section {
  SectionType get type => throw _privateConstructorUsedError;
  SectionHeader? get header => throw _privateConstructorUsedError;
  List<SectionCarouselItem>? get carouselItems =>
      throw _privateConstructorUsedError;
  List<SectionItem>? get listItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionCopyWith<Section> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionCopyWith<$Res> {
  factory $SectionCopyWith(Section value, $Res Function(Section) then) =
      _$SectionCopyWithImpl<$Res, Section>;
  @useResult
  $Res call(
      {SectionType type,
      SectionHeader? header,
      List<SectionCarouselItem>? carouselItems,
      List<SectionItem>? listItems});

  $SectionHeaderCopyWith<$Res>? get header;
}

/// @nodoc
class _$SectionCopyWithImpl<$Res, $Val extends Section>
    implements $SectionCopyWith<$Res> {
  _$SectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? header = freezed,
    Object? carouselItems = freezed,
    Object? listItems = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SectionType,
      header: freezed == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as SectionHeader?,
      carouselItems: freezed == carouselItems
          ? _value.carouselItems
          : carouselItems // ignore: cast_nullable_to_non_nullable
              as List<SectionCarouselItem>?,
      listItems: freezed == listItems
          ? _value.listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<SectionItem>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SectionHeaderCopyWith<$Res>? get header {
    if (_value.header == null) {
      return null;
    }

    return $SectionHeaderCopyWith<$Res>(_value.header!, (value) {
      return _then(_value.copyWith(header: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SectionImplCopyWith<$Res> implements $SectionCopyWith<$Res> {
  factory _$$SectionImplCopyWith(
          _$SectionImpl value, $Res Function(_$SectionImpl) then) =
      __$$SectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SectionType type,
      SectionHeader? header,
      List<SectionCarouselItem>? carouselItems,
      List<SectionItem>? listItems});

  @override
  $SectionHeaderCopyWith<$Res>? get header;
}

/// @nodoc
class __$$SectionImplCopyWithImpl<$Res>
    extends _$SectionCopyWithImpl<$Res, _$SectionImpl>
    implements _$$SectionImplCopyWith<$Res> {
  __$$SectionImplCopyWithImpl(
      _$SectionImpl _value, $Res Function(_$SectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? header = freezed,
    Object? carouselItems = freezed,
    Object? listItems = freezed,
  }) {
    return _then(_$SectionImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SectionType,
      header: freezed == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as SectionHeader?,
      carouselItems: freezed == carouselItems
          ? _value._carouselItems
          : carouselItems // ignore: cast_nullable_to_non_nullable
              as List<SectionCarouselItem>?,
      listItems: freezed == listItems
          ? _value._listItems
          : listItems // ignore: cast_nullable_to_non_nullable
              as List<SectionItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionImpl implements _Section {
  const _$SectionImpl(
      {required this.type,
      this.header,
      final List<SectionCarouselItem>? carouselItems,
      final List<SectionItem>? listItems})
      : _carouselItems = carouselItems,
        _listItems = listItems;

  factory _$SectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionImplFromJson(json);

  @override
  final SectionType type;
  @override
  final SectionHeader? header;
  final List<SectionCarouselItem>? _carouselItems;
  @override
  List<SectionCarouselItem>? get carouselItems {
    final value = _carouselItems;
    if (value == null) return null;
    if (_carouselItems is EqualUnmodifiableListView) return _carouselItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SectionItem>? _listItems;
  @override
  List<SectionItem>? get listItems {
    final value = _listItems;
    if (value == null) return null;
    if (_listItems is EqualUnmodifiableListView) return _listItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Section(type: $type, header: $header, carouselItems: $carouselItems, listItems: $listItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.header, header) || other.header == header) &&
            const DeepCollectionEquality()
                .equals(other._carouselItems, _carouselItems) &&
            const DeepCollectionEquality()
                .equals(other._listItems, _listItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      header,
      const DeepCollectionEquality().hash(_carouselItems),
      const DeepCollectionEquality().hash(_listItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionImplCopyWith<_$SectionImpl> get copyWith =>
      __$$SectionImplCopyWithImpl<_$SectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionImplToJson(
      this,
    );
  }
}

abstract class _Section implements Section {
  const factory _Section(
      {required final SectionType type,
      final SectionHeader? header,
      final List<SectionCarouselItem>? carouselItems,
      final List<SectionItem>? listItems}) = _$SectionImpl;

  factory _Section.fromJson(Map<String, dynamic> json) = _$SectionImpl.fromJson;

  @override
  SectionType get type;
  @override
  SectionHeader? get header;
  @override
  List<SectionCarouselItem>? get carouselItems;
  @override
  List<SectionItem>? get listItems;
  @override
  @JsonKey(ignore: true)
  _$$SectionImplCopyWith<_$SectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
