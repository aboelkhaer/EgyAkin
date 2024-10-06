// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_filters_options_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetFiltersOptionsModelResponse _$GetFiltersOptionsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetFiltersOptionsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetFiltersOptionsModelResponse {
  List<GetFiltersOptionsDataModelResponse>? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetFiltersOptionsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetFiltersOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetFiltersOptionsModelResponseCopyWith<GetFiltersOptionsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetFiltersOptionsModelResponseCopyWith<$Res> {
  factory $GetFiltersOptionsModelResponseCopyWith(
          GetFiltersOptionsModelResponse value,
          $Res Function(GetFiltersOptionsModelResponse) then) =
      _$GetFiltersOptionsModelResponseCopyWithImpl<$Res,
          GetFiltersOptionsModelResponse>;
  @useResult
  $Res call({List<GetFiltersOptionsDataModelResponse>? data});
}

/// @nodoc
class _$GetFiltersOptionsModelResponseCopyWithImpl<$Res,
        $Val extends GetFiltersOptionsModelResponse>
    implements $GetFiltersOptionsModelResponseCopyWith<$Res> {
  _$GetFiltersOptionsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetFiltersOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<GetFiltersOptionsDataModelResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetFiltersOptionsModelResponseImplCopyWith<$Res>
    implements $GetFiltersOptionsModelResponseCopyWith<$Res> {
  factory _$$GetFiltersOptionsModelResponseImplCopyWith(
          _$GetFiltersOptionsModelResponseImpl value,
          $Res Function(_$GetFiltersOptionsModelResponseImpl) then) =
      __$$GetFiltersOptionsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GetFiltersOptionsDataModelResponse>? data});
}

/// @nodoc
class __$$GetFiltersOptionsModelResponseImplCopyWithImpl<$Res>
    extends _$GetFiltersOptionsModelResponseCopyWithImpl<$Res,
        _$GetFiltersOptionsModelResponseImpl>
    implements _$$GetFiltersOptionsModelResponseImplCopyWith<$Res> {
  __$$GetFiltersOptionsModelResponseImplCopyWithImpl(
      _$GetFiltersOptionsModelResponseImpl _value,
      $Res Function(_$GetFiltersOptionsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetFiltersOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetFiltersOptionsModelResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<GetFiltersOptionsDataModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetFiltersOptionsModelResponseImpl
    implements _GetFiltersOptionsModelResponse {
  const _$GetFiltersOptionsModelResponseImpl(
      {final List<GetFiltersOptionsDataModelResponse>? data})
      : _data = data;

  factory _$GetFiltersOptionsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetFiltersOptionsModelResponseImplFromJson(json);

  final List<GetFiltersOptionsDataModelResponse>? _data;
  @override
  List<GetFiltersOptionsDataModelResponse>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetFiltersOptionsModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFiltersOptionsModelResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of GetFiltersOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFiltersOptionsModelResponseImplCopyWith<
          _$GetFiltersOptionsModelResponseImpl>
      get copyWith => __$$GetFiltersOptionsModelResponseImplCopyWithImpl<
          _$GetFiltersOptionsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetFiltersOptionsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetFiltersOptionsModelResponse
    implements GetFiltersOptionsModelResponse {
  const factory _GetFiltersOptionsModelResponse(
          {final List<GetFiltersOptionsDataModelResponse>? data}) =
      _$GetFiltersOptionsModelResponseImpl;

  factory _GetFiltersOptionsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetFiltersOptionsModelResponseImpl.fromJson;

  @override
  List<GetFiltersOptionsDataModelResponse>? get data;

  /// Create a copy of GetFiltersOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetFiltersOptionsModelResponseImplCopyWith<
          _$GetFiltersOptionsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetFiltersOptionsDataModelResponse _$GetFiltersOptionsDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetFiltersOptionsDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetFiltersOptionsDataModelResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get condition => throw _privateConstructorUsedError;
  List<dynamic>? get values => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'keyboard_type')
  String? get keyboardType => throw _privateConstructorUsedError;

  /// Serializes this GetFiltersOptionsDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetFiltersOptionsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetFiltersOptionsDataModelResponseCopyWith<
          GetFiltersOptionsDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetFiltersOptionsDataModelResponseCopyWith<$Res> {
  factory $GetFiltersOptionsDataModelResponseCopyWith(
          GetFiltersOptionsDataModelResponse value,
          $Res Function(GetFiltersOptionsDataModelResponse) then) =
      _$GetFiltersOptionsDataModelResponseCopyWithImpl<$Res,
          GetFiltersOptionsDataModelResponse>;
  @useResult
  $Res call(
      {int? id,
      String? condition,
      List<dynamic>? values,
      String? type,
      @JsonKey(name: 'keyboard_type') String? keyboardType});
}

/// @nodoc
class _$GetFiltersOptionsDataModelResponseCopyWithImpl<$Res,
        $Val extends GetFiltersOptionsDataModelResponse>
    implements $GetFiltersOptionsDataModelResponseCopyWith<$Res> {
  _$GetFiltersOptionsDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetFiltersOptionsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? condition = freezed,
    Object? values = freezed,
    Object? type = freezed,
    Object? keyboardType = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      values: freezed == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetFiltersOptionsDataModelResponseImplCopyWith<$Res>
    implements $GetFiltersOptionsDataModelResponseCopyWith<$Res> {
  factory _$$GetFiltersOptionsDataModelResponseImplCopyWith(
          _$GetFiltersOptionsDataModelResponseImpl value,
          $Res Function(_$GetFiltersOptionsDataModelResponseImpl) then) =
      __$$GetFiltersOptionsDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? condition,
      List<dynamic>? values,
      String? type,
      @JsonKey(name: 'keyboard_type') String? keyboardType});
}

/// @nodoc
class __$$GetFiltersOptionsDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetFiltersOptionsDataModelResponseCopyWithImpl<$Res,
        _$GetFiltersOptionsDataModelResponseImpl>
    implements _$$GetFiltersOptionsDataModelResponseImplCopyWith<$Res> {
  __$$GetFiltersOptionsDataModelResponseImplCopyWithImpl(
      _$GetFiltersOptionsDataModelResponseImpl _value,
      $Res Function(_$GetFiltersOptionsDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetFiltersOptionsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? condition = freezed,
    Object? values = freezed,
    Object? type = freezed,
    Object? keyboardType = freezed,
  }) {
    return _then(_$GetFiltersOptionsDataModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      values: freezed == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetFiltersOptionsDataModelResponseImpl
    implements _GetFiltersOptionsDataModelResponse {
  const _$GetFiltersOptionsDataModelResponseImpl(
      {this.id,
      this.condition,
      final List<dynamic>? values,
      this.type,
      @JsonKey(name: 'keyboard_type') this.keyboardType})
      : _values = values;

  factory _$GetFiltersOptionsDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetFiltersOptionsDataModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  final String? condition;
  final List<dynamic>? _values;
  @override
  List<dynamic>? get values {
    final value = _values;
    if (value == null) return null;
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? type;
  @override
  @JsonKey(name: 'keyboard_type')
  final String? keyboardType;

  @override
  String toString() {
    return 'GetFiltersOptionsDataModelResponse(id: $id, condition: $condition, values: $values, type: $type, keyboardType: $keyboardType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFiltersOptionsDataModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.keyboardType, keyboardType) ||
                other.keyboardType == keyboardType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, condition,
      const DeepCollectionEquality().hash(_values), type, keyboardType);

  /// Create a copy of GetFiltersOptionsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFiltersOptionsDataModelResponseImplCopyWith<
          _$GetFiltersOptionsDataModelResponseImpl>
      get copyWith => __$$GetFiltersOptionsDataModelResponseImplCopyWithImpl<
          _$GetFiltersOptionsDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetFiltersOptionsDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetFiltersOptionsDataModelResponse
    implements GetFiltersOptionsDataModelResponse {
  const factory _GetFiltersOptionsDataModelResponse(
          {final int? id,
          final String? condition,
          final List<dynamic>? values,
          final String? type,
          @JsonKey(name: 'keyboard_type') final String? keyboardType}) =
      _$GetFiltersOptionsDataModelResponseImpl;

  factory _GetFiltersOptionsDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetFiltersOptionsDataModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  String? get condition;
  @override
  List<dynamic>? get values;
  @override
  String? get type;
  @override
  @JsonKey(name: 'keyboard_type')
  String? get keyboardType;

  /// Create a copy of GetFiltersOptionsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetFiltersOptionsDataModelResponseImplCopyWith<
          _$GetFiltersOptionsDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
