// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_form_upload_analysis_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AiFormUploadAnalysisModelResponse _$AiFormUploadAnalysisModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AiFormUploadAnalysisModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AiFormUploadAnalysisModelResponse {
  @JsonKey(name: 'extracted_text')
  String? get extractedText => throw _privateConstructorUsedError;
  List<QuestionModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this AiFormUploadAnalysisModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiFormUploadAnalysisModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiFormUploadAnalysisModelResponseCopyWith<AiFormUploadAnalysisModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiFormUploadAnalysisModelResponseCopyWith<$Res> {
  factory $AiFormUploadAnalysisModelResponseCopyWith(
          AiFormUploadAnalysisModelResponse value,
          $Res Function(AiFormUploadAnalysisModelResponse) then) =
      _$AiFormUploadAnalysisModelResponseCopyWithImpl<$Res,
          AiFormUploadAnalysisModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'extracted_text') String? extractedText,
      List<QuestionModel>? data});
}

/// @nodoc
class _$AiFormUploadAnalysisModelResponseCopyWithImpl<$Res,
        $Val extends AiFormUploadAnalysisModelResponse>
    implements $AiFormUploadAnalysisModelResponseCopyWith<$Res> {
  _$AiFormUploadAnalysisModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiFormUploadAnalysisModelResponse
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
abstract class _$$AiFormUploadAnalysisModelResponseImplCopyWith<$Res>
    implements $AiFormUploadAnalysisModelResponseCopyWith<$Res> {
  factory _$$AiFormUploadAnalysisModelResponseImplCopyWith(
          _$AiFormUploadAnalysisModelResponseImpl value,
          $Res Function(_$AiFormUploadAnalysisModelResponseImpl) then) =
      __$$AiFormUploadAnalysisModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'extracted_text') String? extractedText,
      List<QuestionModel>? data});
}

/// @nodoc
class __$$AiFormUploadAnalysisModelResponseImplCopyWithImpl<$Res>
    extends _$AiFormUploadAnalysisModelResponseCopyWithImpl<$Res,
        _$AiFormUploadAnalysisModelResponseImpl>
    implements _$$AiFormUploadAnalysisModelResponseImplCopyWith<$Res> {
  __$$AiFormUploadAnalysisModelResponseImplCopyWithImpl(
      _$AiFormUploadAnalysisModelResponseImpl _value,
      $Res Function(_$AiFormUploadAnalysisModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiFormUploadAnalysisModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extractedText = freezed,
    Object? data = freezed,
  }) {
    return _then(_$AiFormUploadAnalysisModelResponseImpl(
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
class _$AiFormUploadAnalysisModelResponseImpl
    implements _AiFormUploadAnalysisModelResponse {
  const _$AiFormUploadAnalysisModelResponseImpl(
      {@JsonKey(name: 'extracted_text') this.extractedText,
      final List<QuestionModel>? data})
      : _data = data;

  factory _$AiFormUploadAnalysisModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AiFormUploadAnalysisModelResponseImplFromJson(json);

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
    return 'AiFormUploadAnalysisModelResponse(extractedText: $extractedText, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiFormUploadAnalysisModelResponseImpl &&
            (identical(other.extractedText, extractedText) ||
                other.extractedText == extractedText) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, extractedText, const DeepCollectionEquality().hash(_data));

  /// Create a copy of AiFormUploadAnalysisModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiFormUploadAnalysisModelResponseImplCopyWith<
          _$AiFormUploadAnalysisModelResponseImpl>
      get copyWith => __$$AiFormUploadAnalysisModelResponseImplCopyWithImpl<
          _$AiFormUploadAnalysisModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiFormUploadAnalysisModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AiFormUploadAnalysisModelResponse
    implements AiFormUploadAnalysisModelResponse {
  const factory _AiFormUploadAnalysisModelResponse(
          {@JsonKey(name: 'extracted_text') final String? extractedText,
          final List<QuestionModel>? data}) =
      _$AiFormUploadAnalysisModelResponseImpl;

  factory _AiFormUploadAnalysisModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$AiFormUploadAnalysisModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'extracted_text')
  String? get extractedText;
  @override
  List<QuestionModel>? get data;

  /// Create a copy of AiFormUploadAnalysisModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiFormUploadAnalysisModelResponseImplCopyWith<
          _$AiFormUploadAnalysisModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
