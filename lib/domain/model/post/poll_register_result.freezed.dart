// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_register_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PollRegisterResult {
  String get title => throw _privateConstructorUsedError;
  List<String> get items => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime get endedAt => throw _privateConstructorUsedError;
  PollSelectionType get selectionType => throw _privateConstructorUsedError;
  PollVoteType get voteType => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PollRegisterResultCopyWith<PollRegisterResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollRegisterResultCopyWith<$Res> {
  factory $PollRegisterResultCopyWith(
          PollRegisterResult value, $Res Function(PollRegisterResult) then) =
      _$PollRegisterResultCopyWithImpl<$Res, PollRegisterResult>;
  @useResult
  $Res call(
      {String title,
      List<String> items,
      DateTime startedAt,
      DateTime endedAt,
      PollSelectionType selectionType,
      PollVoteType voteType,
      String? content,
      int? id});
}

/// @nodoc
class _$PollRegisterResultCopyWithImpl<$Res, $Val extends PollRegisterResult>
    implements $PollRegisterResultCopyWith<$Res> {
  _$PollRegisterResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? items = null,
    Object? startedAt = null,
    Object? endedAt = null,
    Object? selectionType = null,
    Object? voteType = null,
    Object? content = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: null == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectionType: null == selectionType
          ? _value.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as PollSelectionType,
      voteType: null == voteType
          ? _value.voteType
          : voteType // ignore: cast_nullable_to_non_nullable
              as PollVoteType,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollRegisterResultImplCopyWith<$Res>
    implements $PollRegisterResultCopyWith<$Res> {
  factory _$$PollRegisterResultImplCopyWith(_$PollRegisterResultImpl value,
          $Res Function(_$PollRegisterResultImpl) then) =
      __$$PollRegisterResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      List<String> items,
      DateTime startedAt,
      DateTime endedAt,
      PollSelectionType selectionType,
      PollVoteType voteType,
      String? content,
      int? id});
}

/// @nodoc
class __$$PollRegisterResultImplCopyWithImpl<$Res>
    extends _$PollRegisterResultCopyWithImpl<$Res, _$PollRegisterResultImpl>
    implements _$$PollRegisterResultImplCopyWith<$Res> {
  __$$PollRegisterResultImplCopyWithImpl(_$PollRegisterResultImpl _value,
      $Res Function(_$PollRegisterResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? items = null,
    Object? startedAt = null,
    Object? endedAt = null,
    Object? selectionType = null,
    Object? voteType = null,
    Object? content = freezed,
    Object? id = freezed,
  }) {
    return _then(_$PollRegisterResultImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: null == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectionType: null == selectionType
          ? _value.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as PollSelectionType,
      voteType: null == voteType
          ? _value.voteType
          : voteType // ignore: cast_nullable_to_non_nullable
              as PollVoteType,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$PollRegisterResultImpl extends _PollRegisterResult {
  const _$PollRegisterResultImpl(
      {required this.title,
      required final List<String> items,
      required this.startedAt,
      required this.endedAt,
      required this.selectionType,
      required this.voteType,
      this.content,
      this.id})
      : _items = items,
        super._();

  @override
  final String title;
  final List<String> _items;
  @override
  List<String> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime startedAt;
  @override
  final DateTime endedAt;
  @override
  final PollSelectionType selectionType;
  @override
  final PollVoteType voteType;
  @override
  final String? content;
  @override
  final int? id;

  @override
  String toString() {
    return 'PollRegisterResult(title: $title, items: $items, startedAt: $startedAt, endedAt: $endedAt, selectionType: $selectionType, voteType: $voteType, content: $content, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollRegisterResultImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.selectionType, selectionType) ||
                other.selectionType == selectionType) &&
            (identical(other.voteType, voteType) ||
                other.voteType == voteType) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_items),
      startedAt,
      endedAt,
      selectionType,
      voteType,
      content,
      id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollRegisterResultImplCopyWith<_$PollRegisterResultImpl> get copyWith =>
      __$$PollRegisterResultImplCopyWithImpl<_$PollRegisterResultImpl>(
          this, _$identity);
}

abstract class _PollRegisterResult extends PollRegisterResult {
  const factory _PollRegisterResult(
      {required final String title,
      required final List<String> items,
      required final DateTime startedAt,
      required final DateTime endedAt,
      required final PollSelectionType selectionType,
      required final PollVoteType voteType,
      final String? content,
      final int? id}) = _$PollRegisterResultImpl;
  const _PollRegisterResult._() : super._();

  @override
  String get title;
  @override
  List<String> get items;
  @override
  DateTime get startedAt;
  @override
  DateTime get endedAt;
  @override
  PollSelectionType get selectionType;
  @override
  PollVoteType get voteType;
  @override
  String? get content;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$PollRegisterResultImplCopyWith<_$PollRegisterResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
