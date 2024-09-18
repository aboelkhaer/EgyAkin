// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
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
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'HomeState.initial'));
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
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

abstract class _Initial implements HomeState {
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
    extends _$HomeStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'HomeState.loading'));
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
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

abstract class _Loading implements HomeState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {HomeModelResponse homeData,
      DoctorModel currentDoctorModel,
      int dotsPosition,
      int homeIndex,
      bool isUploadingSyndicateCard,
      bool isUploadedSyndicateCard,
      String message,
      int checkUpdateMessageCounter});

  $HomeModelResponseCopyWith<$Res> get homeData;
  $DoctorModelCopyWith<$Res> get currentDoctorModel;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeData = null,
    Object? currentDoctorModel = null,
    Object? dotsPosition = null,
    Object? homeIndex = null,
    Object? isUploadingSyndicateCard = null,
    Object? isUploadedSyndicateCard = null,
    Object? message = null,
    Object? checkUpdateMessageCounter = null,
  }) {
    return _then(_$LoadedImpl(
      null == homeData
          ? _value.homeData
          : homeData // ignore: cast_nullable_to_non_nullable
              as HomeModelResponse,
      null == currentDoctorModel
          ? _value.currentDoctorModel
          : currentDoctorModel // ignore: cast_nullable_to_non_nullable
              as DoctorModel,
      null == dotsPosition
          ? _value.dotsPosition
          : dotsPosition // ignore: cast_nullable_to_non_nullable
              as int,
      null == homeIndex
          ? _value.homeIndex
          : homeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == isUploadingSyndicateCard
          ? _value.isUploadingSyndicateCard
          : isUploadingSyndicateCard // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isUploadedSyndicateCard
          ? _value.isUploadedSyndicateCard
          : isUploadedSyndicateCard // ignore: cast_nullable_to_non_nullable
              as bool,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == checkUpdateMessageCounter
          ? _value.checkUpdateMessageCounter
          : checkUpdateMessageCounter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $HomeModelResponseCopyWith<$Res> get homeData {
    return $HomeModelResponseCopyWith<$Res>(_value.homeData, (value) {
      return _then(_value.copyWith(homeData: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res> get currentDoctorModel {
    return $DoctorModelCopyWith<$Res>(_value.currentDoctorModel, (value) {
      return _then(_value.copyWith(currentDoctorModel: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl with DiagnosticableTreeMixin implements _Loaded {
  const _$LoadedImpl(
      this.homeData,
      this.currentDoctorModel,
      this.dotsPosition,
      this.homeIndex,
      this.isUploadingSyndicateCard,
      this.isUploadedSyndicateCard,
      this.message,
      this.checkUpdateMessageCounter);

  @override
  final HomeModelResponse homeData;
  @override
  final DoctorModel currentDoctorModel;
  @override
  final int dotsPosition;
  @override
  final int homeIndex;
  @override
  final bool isUploadingSyndicateCard;
  @override
  final bool isUploadedSyndicateCard;
  @override
  final String message;
  @override
  final int checkUpdateMessageCounter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState.loaded(homeData: $homeData, currentDoctorModel: $currentDoctorModel, dotsPosition: $dotsPosition, homeIndex: $homeIndex, isUploadingSyndicateCard: $isUploadingSyndicateCard, isUploadedSyndicateCard: $isUploadedSyndicateCard, message: $message, checkUpdateMessageCounter: $checkUpdateMessageCounter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomeState.loaded'))
      ..add(DiagnosticsProperty('homeData', homeData))
      ..add(DiagnosticsProperty('currentDoctorModel', currentDoctorModel))
      ..add(DiagnosticsProperty('dotsPosition', dotsPosition))
      ..add(DiagnosticsProperty('homeIndex', homeIndex))
      ..add(DiagnosticsProperty(
          'isUploadingSyndicateCard', isUploadingSyndicateCard))
      ..add(DiagnosticsProperty(
          'isUploadedSyndicateCard', isUploadedSyndicateCard))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty(
          'checkUpdateMessageCounter', checkUpdateMessageCounter));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.homeData, homeData) ||
                other.homeData == homeData) &&
            (identical(other.currentDoctorModel, currentDoctorModel) ||
                other.currentDoctorModel == currentDoctorModel) &&
            (identical(other.dotsPosition, dotsPosition) ||
                other.dotsPosition == dotsPosition) &&
            (identical(other.homeIndex, homeIndex) ||
                other.homeIndex == homeIndex) &&
            (identical(
                    other.isUploadingSyndicateCard, isUploadingSyndicateCard) ||
                other.isUploadingSyndicateCard == isUploadingSyndicateCard) &&
            (identical(
                    other.isUploadedSyndicateCard, isUploadedSyndicateCard) ||
                other.isUploadedSyndicateCard == isUploadedSyndicateCard) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.checkUpdateMessageCounter,
                    checkUpdateMessageCounter) ||
                other.checkUpdateMessageCounter == checkUpdateMessageCounter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      homeData,
      currentDoctorModel,
      dotsPosition,
      homeIndex,
      isUploadingSyndicateCard,
      isUploadedSyndicateCard,
      message,
      checkUpdateMessageCounter);

  @JsonKey(ignore: true)
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
        homeData,
        currentDoctorModel,
        dotsPosition,
        homeIndex,
        isUploadingSyndicateCard,
        isUploadedSyndicateCard,
        message,
        checkUpdateMessageCounter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
        homeData,
        currentDoctorModel,
        dotsPosition,
        homeIndex,
        isUploadingSyndicateCard,
        isUploadedSyndicateCard,
        message,
        checkUpdateMessageCounter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          homeData,
          currentDoctorModel,
          dotsPosition,
          homeIndex,
          isUploadingSyndicateCard,
          isUploadedSyndicateCard,
          message,
          checkUpdateMessageCounter);
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

abstract class _Loaded implements HomeState {
  const factory _Loaded(
      final HomeModelResponse homeData,
      final DoctorModel currentDoctorModel,
      final int dotsPosition,
      final int homeIndex,
      final bool isUploadingSyndicateCard,
      final bool isUploadedSyndicateCard,
      final String message,
      final int checkUpdateMessageCounter) = _$LoadedImpl;

  HomeModelResponse get homeData;
  DoctorModel get currentDoctorModel;
  int get dotsPosition;
  int get homeIndex;
  bool get isUploadingSyndicateCard;
  bool get isUploadedSyndicateCard;
  String get message;
  int get checkUpdateMessageCounter;
  @JsonKey(ignore: true)
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
    extends _$HomeStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

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

class _$ErrorImpl with DiagnosticableTreeMixin implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomeState.error'))
      ..add(DiagnosticsProperty('message', message));
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

  @JsonKey(ignore: true)
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
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
            HomeModelResponse homeData,
            DoctorModel currentDoctorModel,
            int dotsPosition,
            int homeIndex,
            bool isUploadingSyndicateCard,
            bool isUploadedSyndicateCard,
            String message,
            int checkUpdateMessageCounter)?
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

abstract class _Error implements HomeState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
