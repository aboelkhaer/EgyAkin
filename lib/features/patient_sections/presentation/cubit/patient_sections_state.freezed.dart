// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_sections_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PatientSectionsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
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
abstract class $PatientSectionsStateCopyWith<$Res> {
  factory $PatientSectionsStateCopyWith(PatientSectionsState value,
          $Res Function(PatientSectionsState) then) =
      _$PatientSectionsStateCopyWithImpl<$Res, PatientSectionsState>;
}

/// @nodoc
class _$PatientSectionsStateCopyWithImpl<$Res,
        $Val extends PatientSectionsState>
    implements $PatientSectionsStateCopyWith<$Res> {
  _$PatientSectionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientSectionsState
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
    extends _$PatientSectionsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientSectionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'PatientSectionsState.initial()';
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
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

abstract class _Initial implements PatientSectionsState {
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
    extends _$PatientSectionsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientSectionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'PatientSectionsState.loading()';
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
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

abstract class _Loading implements PatientSectionsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {GetPatientSectionsModelResponse response,
      bool isDelete,
      bool isFinalSubmit,
      String message,
      bool isLoading,
      double reportProgress,
      String filePath,
      bool isDownloadingReport,
      bool isDownloadedReport});

  $GetPatientSectionsModelResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$PatientSectionsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientSectionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? isDelete = null,
    Object? isFinalSubmit = null,
    Object? message = null,
    Object? isLoading = null,
    Object? reportProgress = null,
    Object? filePath = null,
    Object? isDownloadingReport = null,
    Object? isDownloadedReport = null,
  }) {
    return _then(_$LoadedImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as GetPatientSectionsModelResponse,
      null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isFinalSubmit
          ? _value.isFinalSubmit
          : isFinalSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == reportProgress
          ? _value.reportProgress
          : reportProgress // ignore: cast_nullable_to_non_nullable
              as double,
      null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      null == isDownloadingReport
          ? _value.isDownloadingReport
          : isDownloadingReport // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isDownloadedReport
          ? _value.isDownloadedReport
          : isDownloadedReport // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of PatientSectionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetPatientSectionsModelResponseCopyWith<$Res> get response {
    return $GetPatientSectionsModelResponseCopyWith<$Res>(_value.response,
        (value) {
      return _then(_value.copyWith(response: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      this.response,
      this.isDelete,
      this.isFinalSubmit,
      this.message,
      this.isLoading,
      this.reportProgress,
      this.filePath,
      this.isDownloadingReport,
      this.isDownloadedReport);

  @override
  final GetPatientSectionsModelResponse response;
  @override
  final bool isDelete;
  @override
  final bool isFinalSubmit;
  @override
  final String message;
  @override
  final bool isLoading;
  @override
  final double reportProgress;
  @override
  final String filePath;
  @override
  final bool isDownloadingReport;
  @override
  final bool isDownloadedReport;

  @override
  String toString() {
    return 'PatientSectionsState.loaded(response: $response, isDelete: $isDelete, isFinalSubmit: $isFinalSubmit, message: $message, isLoading: $isLoading, reportProgress: $reportProgress, filePath: $filePath, isDownloadingReport: $isDownloadingReport, isDownloadedReport: $isDownloadedReport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.isFinalSubmit, isFinalSubmit) ||
                other.isFinalSubmit == isFinalSubmit) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.reportProgress, reportProgress) ||
                other.reportProgress == reportProgress) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.isDownloadingReport, isDownloadingReport) ||
                other.isDownloadingReport == isDownloadingReport) &&
            (identical(other.isDownloadedReport, isDownloadedReport) ||
                other.isDownloadedReport == isDownloadedReport));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      response,
      isDelete,
      isFinalSubmit,
      message,
      isLoading,
      reportProgress,
      filePath,
      isDownloadingReport,
      isDownloadedReport);

  /// Create a copy of PatientSectionsState
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(response, isDelete, isFinalSubmit, message, isLoading,
        reportProgress, filePath, isDownloadingReport, isDownloadedReport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(response, isDelete, isFinalSubmit, message, isLoading,
        reportProgress, filePath, isDownloadingReport, isDownloadedReport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(response, isDelete, isFinalSubmit, message, isLoading,
          reportProgress, filePath, isDownloadingReport, isDownloadedReport);
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

abstract class _Loaded implements PatientSectionsState {
  const factory _Loaded(
      final GetPatientSectionsModelResponse response,
      final bool isDelete,
      final bool isFinalSubmit,
      final String message,
      final bool isLoading,
      final double reportProgress,
      final String filePath,
      final bool isDownloadingReport,
      final bool isDownloadedReport) = _$LoadedImpl;

  GetPatientSectionsModelResponse get response;
  bool get isDelete;
  bool get isFinalSubmit;
  String get message;
  bool get isLoading;
  double get reportProgress;
  String get filePath;
  bool get isDownloadingReport;
  bool get isDownloadedReport;

  /// Create a copy of PatientSectionsState
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
    extends _$PatientSectionsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientSectionsState
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
    return 'PatientSectionsState.error(message: $message)';
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

  /// Create a copy of PatientSectionsState
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
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
            GetPatientSectionsModelResponse response,
            bool isDelete,
            bool isFinalSubmit,
            String message,
            bool isLoading,
            double reportProgress,
            String filePath,
            bool isDownloadingReport,
            bool isDownloadedReport)?
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

abstract class _Error implements PatientSectionsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of PatientSectionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
