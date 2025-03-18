// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PollModel _$PollModelFromJson(Map<String, dynamic> json) {
  return _PollModel.fromJson(json);
}

/// @nodoc
mixin _$PollModel {
  String? get question => throw _privateConstructorUsedError;
  List<String>? get options => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_multiple_choice')
  bool? get allowMultipleChoices => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_add_options')
  bool? get allowAddOptions => throw _privateConstructorUsedError;

  /// Serializes this PollModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PollModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollModelCopyWith<PollModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollModelCopyWith<$Res> {
  factory $PollModelCopyWith(PollModel value, $Res Function(PollModel) then) =
      _$PollModelCopyWithImpl<$Res, PollModel>;
  @useResult
  $Res call(
      {String? question,
      List<String>? options,
      @JsonKey(name: 'allow_multiple_choice') bool? allowMultipleChoices,
      @JsonKey(name: 'allow_add_options') bool? allowAddOptions});
}

/// @nodoc
class _$PollModelCopyWithImpl<$Res, $Val extends PollModel>
    implements $PollModelCopyWith<$Res> {
  _$PollModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = freezed,
    Object? options = freezed,
    Object? allowMultipleChoices = freezed,
    Object? allowAddOptions = freezed,
  }) {
    return _then(_value.copyWith(
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      allowMultipleChoices: freezed == allowMultipleChoices
          ? _value.allowMultipleChoices
          : allowMultipleChoices // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowAddOptions: freezed == allowAddOptions
          ? _value.allowAddOptions
          : allowAddOptions // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollModelImplCopyWith<$Res>
    implements $PollModelCopyWith<$Res> {
  factory _$$PollModelImplCopyWith(
          _$PollModelImpl value, $Res Function(_$PollModelImpl) then) =
      __$$PollModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? question,
      List<String>? options,
      @JsonKey(name: 'allow_multiple_choice') bool? allowMultipleChoices,
      @JsonKey(name: 'allow_add_options') bool? allowAddOptions});
}

/// @nodoc
class __$$PollModelImplCopyWithImpl<$Res>
    extends _$PollModelCopyWithImpl<$Res, _$PollModelImpl>
    implements _$$PollModelImplCopyWith<$Res> {
  __$$PollModelImplCopyWithImpl(
      _$PollModelImpl _value, $Res Function(_$PollModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PollModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = freezed,
    Object? options = freezed,
    Object? allowMultipleChoices = freezed,
    Object? allowAddOptions = freezed,
  }) {
    return _then(_$PollModelImpl(
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      allowMultipleChoices: freezed == allowMultipleChoices
          ? _value.allowMultipleChoices
          : allowMultipleChoices // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowAddOptions: freezed == allowAddOptions
          ? _value.allowAddOptions
          : allowAddOptions // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollModelImpl implements _PollModel {
  const _$PollModelImpl(
      {this.question,
      final List<String>? options,
      @JsonKey(name: 'allow_multiple_choice') this.allowMultipleChoices,
      @JsonKey(name: 'allow_add_options') this.allowAddOptions})
      : _options = options;

  factory _$PollModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollModelImplFromJson(json);

  @override
  final String? question;
  final List<String>? _options;
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'allow_multiple_choice')
  final bool? allowMultipleChoices;
  @override
  @JsonKey(name: 'allow_add_options')
  final bool? allowAddOptions;

  @override
  String toString() {
    return 'PollModel(question: $question, options: $options, allowMultipleChoices: $allowMultipleChoices, allowAddOptions: $allowAddOptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollModelImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.allowMultipleChoices, allowMultipleChoices) ||
                other.allowMultipleChoices == allowMultipleChoices) &&
            (identical(other.allowAddOptions, allowAddOptions) ||
                other.allowAddOptions == allowAddOptions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      question,
      const DeepCollectionEquality().hash(_options),
      allowMultipleChoices,
      allowAddOptions);

  /// Create a copy of PollModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollModelImplCopyWith<_$PollModelImpl> get copyWith =>
      __$$PollModelImplCopyWithImpl<_$PollModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollModelImplToJson(
      this,
    );
  }
}

abstract class _PollModel implements PollModel {
  const factory _PollModel(
      {final String? question,
      final List<String>? options,
      @JsonKey(name: 'allow_multiple_choice') final bool? allowMultipleChoices,
      @JsonKey(name: 'allow_add_options')
      final bool? allowAddOptions}) = _$PollModelImpl;

  factory _PollModel.fromJson(Map<String, dynamic> json) =
      _$PollModelImpl.fromJson;

  @override
  String? get question;
  @override
  List<String>? get options;
  @override
  @JsonKey(name: 'allow_multiple_choice')
  bool? get allowMultipleChoices;
  @override
  @JsonKey(name: 'allow_add_options')
  bool? get allowAddOptions;

  /// Create a copy of PollModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollModelImplCopyWith<_$PollModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
