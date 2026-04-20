// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'process_section_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProcessSectionModelResponse _$ProcessSectionModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ProcessSectionModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ProcessSectionModelResponse {
  @JsonKey(name: 'extracted_text')
  String? get extractedText => throw _privateConstructorUsedError;
  List<QuestionModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this ProcessSectionModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProcessSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProcessSectionModelResponseCopyWith<ProcessSectionModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcessSectionModelResponseCopyWith<$Res> {
  factory $ProcessSectionModelResponseCopyWith(
          ProcessSectionModelResponse value,
          $Res Function(ProcessSectionModelResponse) then) =
      _$ProcessSectionModelResponseCopyWithImpl<$Res,
          ProcessSectionModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'extracted_text') String? extractedText,
      List<QuestionModel>? data});
}

/// @nodoc
class _$ProcessSectionModelResponseCopyWithImpl<$Res,
        $Val extends ProcessSectionModelResponse>
    implements $ProcessSectionModelResponseCopyWith<$Res> {
  _$ProcessSectionModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProcessSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extractedText = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      extractedText: freezed == extractedText
          ? _value.extractedText
          : extractedText // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProcessSectionModelResponseImplCopyWith<$Res>
    implements $ProcessSectionModelResponseCopyWith<$Res> {
  factory _$$ProcessSectionModelResponseImplCopyWith(
          _$ProcessSectionModelResponseImpl value,
          $Res Function(_$ProcessSectionModelResponseImpl) then) =
      __$$ProcessSectionModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'extracted_text') String? extractedText,
      List<QuestionModel>? data});
}

/// @nodoc
class __$$ProcessSectionModelResponseImplCopyWithImpl<$Res>
    extends _$ProcessSectionModelResponseCopyWithImpl<$Res,
        _$ProcessSectionModelResponseImpl>
    implements _$$ProcessSectionModelResponseImplCopyWith<$Res> {
  __$$ProcessSectionModelResponseImplCopyWithImpl(
      _$ProcessSectionModelResponseImpl _value,
      $Res Function(_$ProcessSectionModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProcessSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extractedText = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ProcessSectionModelResponseImpl(
      extractedText: freezed == extractedText
          ? _value.extractedText
          : extractedText // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcessSectionModelResponseImpl
    implements _ProcessSectionModelResponse {
  const _$ProcessSectionModelResponseImpl(
      {@JsonKey(name: 'extracted_text') this.extractedText,
      final List<QuestionModel>? data})
      : _data = data;

  factory _$ProcessSectionModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProcessSectionModelResponseImplFromJson(json);

  @override
  @JsonKey(name: 'extracted_text')
  final String? extractedText;
  final List<QuestionModel>? _data;
  @override
  List<QuestionModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProcessSectionModelResponse(extractedText: $extractedText, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessSectionModelResponseImpl &&
            (identical(other.extractedText, extractedText) ||
                other.extractedText == extractedText) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, extractedText, const DeepCollectionEquality().hash(_data));

  /// Create a copy of ProcessSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessSectionModelResponseImplCopyWith<_$ProcessSectionModelResponseImpl>
      get copyWith => __$$ProcessSectionModelResponseImplCopyWithImpl<
          _$ProcessSectionModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcessSectionModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ProcessSectionModelResponse
    implements ProcessSectionModelResponse {
  const factory _ProcessSectionModelResponse(
      {@JsonKey(name: 'extracted_text') final String? extractedText,
      final List<QuestionModel>? data}) = _$ProcessSectionModelResponseImpl;

  factory _ProcessSectionModelResponse.fromJson(Map<String, dynamic> json) =
      _$ProcessSectionModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'extracted_text')
  String? get extractedText;
  @override
  List<QuestionModel>? get data;

  /// Create a copy of ProcessSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessSectionModelResponseImplCopyWith<_$ProcessSectionModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
