// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String email, String password) login,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String email, String password)? login,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String email, String password)? login,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnLogin value) login,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnLogin value)? login,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnLogin value)? login,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res, LoginEvent>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OnInitImplCopyWith<$Res> {
  factory _$$OnInitImplCopyWith(
          _$OnInitImpl value, $Res Function(_$OnInitImpl) then) =
      __$$OnInitImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnInitImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$OnInitImpl>
    implements _$$OnInitImplCopyWith<$Res> {
  __$$OnInitImplCopyWithImpl(
      _$OnInitImpl _value, $Res Function(_$OnInitImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OnInitImpl implements _OnInit {
  const _$OnInitImpl();

  @override
  String toString() {
    return 'LoginEvent.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnInitImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String email, String password) login,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String email, String password)? login,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String email, String password)? login,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnLogin value) login,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnLogin value)? login,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnLogin value)? login,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _OnInit implements LoginEvent {
  const factory _OnInit() = _$OnInitImpl;
}

/// @nodoc
abstract class _$$OnLoginImplCopyWith<$Res> {
  factory _$$OnLoginImplCopyWith(
          _$OnLoginImpl value, $Res Function(_$OnLoginImpl) then) =
      __$$OnLoginImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$OnLoginImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$OnLoginImpl>
    implements _$$OnLoginImplCopyWith<$Res> {
  __$$OnLoginImplCopyWithImpl(
      _$OnLoginImpl _value, $Res Function(_$OnLoginImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$OnLoginImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OnLoginImpl implements _OnLogin {
  const _$OnLoginImpl(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginEvent.login(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnLoginImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnLoginImplCopyWith<_$OnLoginImpl> get copyWith =>
      __$$OnLoginImplCopyWithImpl<_$OnLoginImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String email, String password) login,
  }) {
    return login(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(String email, String password)? login,
  }) {
    return login?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String email, String password)? login,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OnInit value) init,
    required TResult Function(_OnLogin value) login,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OnInit value)? init,
    TResult? Function(_OnLogin value)? login,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OnInit value)? init,
    TResult Function(_OnLogin value)? login,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class _OnLogin implements LoginEvent {
  const factory _OnLogin(final String email, final String password) =
      _$OnLoginImpl;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$OnLoginImplCopyWith<_$OnLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoginState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool? get isLoggedIn => throw _privateConstructorUsedError;
  bool? get isNewUser => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  bool? get passwordChanged => throw _privateConstructorUsedError;
  String? get errorToastMessage => throw _privateConstructorUsedError;
  String? get notiToastMessage => throw _privateConstructorUsedError;
  List<Post> get globalBoardPosts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool? isLoggedIn,
      bool? isNewUser,
      User? user,
      bool? passwordChanged,
      String? errorToastMessage,
      String? notiToastMessage,
      List<Post> globalBoardPosts});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoggedIn = freezed,
    Object? isNewUser = freezed,
    Object? user = freezed,
    Object? passwordChanged = freezed,
    Object? errorToastMessage = freezed,
    Object? notiToastMessage = freezed,
    Object? globalBoardPosts = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoggedIn: freezed == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool?,
      isNewUser: freezed == isNewUser
          ? _value.isNewUser
          : isNewUser // ignore: cast_nullable_to_non_nullable
              as bool?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      passwordChanged: freezed == passwordChanged
          ? _value.passwordChanged
          : passwordChanged // ignore: cast_nullable_to_non_nullable
              as bool?,
      errorToastMessage: freezed == errorToastMessage
          ? _value.errorToastMessage
          : errorToastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      notiToastMessage: freezed == notiToastMessage
          ? _value.notiToastMessage
          : notiToastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      globalBoardPosts: null == globalBoardPosts
          ? _value.globalBoardPosts
          : globalBoardPosts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool? isLoggedIn,
      bool? isNewUser,
      User? user,
      bool? passwordChanged,
      String? errorToastMessage,
      String? notiToastMessage,
      List<Post> globalBoardPosts});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoggedIn = freezed,
    Object? isNewUser = freezed,
    Object? user = freezed,
    Object? passwordChanged = freezed,
    Object? errorToastMessage = freezed,
    Object? notiToastMessage = freezed,
    Object? globalBoardPosts = null,
  }) {
    return _then(_$LoginStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoggedIn: freezed == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool?,
      isNewUser: freezed == isNewUser
          ? _value.isNewUser
          : isNewUser // ignore: cast_nullable_to_non_nullable
              as bool?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      passwordChanged: freezed == passwordChanged
          ? _value.passwordChanged
          : passwordChanged // ignore: cast_nullable_to_non_nullable
              as bool?,
      errorToastMessage: freezed == errorToastMessage
          ? _value.errorToastMessage
          : errorToastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      notiToastMessage: freezed == notiToastMessage
          ? _value.notiToastMessage
          : notiToastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      globalBoardPosts: null == globalBoardPosts
          ? _value._globalBoardPosts
          : globalBoardPosts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  _$LoginStateImpl(
      {required this.isLoading,
      this.isLoggedIn,
      this.isNewUser,
      this.user = null,
      this.passwordChanged,
      this.errorToastMessage = null,
      this.notiToastMessage = null,
      final List<Post> globalBoardPosts = const []})
      : _globalBoardPosts = globalBoardPosts;

  @override
  final bool isLoading;
  @override
  final bool? isLoggedIn;
  @override
  final bool? isNewUser;
  @override
  @JsonKey()
  final User? user;
  @override
  final bool? passwordChanged;
  @override
  @JsonKey()
  final String? errorToastMessage;
  @override
  @JsonKey()
  final String? notiToastMessage;
  final List<Post> _globalBoardPosts;
  @override
  @JsonKey()
  List<Post> get globalBoardPosts {
    if (_globalBoardPosts is EqualUnmodifiableListView)
      return _globalBoardPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_globalBoardPosts);
  }

  @override
  String toString() {
    return 'LoginState(isLoading: $isLoading, isLoggedIn: $isLoggedIn, isNewUser: $isNewUser, user: $user, passwordChanged: $passwordChanged, errorToastMessage: $errorToastMessage, notiToastMessage: $notiToastMessage, globalBoardPosts: $globalBoardPosts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn) &&
            (identical(other.isNewUser, isNewUser) ||
                other.isNewUser == isNewUser) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.passwordChanged, passwordChanged) ||
                other.passwordChanged == passwordChanged) &&
            (identical(other.errorToastMessage, errorToastMessage) ||
                other.errorToastMessage == errorToastMessage) &&
            (identical(other.notiToastMessage, notiToastMessage) ||
                other.notiToastMessage == notiToastMessage) &&
            const DeepCollectionEquality()
                .equals(other._globalBoardPosts, _globalBoardPosts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isLoggedIn,
      isNewUser,
      user,
      passwordChanged,
      errorToastMessage,
      notiToastMessage,
      const DeepCollectionEquality().hash(_globalBoardPosts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  factory _LoginState(
      {required final bool isLoading,
      final bool? isLoggedIn,
      final bool? isNewUser,
      final User? user,
      final bool? passwordChanged,
      final String? errorToastMessage,
      final String? notiToastMessage,
      final List<Post> globalBoardPosts}) = _$LoginStateImpl;

  @override
  bool get isLoading;
  @override
  bool? get isLoggedIn;
  @override
  bool? get isNewUser;
  @override
  User? get user;
  @override
  bool? get passwordChanged;
  @override
  String? get errorToastMessage;
  @override
  String? get notiToastMessage;
  @override
  List<Post> get globalBoardPosts;
  @override
  @JsonKey(ignore: true)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
