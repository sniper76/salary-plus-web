// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PollAnswer _$PollAnswerFromJson(Map<String, dynamic> json) {
  return _PollAnswer.fromJson(json);
}

/// @nodoc
mixin _$PollAnswer {
  int get id => throw _privateConstructorUsedError;
  int get pollItemId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollAnswerCopyWith<PollAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollAnswerCopyWith<$Res> {
  factory $PollAnswerCopyWith(
          PollAnswer value, $Res Function(PollAnswer) then) =
      _$PollAnswerCopyWithImpl<$Res, PollAnswer>;
  @useResult
  $Res call({int id, int pollItemId});
}

/// @nodoc
class _$PollAnswerCopyWithImpl<$Res, $Val extends PollAnswer>
    implements $PollAnswerCopyWith<$Res> {
  _$PollAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pollItemId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pollItemId: null == pollItemId
          ? _value.pollItemId
          : pollItemId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollAnswerImplCopyWith<$Res>
    implements $PollAnswerCopyWith<$Res> {
  factory _$$PollAnswerImplCopyWith(
          _$PollAnswerImpl value, $Res Function(_$PollAnswerImpl) then) =
      __$$PollAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int pollItemId});
}

/// @nodoc
class __$$PollAnswerImplCopyWithImpl<$Res>
    extends _$PollAnswerCopyWithImpl<$Res, _$PollAnswerImpl>
    implements _$$PollAnswerImplCopyWith<$Res> {
  __$$PollAnswerImplCopyWithImpl(
      _$PollAnswerImpl _value, $Res Function(_$PollAnswerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pollItemId = null,
  }) {
    return _then(_$PollAnswerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pollItemId: null == pollItemId
          ? _value.pollItemId
          : pollItemId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollAnswerImpl implements _PollAnswer {
  const _$PollAnswerImpl({required this.id, required this.pollItemId});

  factory _$PollAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollAnswerImplFromJson(json);

  @override
  final int id;
  @override
  final int pollItemId;

  @override
  String toString() {
    return 'PollAnswer(id: $id, pollItemId: $pollItemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollAnswerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pollItemId, pollItemId) ||
                other.pollItemId == pollItemId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, pollItemId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollAnswerImplCopyWith<_$PollAnswerImpl> get copyWith =>
      __$$PollAnswerImplCopyWithImpl<_$PollAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollAnswerImplToJson(
      this,
    );
  }
}

abstract class _PollAnswer implements PollAnswer {
  const factory _PollAnswer(
      {required final int id,
      required final int pollItemId}) = _$PollAnswerImpl;

  factory _PollAnswer.fromJson(Map<String, dynamic> json) =
      _$PollAnswerImpl.fromJson;

  @override
  int get id;
  @override
  int get pollItemId;
  @override
  @JsonKey(ignore: true)
  _$$PollAnswerImplCopyWith<_$PollAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
