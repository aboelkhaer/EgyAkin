// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AuthenticationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthenticationState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AuthenticationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AuthenticationState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ChangePasswordVisibilityImplCopyWith<$Res> {
  factory _$$ChangePasswordVisibilityImplCopyWith(
          _$ChangePasswordVisibilityImpl value,
          $Res Function(_$ChangePasswordVisibilityImpl) then) =
      __$$ChangePasswordVisibilityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool signInObscureText, bool signInVisiblePasswordIcon});
}

/// @nodoc
class __$$ChangePasswordVisibilityImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$ChangePasswordVisibilityImpl>
    implements _$$ChangePasswordVisibilityImplCopyWith<$Res> {
  __$$ChangePasswordVisibilityImplCopyWithImpl(
      _$ChangePasswordVisibilityImpl _value,
      $Res Function(_$ChangePasswordVisibilityImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signInObscureText = null,
    Object? signInVisiblePasswordIcon = null,
  }) {
    return _then(_$ChangePasswordVisibilityImpl(
      null == signInObscureText
          ? _value.signInObscureText
          : signInObscureText // ignore: cast_nullable_to_non_nullable
              as bool,
      null == signInVisiblePasswordIcon
          ? _value.signInVisiblePasswordIcon
          : signInVisiblePasswordIcon // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChangePasswordVisibilityImpl implements _ChangePasswordVisibility {
  const _$ChangePasswordVisibilityImpl(
      this.signInObscureText, this.signInVisiblePasswordIcon);

  @override
  final bool signInObscureText;
  @override
  final bool signInVisiblePasswordIcon;

  @override
  String toString() {
    return 'AuthenticationState.changePasswordVisibility(signInObscureText: $signInObscureText, signInVisiblePasswordIcon: $signInVisiblePasswordIcon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordVisibilityImpl &&
            (identical(other.signInObscureText, signInObscureText) ||
                other.signInObscureText == signInObscureText) &&
            (identical(other.signInVisiblePasswordIcon,
                    signInVisiblePasswordIcon) ||
                other.signInVisiblePasswordIcon == signInVisiblePasswordIcon));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, signInObscureText, signInVisiblePasswordIcon);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordVisibilityImplCopyWith<_$ChangePasswordVisibilityImpl>
      get copyWith => __$$ChangePasswordVisibilityImplCopyWithImpl<
          _$ChangePasswordVisibilityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) {
    return changePasswordVisibility(
        signInObscureText, signInVisiblePasswordIcon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) {
    return changePasswordVisibility?.call(
        signInObscureText, signInVisiblePasswordIcon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (changePasswordVisibility != null) {
      return changePasswordVisibility(
          signInObscureText, signInVisiblePasswordIcon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) {
    return changePasswordVisibility(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) {
    return changePasswordVisibility?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (changePasswordVisibility != null) {
      return changePasswordVisibility(this);
    }
    return orElse();
  }
}

abstract class _ChangePasswordVisibility implements AuthenticationState {
  const factory _ChangePasswordVisibility(
          final bool signInObscureText, final bool signInVisiblePasswordIcon) =
      _$ChangePasswordVisibilityImpl;

  bool get signInObscureText;
  bool get signInVisiblePasswordIcon;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordVisibilityImplCopyWith<_$ChangePasswordVisibilityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckConfirmationImplCopyWith<$Res> {
  factory _$$CheckConfirmationImplCopyWith(_$CheckConfirmationImpl value,
          $Res Function(_$CheckConfirmationImpl) then) =
      __$$CheckConfirmationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int changedCounter});
}

/// @nodoc
class __$$CheckConfirmationImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$CheckConfirmationImpl>
    implements _$$CheckConfirmationImplCopyWith<$Res> {
  __$$CheckConfirmationImplCopyWithImpl(_$CheckConfirmationImpl _value,
      $Res Function(_$CheckConfirmationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? changedCounter = null,
  }) {
    return _then(_$CheckConfirmationImpl(
      null == changedCounter
          ? _value.changedCounter
          : changedCounter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CheckConfirmationImpl implements _CheckConfirmation {
  const _$CheckConfirmationImpl(this.changedCounter);

  @override
  final int changedCounter;

  @override
  String toString() {
    return 'AuthenticationState.checkConfirmation(changedCounter: $changedCounter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckConfirmationImpl &&
            (identical(other.changedCounter, changedCounter) ||
                other.changedCounter == changedCounter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, changedCounter);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckConfirmationImplCopyWith<_$CheckConfirmationImpl> get copyWith =>
      __$$CheckConfirmationImplCopyWithImpl<_$CheckConfirmationImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) {
    return checkConfirmation(changedCounter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) {
    return checkConfirmation?.call(changedCounter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (checkConfirmation != null) {
      return checkConfirmation(changedCounter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) {
    return checkConfirmation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) {
    return checkConfirmation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (checkConfirmation != null) {
      return checkConfirmation(this);
    }
    return orElse();
  }
}

abstract class _CheckConfirmation implements AuthenticationState {
  const factory _CheckConfirmation(final int changedCounter) =
      _$CheckConfirmationImpl;

  int get changedCounter;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckConfirmationImplCopyWith<_$CheckConfirmationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {AuthenticationModelResponse doctorData,
      bool isSignInSuccess,
      bool isRegisterSuccess});

  $AuthenticationModelResponseCopyWith<$Res> get doctorData;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doctorData = null,
    Object? isSignInSuccess = null,
    Object? isRegisterSuccess = null,
  }) {
    return _then(_$LoadedImpl(
      null == doctorData
          ? _value.doctorData
          : doctorData // ignore: cast_nullable_to_non_nullable
              as AuthenticationModelResponse,
      null == isSignInSuccess
          ? _value.isSignInSuccess
          : isSignInSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isRegisterSuccess
          ? _value.isRegisterSuccess
          : isRegisterSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthenticationModelResponseCopyWith<$Res> get doctorData {
    return $AuthenticationModelResponseCopyWith<$Res>(_value.doctorData,
        (value) {
      return _then(_value.copyWith(doctorData: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      this.doctorData, this.isSignInSuccess, this.isRegisterSuccess);

  @override
  final AuthenticationModelResponse doctorData;
  @override
  final bool isSignInSuccess;
  @override
  final bool isRegisterSuccess;

  @override
  String toString() {
    return 'AuthenticationState.loaded(doctorData: $doctorData, isSignInSuccess: $isSignInSuccess, isRegisterSuccess: $isRegisterSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.doctorData, doctorData) ||
                other.doctorData == doctorData) &&
            (identical(other.isSignInSuccess, isSignInSuccess) ||
                other.isSignInSuccess == isSignInSuccess) &&
            (identical(other.isRegisterSuccess, isRegisterSuccess) ||
                other.isRegisterSuccess == isRegisterSuccess));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, doctorData, isSignInSuccess, isRegisterSuccess);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) {
    return loaded(doctorData, isSignInSuccess, isRegisterSuccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(doctorData, isSignInSuccess, isRegisterSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(doctorData, isSignInSuccess, isRegisterSuccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements AuthenticationState {
  const factory _Loaded(final AuthenticationModelResponse doctorData,
      final bool isSignInSuccess, final bool isRegisterSuccess) = _$LoadedImpl;

  AuthenticationModelResponse get doctorData;
  bool get isSignInSuccess;
  bool get isRegisterSuccess;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingWithSocialLoginImplCopyWith<$Res> {
  factory _$$LoadingWithSocialLoginImplCopyWith(
          _$LoadingWithSocialLoginImpl value,
          $Res Function(_$LoadingWithSocialLoginImpl) then) =
      __$$LoadingWithSocialLoginImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingWithSocialLoginImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$LoadingWithSocialLoginImpl>
    implements _$$LoadingWithSocialLoginImplCopyWith<$Res> {
  __$$LoadingWithSocialLoginImplCopyWithImpl(
      _$LoadingWithSocialLoginImpl _value,
      $Res Function(_$LoadingWithSocialLoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingWithSocialLoginImpl implements _LoadingWithSocialLogin {
  const _$LoadingWithSocialLoginImpl();

  @override
  String toString() {
    return 'AuthenticationState.loadingWithSocialLogin()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingWithSocialLoginImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) {
    return loadingWithSocialLogin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) {
    return loadingWithSocialLogin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loadingWithSocialLogin != null) {
      return loadingWithSocialLogin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) {
    return loadingWithSocialLogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) {
    return loadingWithSocialLogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loadingWithSocialLogin != null) {
      return loadingWithSocialLogin(this);
    }
    return orElse();
  }
}

abstract class _LoadingWithSocialLogin implements AuthenticationState {
  const factory _LoadingWithSocialLogin() = _$LoadingWithSocialLoginImpl;
}

/// @nodoc
abstract class _$$LoadedWithSocialLoginImplCopyWith<$Res> {
  factory _$$LoadedWithSocialLoginImplCopyWith(
          _$LoadedWithSocialLoginImpl value,
          $Res Function(_$LoadedWithSocialLoginImpl) then) =
      __$$LoadedWithSocialLoginImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadedWithSocialLoginImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$LoadedWithSocialLoginImpl>
    implements _$$LoadedWithSocialLoginImplCopyWith<$Res> {
  __$$LoadedWithSocialLoginImplCopyWithImpl(_$LoadedWithSocialLoginImpl _value,
      $Res Function(_$LoadedWithSocialLoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadedWithSocialLoginImpl implements _LoadedWithSocialLogin {
  const _$LoadedWithSocialLoginImpl();

  @override
  String toString() {
    return 'AuthenticationState.loadedWithSocialLogin()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedWithSocialLoginImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) {
    return loadedWithSocialLogin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) {
    return loadedWithSocialLogin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loadedWithSocialLogin != null) {
      return loadedWithSocialLogin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) {
    return loadedWithSocialLogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) {
    return loadedWithSocialLogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loadedWithSocialLogin != null) {
      return loadedWithSocialLogin(this);
    }
    return orElse();
  }
}

abstract class _LoadedWithSocialLogin implements AuthenticationState {
  const factory _LoadedWithSocialLogin() = _$LoadedWithSocialLoginImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthenticationState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            bool signInObscureText, bool signInVisiblePasswordIcon)
        changePasswordVisibility,
    required TResult Function(int changedCounter) checkConfirmation,
    required TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)
        loaded,
    required TResult Function() loadingWithSocialLogin,
    required TResult Function() loadedWithSocialLogin,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult? Function(int changedCounter)? checkConfirmation,
    TResult? Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult? Function()? loadingWithSocialLogin,
    TResult? Function()? loadedWithSocialLogin,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool signInObscureText, bool signInVisiblePasswordIcon)?
        changePasswordVisibility,
    TResult Function(int changedCounter)? checkConfirmation,
    TResult Function(AuthenticationModelResponse doctorData,
            bool isSignInSuccess, bool isRegisterSuccess)?
        loaded,
    TResult Function()? loadingWithSocialLogin,
    TResult Function()? loadedWithSocialLogin,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ChangePasswordVisibility value)
        changePasswordVisibility,
    required TResult Function(_CheckConfirmation value) checkConfirmation,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadingWithSocialLogin value)
        loadingWithSocialLogin,
    required TResult Function(_LoadedWithSocialLogin value)
        loadedWithSocialLogin,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ChangePasswordVisibility value)?
        changePasswordVisibility,
    TResult? Function(_CheckConfirmation value)? checkConfirmation,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult? Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ChangePasswordVisibility value)? changePasswordVisibility,
    TResult Function(_CheckConfirmation value)? checkConfirmation,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadingWithSocialLogin value)? loadingWithSocialLogin,
    TResult Function(_LoadedWithSocialLogin value)? loadedWithSocialLogin,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AuthenticationState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
