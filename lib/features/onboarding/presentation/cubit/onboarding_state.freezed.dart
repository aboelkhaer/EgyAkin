// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnboardingState {
  int get dotsPosition => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int dotsPosition) changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int dotsPosition)? changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int dotsPosition)? changed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Changed value) changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Changed value)? changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Changed value)? changed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) then) =
      _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call({int dotsPosition});
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dotsPosition = null,
  }) {
    return _then(_value.copyWith(
      dotsPosition: null == dotsPosition
          ? _value.dotsPosition
          : dotsPosition // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangedImplCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$ChangedImplCopyWith(
          _$ChangedImpl value, $Res Function(_$ChangedImpl) then) =
      __$$ChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int dotsPosition});
}

/// @nodoc
class __$$ChangedImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$ChangedImpl>
    implements _$$ChangedImplCopyWith<$Res> {
  __$$ChangedImplCopyWithImpl(
      _$ChangedImpl _value, $Res Function(_$ChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dotsPosition = null,
  }) {
    return _then(_$ChangedImpl(
      null == dotsPosition
          ? _value.dotsPosition
          : dotsPosition // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ChangedImpl implements _Changed {
  const _$ChangedImpl(this.dotsPosition);

  @override
  final int dotsPosition;

  @override
  String toString() {
    return 'OnboardingState.changed(dotsPosition: $dotsPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangedImpl &&
            (identical(other.dotsPosition, dotsPosition) ||
                other.dotsPosition == dotsPosition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dotsPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangedImplCopyWith<_$ChangedImpl> get copyWith =>
      __$$ChangedImplCopyWithImpl<_$ChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int dotsPosition) changed,
  }) {
    return changed(dotsPosition);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int dotsPosition)? changed,
  }) {
    return changed?.call(dotsPosition);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int dotsPosition)? changed,
    required TResult orElse(),
  }) {
    if (changed != null) {
      return changed(dotsPosition);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Changed value) changed,
  }) {
    return changed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Changed value)? changed,
  }) {
    return changed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Changed value)? changed,
    required TResult orElse(),
  }) {
    if (changed != null) {
      return changed(this);
    }
    return orElse();
  }
}

abstract class _Changed implements OnboardingState {
  const factory _Changed(final int dotsPosition) = _$ChangedImpl;

  @override
  int get dotsPosition;
  @override
  @JsonKey(ignore: true)
  _$$ChangedImplCopyWith<_$ChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
