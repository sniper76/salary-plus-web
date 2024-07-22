// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_document_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DigitalDocumentItem _$DigitalDocumentItemFromJson(Map<String, dynamic> json) {
  return _DigitalDocumentItem.fromJson(json);
}

/// @nodoc
mixin _$DigitalDocumentItem {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get leaderDescription => throw _privateConstructorUsedError;
  DigitalDocumentAnswerType? get defaultSelectValue =>
      throw _privateConstructorUsedError;
  List<DigitalDocumentItem>? get childItems =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DigitalDocumentItemCopyWith<DigitalDocumentItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DigitalDocumentItemCopyWith<$Res> {
  factory $DigitalDocumentItemCopyWith(
          DigitalDocumentItem value, $Res Function(DigitalDocumentItem) then) =
      _$DigitalDocumentItemCopyWithImpl<$Res, DigitalDocumentItem>;
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      String? leaderDescription,
      DigitalDocumentAnswerType? defaultSelectValue,
      List<DigitalDocumentItem>? childItems});
}

/// @nodoc
class _$DigitalDocumentItemCopyWithImpl<$Res, $Val extends DigitalDocumentItem>
    implements $DigitalDocumentItemCopyWith<$Res> {
  _$DigitalDocumentItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? leaderDescription = freezed,
    Object? defaultSelectValue = freezed,
    Object? childItems = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      leaderDescription: freezed == leaderDescription
          ? _value.leaderDescription
          : leaderDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultSelectValue: freezed == defaultSelectValue
          ? _value.defaultSelectValue
          : defaultSelectValue // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAnswerType?,
      childItems: freezed == childItems
          ? _value.childItems
          : childItems // ignore: cast_nullable_to_non_nullable
              as List<DigitalDocumentItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DigitalDocumentItemImplCopyWith<$Res>
    implements $DigitalDocumentItemCopyWith<$Res> {
  factory _$$DigitalDocumentItemImplCopyWith(_$DigitalDocumentItemImpl value,
          $Res Function(_$DigitalDocumentItemImpl) then) =
      __$$DigitalDocumentItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      String? leaderDescription,
      DigitalDocumentAnswerType? defaultSelectValue,
      List<DigitalDocumentItem>? childItems});
}

/// @nodoc
class __$$DigitalDocumentItemImplCopyWithImpl<$Res>
    extends _$DigitalDocumentItemCopyWithImpl<$Res, _$DigitalDocumentItemImpl>
    implements _$$DigitalDocumentItemImplCopyWith<$Res> {
  __$$DigitalDocumentItemImplCopyWithImpl(_$DigitalDocumentItemImpl _value,
      $Res Function(_$DigitalDocumentItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? leaderDescription = freezed,
    Object? defaultSelectValue = freezed,
    Object? childItems = freezed,
  }) {
    return _then(_$DigitalDocumentItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      leaderDescription: freezed == leaderDescription
          ? _value.leaderDescription
          : leaderDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultSelectValue: freezed == defaultSelectValue
          ? _value.defaultSelectValue
          : defaultSelectValue // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAnswerType?,
      childItems: freezed == childItems
          ? _value._childItems
          : childItems // ignore: cast_nullable_to_non_nullable
              as List<DigitalDocumentItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalDocumentItemImpl extends _DigitalDocumentItem {
  const _$DigitalDocumentItemImpl(
      {required this.id,
      required this.title,
      required this.content,
      this.leaderDescription,
      this.defaultSelectValue,
      final List<DigitalDocumentItem>? childItems})
      : _childItems = childItems,
        super._();

  factory _$DigitalDocumentItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalDocumentItemImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String? leaderDescription;
  @override
  final DigitalDocumentAnswerType? defaultSelectValue;
  final List<DigitalDocumentItem>? _childItems;
  @override
  List<DigitalDocumentItem>? get childItems {
    final value = _childItems;
    if (value == null) return null;
    if (_childItems is EqualUnmodifiableListView) return _childItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DigitalDocumentItem(id: $id, title: $title, content: $content, leaderDescription: $leaderDescription, defaultSelectValue: $defaultSelectValue, childItems: $childItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalDocumentItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.leaderDescription, leaderDescription) ||
                other.leaderDescription == leaderDescription) &&
            (identical(other.defaultSelectValue, defaultSelectValue) ||
                other.defaultSelectValue == defaultSelectValue) &&
            const DeepCollectionEquality()
                .equals(other._childItems, _childItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      content,
      leaderDescription,
      defaultSelectValue,
      const DeepCollectionEquality().hash(_childItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalDocumentItemImplCopyWith<_$DigitalDocumentItemImpl> get copyWith =>
      __$$DigitalDocumentItemImplCopyWithImpl<_$DigitalDocumentItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalDocumentItemImplToJson(
      this,
    );
  }
}

abstract class _DigitalDocumentItem extends DigitalDocumentItem {
  const factory _DigitalDocumentItem(
      {required final int id,
      required final String title,
      required final String content,
      final String? leaderDescription,
      final DigitalDocumentAnswerType? defaultSelectValue,
      final List<DigitalDocumentItem>? childItems}) = _$DigitalDocumentItemImpl;
  const _DigitalDocumentItem._() : super._();

  factory _DigitalDocumentItem.fromJson(Map<String, dynamic> json) =
      _$DigitalDocumentItemImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  String? get leaderDescription;
  @override
  DigitalDocumentAnswerType? get defaultSelectValue;
  @override
  List<DigitalDocumentItem>? get childItems;
  @override
  @JsonKey(ignore: true)
  _$$DigitalDocumentItemImplCopyWith<_$DigitalDocumentItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
