// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_members_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroupMembersState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupMembersStateCopyWith<$Res> {
  factory $GroupMembersStateCopyWith(
          GroupMembersState value, $Res Function(GroupMembersState) then) =
      _$GroupMembersStateCopyWithImpl<$Res, GroupMembersState>;
}

/// @nodoc
class _$GroupMembersStateCopyWithImpl<$Res, $Val extends GroupMembersState>
    implements $GroupMembersStateCopyWith<$Res> {
  _$GroupMembersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupMembersState
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
    extends _$GroupMembersStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'GroupMembersState.initial()';
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
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements GroupMembersState {
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
    extends _$GroupMembersStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'GroupMembersState.loading()';
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
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements GroupMembersState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String snackBarMessage,
      String dialogMessage,
      GetGroupMembersModelResponse response,
      bool isSeeMore,
      bool isRemoveMemberFromGroupLoading,
      bool isRemoveMemberFromGroupLoaded});

  $GetGroupMembersModelResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$GroupMembersStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? snackBarMessage = null,
    Object? dialogMessage = null,
    Object? response = null,
    Object? isSeeMore = null,
    Object? isRemoveMemberFromGroupLoading = null,
    Object? isRemoveMemberFromGroupLoaded = null,
  }) {
    return _then(_$LoadedImpl(
      null == snackBarMessage
          ? _value.snackBarMessage
          : snackBarMessage // ignore: cast_nullable_to_non_nullable
              as String,
      null == dialogMessage
          ? _value.dialogMessage
          : dialogMessage // ignore: cast_nullable_to_non_nullable
              as String,
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as GetGroupMembersModelResponse,
      null == isSeeMore
          ? _value.isSeeMore
          : isSeeMore // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isRemoveMemberFromGroupLoading
          ? _value.isRemoveMemberFromGroupLoading
          : isRemoveMemberFromGroupLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isRemoveMemberFromGroupLoaded
          ? _value.isRemoveMemberFromGroupLoaded
          : isRemoveMemberFromGroupLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetGroupMembersModelResponseCopyWith<$Res> get response {
    return $GetGroupMembersModelResponseCopyWith<$Res>(_value.response,
        (value) {
      return _then(_value.copyWith(response: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      this.snackBarMessage,
      this.dialogMessage,
      this.response,
      this.isSeeMore,
      this.isRemoveMemberFromGroupLoading,
      this.isRemoveMemberFromGroupLoaded);

  @override
  final String snackBarMessage;
  @override
  final String dialogMessage;
  @override
  final GetGroupMembersModelResponse response;
  @override
  final bool isSeeMore;
  @override
  final bool isRemoveMemberFromGroupLoading;
  @override
  final bool isRemoveMemberFromGroupLoaded;

  @override
  String toString() {
    return 'GroupMembersState.loaded(snackBarMessage: $snackBarMessage, dialogMessage: $dialogMessage, response: $response, isSeeMore: $isSeeMore, isRemoveMemberFromGroupLoading: $isRemoveMemberFromGroupLoading, isRemoveMemberFromGroupLoaded: $isRemoveMemberFromGroupLoaded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.snackBarMessage, snackBarMessage) ||
                other.snackBarMessage == snackBarMessage) &&
            (identical(other.dialogMessage, dialogMessage) ||
                other.dialogMessage == dialogMessage) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.isSeeMore, isSeeMore) ||
                other.isSeeMore == isSeeMore) &&
            (identical(other.isRemoveMemberFromGroupLoading,
                    isRemoveMemberFromGroupLoading) ||
                other.isRemoveMemberFromGroupLoading ==
                    isRemoveMemberFromGroupLoading) &&
            (identical(other.isRemoveMemberFromGroupLoaded,
                    isRemoveMemberFromGroupLoaded) ||
                other.isRemoveMemberFromGroupLoaded ==
                    isRemoveMemberFromGroupLoaded));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      snackBarMessage,
      dialogMessage,
      response,
      isSeeMore,
      isRemoveMemberFromGroupLoading,
      isRemoveMemberFromGroupLoaded);

  /// Create a copy of GroupMembersState
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
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(snackBarMessage, dialogMessage, response, isSeeMore,
        isRemoveMemberFromGroupLoading, isRemoveMemberFromGroupLoaded);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(snackBarMessage, dialogMessage, response, isSeeMore,
        isRemoveMemberFromGroupLoading, isRemoveMemberFromGroupLoaded);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(snackBarMessage, dialogMessage, response, isSeeMore,
          isRemoveMemberFromGroupLoading, isRemoveMemberFromGroupLoaded);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements GroupMembersState {
  const factory _Loaded(
      final String snackBarMessage,
      final String dialogMessage,
      final GetGroupMembersModelResponse response,
      final bool isSeeMore,
      final bool isRemoveMemberFromGroupLoading,
      final bool isRemoveMemberFromGroupLoaded) = _$LoadedImpl;

  String get snackBarMessage;
  String get dialogMessage;
  GetGroupMembersModelResponse get response;
  bool get isSeeMore;
  bool get isRemoveMemberFromGroupLoading;
  bool get isRemoveMemberFromGroupLoaded;

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$GroupMembersStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupMembersState
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
    return 'GroupMembersState.error(message: $message)';
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

  /// Create a copy of GroupMembersState
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
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            String snackBarMessage,
            String dialogMessage,
            GetGroupMembersModelResponse response,
            bool isSeeMore,
            bool isRemoveMemberFromGroupLoading,
            bool isRemoveMemberFromGroupLoaded)?
        loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements GroupMembersState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
