// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outcome_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OutcomeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
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
abstract class $OutcomeStateCopyWith<$Res> {
  factory $OutcomeStateCopyWith(
          OutcomeState value, $Res Function(OutcomeState) then) =
      _$OutcomeStateCopyWithImpl<$Res, OutcomeState>;
}

/// @nodoc
class _$OutcomeStateCopyWithImpl<$Res, $Val extends OutcomeState>
    implements $OutcomeStateCopyWith<$Res> {
  _$OutcomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutcomeState
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
    extends _$OutcomeStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutcomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'OutcomeState.initial()';
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
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

abstract class _Initial implements OutcomeState {
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
    extends _$OutcomeStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutcomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'OutcomeState.loading()';
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
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

abstract class _Loading implements OutcomeState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<QuestionModel> questionList,
      bool isSubmitedOutcome,
      String message,
      int snackbarErrorCounter,
      bool isSubmitedOutcomeLoading,
      OutcomeSubmitterModel submitter});

  $OutcomeSubmitterModelCopyWith<$Res> get submitter;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$OutcomeStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutcomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionList = null,
    Object? isSubmitedOutcome = null,
    Object? message = null,
    Object? snackbarErrorCounter = null,
    Object? isSubmitedOutcomeLoading = null,
    Object? submitter = null,
  }) {
    return _then(_$LoadedImpl(
      null == questionList
          ? _value._questionList
          : questionList // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>,
      null == isSubmitedOutcome
          ? _value.isSubmitedOutcome
          : isSubmitedOutcome // ignore: cast_nullable_to_non_nullable
              as bool,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == snackbarErrorCounter
          ? _value.snackbarErrorCounter
          : snackbarErrorCounter // ignore: cast_nullable_to_non_nullable
              as int,
      null == isSubmitedOutcomeLoading
          ? _value.isSubmitedOutcomeLoading
          : isSubmitedOutcomeLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == submitter
          ? _value.submitter
          : submitter // ignore: cast_nullable_to_non_nullable
              as OutcomeSubmitterModel,
    ));
  }

  /// Create a copy of OutcomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutcomeSubmitterModelCopyWith<$Res> get submitter {
    return $OutcomeSubmitterModelCopyWith<$Res>(_value.submitter, (value) {
      return _then(_value.copyWith(submitter: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      final List<QuestionModel> questionList,
      this.isSubmitedOutcome,
      this.message,
      this.snackbarErrorCounter,
      this.isSubmitedOutcomeLoading,
      this.submitter)
      : _questionList = questionList;

  final List<QuestionModel> _questionList;
  @override
  List<QuestionModel> get questionList {
    if (_questionList is EqualUnmodifiableListView) return _questionList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionList);
  }

  @override
  final bool isSubmitedOutcome;
  @override
  final String message;
  @override
  final int snackbarErrorCounter;
  @override
  final bool isSubmitedOutcomeLoading;
  @override
  final OutcomeSubmitterModel submitter;

  @override
  String toString() {
    return 'OutcomeState.loaded(questionList: $questionList, isSubmitedOutcome: $isSubmitedOutcome, message: $message, snackbarErrorCounter: $snackbarErrorCounter, isSubmitedOutcomeLoading: $isSubmitedOutcomeLoading, submitter: $submitter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._questionList, _questionList) &&
            (identical(other.isSubmitedOutcome, isSubmitedOutcome) ||
                other.isSubmitedOutcome == isSubmitedOutcome) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.snackbarErrorCounter, snackbarErrorCounter) ||
                other.snackbarErrorCounter == snackbarErrorCounter) &&
            (identical(
                    other.isSubmitedOutcomeLoading, isSubmitedOutcomeLoading) ||
                other.isSubmitedOutcomeLoading == isSubmitedOutcomeLoading) &&
            (identical(other.submitter, submitter) ||
                other.submitter == submitter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_questionList),
      isSubmitedOutcome,
      message,
      snackbarErrorCounter,
      isSubmitedOutcomeLoading,
      submitter);

  /// Create a copy of OutcomeState
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(questionList, isSubmitedOutcome, message,
        snackbarErrorCounter, isSubmitedOutcomeLoading, submitter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(questionList, isSubmitedOutcome, message,
        snackbarErrorCounter, isSubmitedOutcomeLoading, submitter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(questionList, isSubmitedOutcome, message,
          snackbarErrorCounter, isSubmitedOutcomeLoading, submitter);
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

abstract class _Loaded implements OutcomeState {
  const factory _Loaded(
      final List<QuestionModel> questionList,
      final bool isSubmitedOutcome,
      final String message,
      final int snackbarErrorCounter,
      final bool isSubmitedOutcomeLoading,
      final OutcomeSubmitterModel submitter) = _$LoadedImpl;

  List<QuestionModel> get questionList;
  bool get isSubmitedOutcome;
  String get message;
  int get snackbarErrorCounter;
  bool get isSubmitedOutcomeLoading;
  OutcomeSubmitterModel get submitter;

  /// Create a copy of OutcomeState
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
    extends _$OutcomeStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutcomeState
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
    return 'OutcomeState.error(message: $message)';
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

  /// Create a copy of OutcomeState
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
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
            List<QuestionModel> questionList,
            bool isSubmitedOutcome,
            String message,
            int snackbarErrorCounter,
            bool isSubmitedOutcomeLoading,
            OutcomeSubmitterModel submitter)?
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

abstract class _Error implements OutcomeState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of OutcomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
