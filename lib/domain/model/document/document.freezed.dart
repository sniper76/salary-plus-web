// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Document _$DocumentFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return _Document.fromJson(json);
    case 'poll':
      return Poll.fromJson(json);
    case 'digitalProxy':
      return DigitalProxy.fromJson(json);
    case 'digitalDocument':
      return DigitalDocument.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Document',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Document {
  DateTime? get targetStartDate => throw _privateConstructorUsedError;
  DateTime? get targetEndDate => throw _privateConstructorUsedError;
  DigitalDocumentAnswerStatusType? get answerStatus =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        $default, {
    required TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        poll,
    required TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        digitalProxy,
    required TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)
        digitalDocument,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult? Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult? Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult? Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Document value) $default, {
    required TResult Function(Poll value) poll,
    required TResult Function(DigitalProxy value) digitalProxy,
    required TResult Function(DigitalDocument value) digitalDocument,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Document value)? $default, {
    TResult? Function(Poll value)? poll,
    TResult? Function(DigitalProxy value)? digitalProxy,
    TResult? Function(DigitalDocument value)? digitalDocument,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Document value)? $default, {
    TResult Function(Poll value)? poll,
    TResult Function(DigitalProxy value)? digitalProxy,
    TResult Function(DigitalDocument value)? digitalDocument,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentCopyWith<Document> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<$Res> {
  factory $DocumentCopyWith(Document value, $Res Function(Document) then) =
      _$DocumentCopyWithImpl<$Res, Document>;
  @useResult
  $Res call(
      {DateTime? targetStartDate,
      DateTime? targetEndDate,
      DigitalDocumentAnswerStatusType? answerStatus});
}

/// @nodoc
class _$DocumentCopyWithImpl<$Res, $Val extends Document>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetStartDate = freezed,
    Object? targetEndDate = freezed,
    Object? answerStatus = freezed,
  }) {
    return _then(_value.copyWith(
      targetStartDate: freezed == targetStartDate
          ? _value.targetStartDate
          : targetStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetEndDate: freezed == targetEndDate
          ? _value.targetEndDate
          : targetEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      answerStatus: freezed == answerStatus
          ? _value.answerStatus
          : answerStatus // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAnswerStatusType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DocumentImplCopyWith(
          _$DocumentImpl value, $Res Function(_$DocumentImpl) then) =
      __$$DocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? targetStartDate,
      DateTime? targetEndDate,
      DigitalDocumentAnswerStatusType? answerStatus});
}

/// @nodoc
class __$$DocumentImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DocumentImpl>
    implements _$$DocumentImplCopyWith<$Res> {
  __$$DocumentImplCopyWithImpl(
      _$DocumentImpl _value, $Res Function(_$DocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetStartDate = freezed,
    Object? targetEndDate = freezed,
    Object? answerStatus = freezed,
  }) {
    return _then(_$DocumentImpl(
      targetStartDate: freezed == targetStartDate
          ? _value.targetStartDate
          : targetStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetEndDate: freezed == targetEndDate
          ? _value.targetEndDate
          : targetEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      answerStatus: freezed == answerStatus
          ? _value.answerStatus
          : answerStatus // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAnswerStatusType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentImpl extends _Document {
  const _$DocumentImpl(
      {this.targetStartDate,
      this.targetEndDate,
      this.answerStatus,
      final String? $type})
      : $type = $type ?? 'default',
        super._();

  factory _$DocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentImplFromJson(json);

  @override
  final DateTime? targetStartDate;
  @override
  final DateTime? targetEndDate;
  @override
  final DigitalDocumentAnswerStatusType? answerStatus;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Document(targetStartDate: $targetStartDate, targetEndDate: $targetEndDate, answerStatus: $answerStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentImpl &&
            (identical(other.targetStartDate, targetStartDate) ||
                other.targetStartDate == targetStartDate) &&
            (identical(other.targetEndDate, targetEndDate) ||
                other.targetEndDate == targetEndDate) &&
            (identical(other.answerStatus, answerStatus) ||
                other.answerStatus == answerStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, targetStartDate, targetEndDate, answerStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      __$$DocumentImplCopyWithImpl<_$DocumentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        $default, {
    required TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        poll,
    required TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        digitalProxy,
    required TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)
        digitalDocument,
  }) {
    return $default(targetStartDate, targetEndDate, answerStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult? Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult? Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult? Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
  }) {
    return $default?.call(targetStartDate, targetEndDate, answerStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(targetStartDate, targetEndDate, answerStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Document value) $default, {
    required TResult Function(Poll value) poll,
    required TResult Function(DigitalProxy value) digitalProxy,
    required TResult Function(DigitalDocument value) digitalDocument,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Document value)? $default, {
    TResult? Function(Poll value)? poll,
    TResult? Function(DigitalProxy value)? digitalProxy,
    TResult? Function(DigitalDocument value)? digitalDocument,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Document value)? $default, {
    TResult Function(Poll value)? poll,
    TResult Function(DigitalProxy value)? digitalProxy,
    TResult Function(DigitalDocument value)? digitalDocument,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentImplToJson(
      this,
    );
  }
}

abstract class _Document extends Document {
  const factory _Document(
      {final DateTime? targetStartDate,
      final DateTime? targetEndDate,
      final DigitalDocumentAnswerStatusType? answerStatus}) = _$DocumentImpl;
  const _Document._() : super._();

  factory _Document.fromJson(Map<String, dynamic> json) =
      _$DocumentImpl.fromJson;

  @override
  DateTime? get targetStartDate;
  @override
  DateTime? get targetEndDate;
  @override
  DigitalDocumentAnswerStatusType? get answerStatus;
  @override
  @JsonKey(ignore: true)
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PollImplCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$$PollImplCopyWith(
          _$PollImpl value, $Res Function(_$PollImpl) then) =
      __$$PollImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int postId,
      String title,
      PollVoteType voteType,
      @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
      String status,
      List<PollItem> pollItems,
      PollViewType viewType,
      String? content,
      List<PollAnswer>? answers,
      @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
      @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
      DigitalDocumentAnswerStatusType? answerStatus});
}

/// @nodoc
class __$$PollImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$PollImpl>
    implements _$$PollImplCopyWith<$Res> {
  __$$PollImplCopyWithImpl(_$PollImpl _value, $Res Function(_$PollImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? title = null,
    Object? voteType = null,
    Object? selectionType = null,
    Object? status = null,
    Object? pollItems = null,
    Object? viewType = null,
    Object? content = freezed,
    Object? answers = freezed,
    Object? targetStartDate = freezed,
    Object? targetEndDate = freezed,
    Object? answerStatus = freezed,
  }) {
    return _then(_$PollImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      voteType: null == voteType
          ? _value.voteType
          : voteType // ignore: cast_nullable_to_non_nullable
              as PollVoteType,
      selectionType: null == selectionType
          ? _value.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as PollSelectionType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      pollItems: null == pollItems
          ? _value._pollItems
          : pollItems // ignore: cast_nullable_to_non_nullable
              as List<PollItem>,
      viewType: null == viewType
          ? _value.viewType
          : viewType // ignore: cast_nullable_to_non_nullable
              as PollViewType,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      answers: freezed == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<PollAnswer>?,
      targetStartDate: freezed == targetStartDate
          ? _value.targetStartDate
          : targetStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetEndDate: freezed == targetEndDate
          ? _value.targetEndDate
          : targetEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      answerStatus: freezed == answerStatus
          ? _value.answerStatus
          : answerStatus // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAnswerStatusType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollImpl extends Poll {
  const _$PollImpl(
      {required this.id,
      required this.postId,
      required this.title,
      required this.voteType,
      @JsonKey(name: 'selectionOption') required this.selectionType,
      required this.status,
      final List<PollItem> pollItems = const [],
      this.viewType = PollViewType.vote,
      this.content,
      final List<PollAnswer>? answers,
      @JsonKey(toJson: _convertDateToString) this.targetStartDate,
      @JsonKey(toJson: _convertDateToString) this.targetEndDate,
      this.answerStatus,
      final String? $type})
      : _pollItems = pollItems,
        _answers = answers,
        $type = $type ?? 'poll',
        super._();

  factory _$PollImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollImplFromJson(json);

  @override
  final int id;
  @override
  final int postId;
  @override
  final String title;
  @override
  final PollVoteType voteType;
  @override
  @JsonKey(name: 'selectionOption')
  final PollSelectionType selectionType;
  @override
  final String status;
  final List<PollItem> _pollItems;
  @override
  @JsonKey()
  List<PollItem> get pollItems {
    if (_pollItems is EqualUnmodifiableListView) return _pollItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pollItems);
  }

  @override
  @JsonKey()
  final PollViewType viewType;
  @override
  final String? content;
  final List<PollAnswer>? _answers;
  @override
  List<PollAnswer>? get answers {
    final value = _answers;
    if (value == null) return null;
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(toJson: _convertDateToString)
  final DateTime? targetStartDate;
  @override
  @JsonKey(toJson: _convertDateToString)
  final DateTime? targetEndDate;
  @override
  final DigitalDocumentAnswerStatusType? answerStatus;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Document.poll(id: $id, postId: $postId, title: $title, voteType: $voteType, selectionType: $selectionType, status: $status, pollItems: $pollItems, viewType: $viewType, content: $content, answers: $answers, targetStartDate: $targetStartDate, targetEndDate: $targetEndDate, answerStatus: $answerStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.voteType, voteType) ||
                other.voteType == voteType) &&
            (identical(other.selectionType, selectionType) ||
                other.selectionType == selectionType) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._pollItems, _pollItems) &&
            (identical(other.viewType, viewType) ||
                other.viewType == viewType) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.targetStartDate, targetStartDate) ||
                other.targetStartDate == targetStartDate) &&
            (identical(other.targetEndDate, targetEndDate) ||
                other.targetEndDate == targetEndDate) &&
            (identical(other.answerStatus, answerStatus) ||
                other.answerStatus == answerStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      postId,
      title,
      voteType,
      selectionType,
      status,
      const DeepCollectionEquality().hash(_pollItems),
      viewType,
      content,
      const DeepCollectionEquality().hash(_answers),
      targetStartDate,
      targetEndDate,
      answerStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollImplCopyWith<_$PollImpl> get copyWith =>
      __$$PollImplCopyWithImpl<_$PollImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        $default, {
    required TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        poll,
    required TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        digitalProxy,
    required TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)
        digitalDocument,
  }) {
    return poll(
        id,
        postId,
        title,
        voteType,
        selectionType,
        status,
        pollItems,
        viewType,
        content,
        answers,
        targetStartDate,
        targetEndDate,
        answerStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult? Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult? Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult? Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
  }) {
    return poll?.call(
        id,
        postId,
        title,
        voteType,
        selectionType,
        status,
        pollItems,
        viewType,
        content,
        answers,
        targetStartDate,
        targetEndDate,
        answerStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
    required TResult orElse(),
  }) {
    if (poll != null) {
      return poll(
          id,
          postId,
          title,
          voteType,
          selectionType,
          status,
          pollItems,
          viewType,
          content,
          answers,
          targetStartDate,
          targetEndDate,
          answerStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Document value) $default, {
    required TResult Function(Poll value) poll,
    required TResult Function(DigitalProxy value) digitalProxy,
    required TResult Function(DigitalDocument value) digitalDocument,
  }) {
    return poll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Document value)? $default, {
    TResult? Function(Poll value)? poll,
    TResult? Function(DigitalProxy value)? digitalProxy,
    TResult? Function(DigitalDocument value)? digitalDocument,
  }) {
    return poll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Document value)? $default, {
    TResult Function(Poll value)? poll,
    TResult Function(DigitalProxy value)? digitalProxy,
    TResult Function(DigitalDocument value)? digitalDocument,
    required TResult orElse(),
  }) {
    if (poll != null) {
      return poll(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PollImplToJson(
      this,
    );
  }
}

abstract class Poll extends Document {
  const factory Poll(
      {required final int id,
      required final int postId,
      required final String title,
      required final PollVoteType voteType,
      @JsonKey(name: 'selectionOption')
      required final PollSelectionType selectionType,
      required final String status,
      final List<PollItem> pollItems,
      final PollViewType viewType,
      final String? content,
      final List<PollAnswer>? answers,
      @JsonKey(toJson: _convertDateToString) final DateTime? targetStartDate,
      @JsonKey(toJson: _convertDateToString) final DateTime? targetEndDate,
      final DigitalDocumentAnswerStatusType? answerStatus}) = _$PollImpl;
  const Poll._() : super._();

  factory Poll.fromJson(Map<String, dynamic> json) = _$PollImpl.fromJson;

  int get id;
  int get postId;
  String get title;
  PollVoteType get voteType;
  @JsonKey(name: 'selectionOption')
  PollSelectionType get selectionType;
  String get status;
  List<PollItem> get pollItems;
  PollViewType get viewType;
  String? get content;
  List<PollAnswer>? get answers;
  @override
  @JsonKey(toJson: _convertDateToString)
  DateTime? get targetStartDate;
  @override
  @JsonKey(toJson: _convertDateToString)
  DateTime? get targetEndDate;
  @override
  DigitalDocumentAnswerStatusType? get answerStatus;
  @override
  @JsonKey(ignore: true)
  _$$PollImplCopyWith<_$PollImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DigitalProxyImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DigitalProxyImplCopyWith(
          _$DigitalProxyImpl value, $Res Function(_$DigitalProxyImpl) then) =
      __$$DigitalProxyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int templateId,
      String templateName,
      String templateRole,
      DateTime? targetStartDate,
      DateTime? targetEndDate,
      DigitalDocumentAnswerStatusType? answerStatus});
}

/// @nodoc
class __$$DigitalProxyImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DigitalProxyImpl>
    implements _$$DigitalProxyImplCopyWith<$Res> {
  __$$DigitalProxyImplCopyWithImpl(
      _$DigitalProxyImpl _value, $Res Function(_$DigitalProxyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templateId = null,
    Object? templateName = null,
    Object? templateRole = null,
    Object? targetStartDate = freezed,
    Object? targetEndDate = freezed,
    Object? answerStatus = freezed,
  }) {
    return _then(_$DigitalProxyImpl(
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int,
      templateName: null == templateName
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      templateRole: null == templateRole
          ? _value.templateRole
          : templateRole // ignore: cast_nullable_to_non_nullable
              as String,
      targetStartDate: freezed == targetStartDate
          ? _value.targetStartDate
          : targetStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetEndDate: freezed == targetEndDate
          ? _value.targetEndDate
          : targetEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      answerStatus: freezed == answerStatus
          ? _value.answerStatus
          : answerStatus // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAnswerStatusType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalProxyImpl extends DigitalProxy {
  const _$DigitalProxyImpl(
      {required this.templateId,
      required this.templateName,
      required this.templateRole,
      this.targetStartDate,
      this.targetEndDate,
      this.answerStatus,
      final String? $type})
      : $type = $type ?? 'digitalProxy',
        super._();

  factory _$DigitalProxyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalProxyImplFromJson(json);

  @override
  final int templateId;
  @override
  final String templateName;
  @override
  final String templateRole;
  @override
  final DateTime? targetStartDate;
  @override
  final DateTime? targetEndDate;
  @override
  final DigitalDocumentAnswerStatusType? answerStatus;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Document.digitalProxy(templateId: $templateId, templateName: $templateName, templateRole: $templateRole, targetStartDate: $targetStartDate, targetEndDate: $targetEndDate, answerStatus: $answerStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalProxyImpl &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            (identical(other.templateRole, templateRole) ||
                other.templateRole == templateRole) &&
            (identical(other.targetStartDate, targetStartDate) ||
                other.targetStartDate == targetStartDate) &&
            (identical(other.targetEndDate, targetEndDate) ||
                other.targetEndDate == targetEndDate) &&
            (identical(other.answerStatus, answerStatus) ||
                other.answerStatus == answerStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, templateId, templateName,
      templateRole, targetStartDate, targetEndDate, answerStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalProxyImplCopyWith<_$DigitalProxyImpl> get copyWith =>
      __$$DigitalProxyImplCopyWithImpl<_$DigitalProxyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        $default, {
    required TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        poll,
    required TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        digitalProxy,
    required TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)
        digitalDocument,
  }) {
    return digitalProxy(templateId, templateName, templateRole, targetStartDate,
        targetEndDate, answerStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult? Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult? Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult? Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
  }) {
    return digitalProxy?.call(templateId, templateName, templateRole,
        targetStartDate, targetEndDate, answerStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
    required TResult orElse(),
  }) {
    if (digitalProxy != null) {
      return digitalProxy(templateId, templateName, templateRole,
          targetStartDate, targetEndDate, answerStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Document value) $default, {
    required TResult Function(Poll value) poll,
    required TResult Function(DigitalProxy value) digitalProxy,
    required TResult Function(DigitalDocument value) digitalDocument,
  }) {
    return digitalProxy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Document value)? $default, {
    TResult? Function(Poll value)? poll,
    TResult? Function(DigitalProxy value)? digitalProxy,
    TResult? Function(DigitalDocument value)? digitalDocument,
  }) {
    return digitalProxy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Document value)? $default, {
    TResult Function(Poll value)? poll,
    TResult Function(DigitalProxy value)? digitalProxy,
    TResult Function(DigitalDocument value)? digitalDocument,
    required TResult orElse(),
  }) {
    if (digitalProxy != null) {
      return digitalProxy(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalProxyImplToJson(
      this,
    );
  }
}

abstract class DigitalProxy extends Document {
  const factory DigitalProxy(
          {required final int templateId,
          required final String templateName,
          required final String templateRole,
          final DateTime? targetStartDate,
          final DateTime? targetEndDate,
          final DigitalDocumentAnswerStatusType? answerStatus}) =
      _$DigitalProxyImpl;
  const DigitalProxy._() : super._();

  factory DigitalProxy.fromJson(Map<String, dynamic> json) =
      _$DigitalProxyImpl.fromJson;

  int get templateId;
  String get templateName;
  String get templateRole;
  @override
  DateTime? get targetStartDate;
  @override
  DateTime? get targetEndDate;
  @override
  DigitalDocumentAnswerStatusType? get answerStatus;
  @override
  @JsonKey(ignore: true)
  _$$DigitalProxyImplCopyWith<_$DigitalProxyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DigitalDocumentImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DigitalDocumentImplCopyWith(_$DigitalDocumentImpl value,
          $Res Function(_$DigitalDocumentImpl) then) =
      __$$DigitalDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(
          name: 'digitalDocumentType',
          unknownEnumValue: DigitalDocumentType.unknown)
      DigitalDocumentType documentType,
      DigitalDocumentAttachOptions attachOptions,
      DigitalDocumentStock? stock,
      DigitalDocumentUser? user,
      DigitalDocumentAcceptUser? acceptUser,
      @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
      DateTime? targetStartDate,
      DateTime? targetEndDate,
      DigitalDocumentAnswerStatusType? answerStatus,
      int? joinUserCount,
      double? shareholdingRatio,
      String? title});

  $DigitalDocumentAttachOptionsCopyWith<$Res> get attachOptions;
  $DigitalDocumentStockCopyWith<$Res>? get stock;
  $DigitalDocumentUserCopyWith<$Res>? get user;
  $DigitalDocumentAcceptUserCopyWith<$Res>? get acceptUser;
}

/// @nodoc
class __$$DigitalDocumentImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DigitalDocumentImpl>
    implements _$$DigitalDocumentImplCopyWith<$Res> {
  __$$DigitalDocumentImplCopyWithImpl(
      _$DigitalDocumentImpl _value, $Res Function(_$DigitalDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentType = null,
    Object? attachOptions = null,
    Object? stock = freezed,
    Object? user = freezed,
    Object? acceptUser = freezed,
    Object? itemGroups = freezed,
    Object? targetStartDate = freezed,
    Object? targetEndDate = freezed,
    Object? answerStatus = freezed,
    Object? joinUserCount = freezed,
    Object? shareholdingRatio = freezed,
    Object? title = freezed,
  }) {
    return _then(_$DigitalDocumentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      documentType: null == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentType,
      attachOptions: null == attachOptions
          ? _value.attachOptions
          : attachOptions // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAttachOptions,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentStock?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentUser?,
      acceptUser: freezed == acceptUser
          ? _value.acceptUser
          : acceptUser // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAcceptUser?,
      itemGroups: freezed == itemGroups
          ? _value._itemGroups
          : itemGroups // ignore: cast_nullable_to_non_nullable
              as List<DigitalDocumentItem>?,
      targetStartDate: freezed == targetStartDate
          ? _value.targetStartDate
          : targetStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetEndDate: freezed == targetEndDate
          ? _value.targetEndDate
          : targetEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      answerStatus: freezed == answerStatus
          ? _value.answerStatus
          : answerStatus // ignore: cast_nullable_to_non_nullable
              as DigitalDocumentAnswerStatusType?,
      joinUserCount: freezed == joinUserCount
          ? _value.joinUserCount
          : joinUserCount // ignore: cast_nullable_to_non_nullable
              as int?,
      shareholdingRatio: freezed == shareholdingRatio
          ? _value.shareholdingRatio
          : shareholdingRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DigitalDocumentAttachOptionsCopyWith<$Res> get attachOptions {
    return $DigitalDocumentAttachOptionsCopyWith<$Res>(_value.attachOptions,
        (value) {
      return _then(_value.copyWith(attachOptions: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DigitalDocumentStockCopyWith<$Res>? get stock {
    if (_value.stock == null) {
      return null;
    }

    return $DigitalDocumentStockCopyWith<$Res>(_value.stock!, (value) {
      return _then(_value.copyWith(stock: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DigitalDocumentUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $DigitalDocumentUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DigitalDocumentAcceptUserCopyWith<$Res>? get acceptUser {
    if (_value.acceptUser == null) {
      return null;
    }

    return $DigitalDocumentAcceptUserCopyWith<$Res>(_value.acceptUser!,
        (value) {
      return _then(_value.copyWith(acceptUser: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalDocumentImpl extends DigitalDocument {
  const _$DigitalDocumentImpl(
      {required this.id,
      @JsonKey(
          name: 'digitalDocumentType',
          unknownEnumValue: DigitalDocumentType.unknown)
      required this.documentType,
      required this.attachOptions,
      this.stock,
      this.user,
      this.acceptUser,
      @JsonKey(name: 'items') final List<DigitalDocumentItem>? itemGroups,
      this.targetStartDate,
      this.targetEndDate,
      this.answerStatus,
      this.joinUserCount,
      this.shareholdingRatio,
      this.title,
      final String? $type})
      : _itemGroups = itemGroups,
        $type = $type ?? 'digitalDocument',
        super._();

  factory _$DigitalDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalDocumentImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(
      name: 'digitalDocumentType',
      unknownEnumValue: DigitalDocumentType.unknown)
  final DigitalDocumentType documentType;
  @override
  final DigitalDocumentAttachOptions attachOptions;
  @override
  final DigitalDocumentStock? stock;
  @override
  final DigitalDocumentUser? user;
  @override
  final DigitalDocumentAcceptUser? acceptUser;
  final List<DigitalDocumentItem>? _itemGroups;
  @override
  @JsonKey(name: 'items')
  List<DigitalDocumentItem>? get itemGroups {
    final value = _itemGroups;
    if (value == null) return null;
    if (_itemGroups is EqualUnmodifiableListView) return _itemGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? targetStartDate;
  @override
  final DateTime? targetEndDate;
  @override
  final DigitalDocumentAnswerStatusType? answerStatus;
  @override
  final int? joinUserCount;
  @override
  final double? shareholdingRatio;
  @override
  final String? title;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Document.digitalDocument(id: $id, documentType: $documentType, attachOptions: $attachOptions, stock: $stock, user: $user, acceptUser: $acceptUser, itemGroups: $itemGroups, targetStartDate: $targetStartDate, targetEndDate: $targetEndDate, answerStatus: $answerStatus, joinUserCount: $joinUserCount, shareholdingRatio: $shareholdingRatio, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.attachOptions, attachOptions) ||
                other.attachOptions == attachOptions) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.acceptUser, acceptUser) ||
                other.acceptUser == acceptUser) &&
            const DeepCollectionEquality()
                .equals(other._itemGroups, _itemGroups) &&
            (identical(other.targetStartDate, targetStartDate) ||
                other.targetStartDate == targetStartDate) &&
            (identical(other.targetEndDate, targetEndDate) ||
                other.targetEndDate == targetEndDate) &&
            (identical(other.answerStatus, answerStatus) ||
                other.answerStatus == answerStatus) &&
            (identical(other.joinUserCount, joinUserCount) ||
                other.joinUserCount == joinUserCount) &&
            (identical(other.shareholdingRatio, shareholdingRatio) ||
                other.shareholdingRatio == shareholdingRatio) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      documentType,
      attachOptions,
      stock,
      user,
      acceptUser,
      const DeepCollectionEquality().hash(_itemGroups),
      targetStartDate,
      targetEndDate,
      answerStatus,
      joinUserCount,
      shareholdingRatio,
      title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalDocumentImplCopyWith<_$DigitalDocumentImpl> get copyWith =>
      __$$DigitalDocumentImplCopyWithImpl<_$DigitalDocumentImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        $default, {
    required TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        poll,
    required TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)
        digitalProxy,
    required TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)
        digitalDocument,
  }) {
    return digitalDocument(
        id,
        documentType,
        attachOptions,
        stock,
        user,
        acceptUser,
        itemGroups,
        targetStartDate,
        targetEndDate,
        answerStatus,
        joinUserCount,
        shareholdingRatio,
        title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult? Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult? Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult? Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
  }) {
    return digitalDocument?.call(
        id,
        documentType,
        attachOptions,
        stock,
        user,
        acceptUser,
        itemGroups,
        targetStartDate,
        targetEndDate,
        answerStatus,
        joinUserCount,
        shareholdingRatio,
        title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(DateTime? targetStartDate, DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        $default, {
    TResult Function(
            int id,
            int postId,
            String title,
            PollVoteType voteType,
            @JsonKey(name: 'selectionOption') PollSelectionType selectionType,
            String status,
            List<PollItem> pollItems,
            PollViewType viewType,
            String? content,
            List<PollAnswer>? answers,
            @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
            @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        poll,
    TResult Function(
            int templateId,
            String templateName,
            String templateRole,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus)?
        digitalProxy,
    TResult Function(
            int id,
            @JsonKey(
                name: 'digitalDocumentType',
                unknownEnumValue: DigitalDocumentType.unknown)
            DigitalDocumentType documentType,
            DigitalDocumentAttachOptions attachOptions,
            DigitalDocumentStock? stock,
            DigitalDocumentUser? user,
            DigitalDocumentAcceptUser? acceptUser,
            @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
            DateTime? targetStartDate,
            DateTime? targetEndDate,
            DigitalDocumentAnswerStatusType? answerStatus,
            int? joinUserCount,
            double? shareholdingRatio,
            String? title)?
        digitalDocument,
    required TResult orElse(),
  }) {
    if (digitalDocument != null) {
      return digitalDocument(
          id,
          documentType,
          attachOptions,
          stock,
          user,
          acceptUser,
          itemGroups,
          targetStartDate,
          targetEndDate,
          answerStatus,
          joinUserCount,
          shareholdingRatio,
          title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Document value) $default, {
    required TResult Function(Poll value) poll,
    required TResult Function(DigitalProxy value) digitalProxy,
    required TResult Function(DigitalDocument value) digitalDocument,
  }) {
    return digitalDocument(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Document value)? $default, {
    TResult? Function(Poll value)? poll,
    TResult? Function(DigitalProxy value)? digitalProxy,
    TResult? Function(DigitalDocument value)? digitalDocument,
  }) {
    return digitalDocument?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Document value)? $default, {
    TResult Function(Poll value)? poll,
    TResult Function(DigitalProxy value)? digitalProxy,
    TResult Function(DigitalDocument value)? digitalDocument,
    required TResult orElse(),
  }) {
    if (digitalDocument != null) {
      return digitalDocument(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalDocumentImplToJson(
      this,
    );
  }
}

abstract class DigitalDocument extends Document {
  const factory DigitalDocument(
      {required final int id,
      @JsonKey(
          name: 'digitalDocumentType',
          unknownEnumValue: DigitalDocumentType.unknown)
      required final DigitalDocumentType documentType,
      required final DigitalDocumentAttachOptions attachOptions,
      final DigitalDocumentStock? stock,
      final DigitalDocumentUser? user,
      final DigitalDocumentAcceptUser? acceptUser,
      @JsonKey(name: 'items') final List<DigitalDocumentItem>? itemGroups,
      final DateTime? targetStartDate,
      final DateTime? targetEndDate,
      final DigitalDocumentAnswerStatusType? answerStatus,
      final int? joinUserCount,
      final double? shareholdingRatio,
      final String? title}) = _$DigitalDocumentImpl;
  const DigitalDocument._() : super._();

  factory DigitalDocument.fromJson(Map<String, dynamic> json) =
      _$DigitalDocumentImpl.fromJson;

  int get id;
  @JsonKey(
      name: 'digitalDocumentType',
      unknownEnumValue: DigitalDocumentType.unknown)
  DigitalDocumentType get documentType;
  DigitalDocumentAttachOptions get attachOptions;
  DigitalDocumentStock? get stock;
  DigitalDocumentUser? get user;
  DigitalDocumentAcceptUser? get acceptUser;
  @JsonKey(name: 'items')
  List<DigitalDocumentItem>? get itemGroups;
  @override
  DateTime? get targetStartDate;
  @override
  DateTime? get targetEndDate;
  @override
  DigitalDocumentAnswerStatusType? get answerStatus;
  int? get joinUserCount;
  double? get shareholdingRatio;
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$DigitalDocumentImplCopyWith<_$DigitalDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
