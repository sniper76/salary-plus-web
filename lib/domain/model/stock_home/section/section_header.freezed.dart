// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_header.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SectionHeader _$SectionHeaderFromJson(Map<String, dynamic> json) {
  return _SectionHeader.fromJson(json);
}

/// @nodoc
mixin _$SectionHeader {
  String get title => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionHeaderCopyWith<SectionHeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionHeaderCopyWith<$Res> {
  factory $SectionHeaderCopyWith(
          SectionHeader value, $Res Function(SectionHeader) then) =
      _$SectionHeaderCopyWithImpl<$Res, SectionHeader>;
  @useResult
  $Res call({String title, String link, String? imageUrl});
}

/// @nodoc
class _$SectionHeaderCopyWithImpl<$Res, $Val extends SectionHeader>
    implements $SectionHeaderCopyWith<$Res> {
  _$SectionHeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? link = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionHeaderImplCopyWith<$Res>
    implements $SectionHeaderCopyWith<$Res> {
  factory _$$SectionHeaderImplCopyWith(
          _$SectionHeaderImpl value, $Res Function(_$SectionHeaderImpl) then) =
      __$$SectionHeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String link, String? imageUrl});
}

/// @nodoc
class __$$SectionHeaderImplCopyWithImpl<$Res>
    extends _$SectionHeaderCopyWithImpl<$Res, _$SectionHeaderImpl>
    implements _$$SectionHeaderImplCopyWith<$Res> {
  __$$SectionHeaderImplCopyWithImpl(
      _$SectionHeaderImpl _value, $Res Function(_$SectionHeaderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? link = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$SectionHeaderImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionHeaderImpl implements _SectionHeader {
  const _$SectionHeaderImpl(
      {required this.title, required this.link, this.imageUrl});

  factory _$SectionHeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionHeaderImplFromJson(json);

  @override
  final String title;
  @override
  final String link;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'SectionHeader(title: $title, link: $link, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionHeaderImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, link, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionHeaderImplCopyWith<_$SectionHeaderImpl> get copyWith =>
      __$$SectionHeaderImplCopyWithImpl<_$SectionHeaderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionHeaderImplToJson(
      this,
    );
  }
}

abstract class _SectionHeader implements SectionHeader {
  const factory _SectionHeader(
      {required final String title,
      required final String link,
      final String? imageUrl}) = _$SectionHeaderImpl;

  factory _SectionHeader.fromJson(Map<String, dynamic> json) =
      _$SectionHeaderImpl.fromJson;

  @override
  String get title;
  @override
  String get link;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$SectionHeaderImplCopyWith<_$SectionHeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
