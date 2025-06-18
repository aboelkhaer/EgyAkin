// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_for_dose_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchForDoseInMedicationSectionModelResponse
    _$SearchForDoseInMedicationSectionModelResponseFromJson(
        Map<String, dynamic> json) {
  return _SearchForDoseInMedicationSectionModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SearchForDoseInMedicationSectionModelResponse {
  SearchForDoseInMedicationSectionDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this SearchForDoseInMedicationSectionModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchForDoseInMedicationSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchForDoseInMedicationSectionModelResponseCopyWith<
          SearchForDoseInMedicationSectionModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchForDoseInMedicationSectionModelResponseCopyWith<$Res> {
  factory $SearchForDoseInMedicationSectionModelResponseCopyWith(
          SearchForDoseInMedicationSectionModelResponse value,
          $Res Function(SearchForDoseInMedicationSectionModelResponse) then) =
      _$SearchForDoseInMedicationSectionModelResponseCopyWithImpl<$Res,
          SearchForDoseInMedicationSectionModelResponse>;
  @useResult
  $Res call({SearchForDoseInMedicationSectionDataModelResponse? data});

  $SearchForDoseInMedicationSectionDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$SearchForDoseInMedicationSectionModelResponseCopyWithImpl<$Res,
        $Val extends SearchForDoseInMedicationSectionModelResponse>
    implements $SearchForDoseInMedicationSectionModelResponseCopyWith<$Res> {
  _$SearchForDoseInMedicationSectionModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchForDoseInMedicationSectionModelResponse
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
              as SearchForDoseInMedicationSectionDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of SearchForDoseInMedicationSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SearchForDoseInMedicationSectionDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $SearchForDoseInMedicationSectionDataModelResponseCopyWith<$Res>(
        _value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SearchForDoseInMedicationSectionModelResponseImplCopyWith<
        $Res>
    implements $SearchForDoseInMedicationSectionModelResponseCopyWith<$Res> {
  factory _$$SearchForDoseInMedicationSectionModelResponseImplCopyWith(
          _$SearchForDoseInMedicationSectionModelResponseImpl value,
          $Res Function(_$SearchForDoseInMedicationSectionModelResponseImpl)
              then) =
      __$$SearchForDoseInMedicationSectionModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SearchForDoseInMedicationSectionDataModelResponse? data});

  @override
  $SearchForDoseInMedicationSectionDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$SearchForDoseInMedicationSectionModelResponseImplCopyWithImpl<$Res>
    extends _$SearchForDoseInMedicationSectionModelResponseCopyWithImpl<$Res,
        _$SearchForDoseInMedicationSectionModelResponseImpl>
    implements
        _$$SearchForDoseInMedicationSectionModelResponseImplCopyWith<$Res> {
  __$$SearchForDoseInMedicationSectionModelResponseImplCopyWithImpl(
      _$SearchForDoseInMedicationSectionModelResponseImpl _value,
      $Res Function(_$SearchForDoseInMedicationSectionModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchForDoseInMedicationSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SearchForDoseInMedicationSectionModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SearchForDoseInMedicationSectionDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchForDoseInMedicationSectionModelResponseImpl
    implements _SearchForDoseInMedicationSectionModelResponse {
  const _$SearchForDoseInMedicationSectionModelResponseImpl({this.data});

  factory _$SearchForDoseInMedicationSectionModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SearchForDoseInMedicationSectionModelResponseImplFromJson(json);

  @override
  final SearchForDoseInMedicationSectionDataModelResponse? data;

  @override
  String toString() {
    return 'SearchForDoseInMedicationSectionModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchForDoseInMedicationSectionModelResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of SearchForDoseInMedicationSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchForDoseInMedicationSectionModelResponseImplCopyWith<
          _$SearchForDoseInMedicationSectionModelResponseImpl>
      get copyWith =>
          __$$SearchForDoseInMedicationSectionModelResponseImplCopyWithImpl<
                  _$SearchForDoseInMedicationSectionModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchForDoseInMedicationSectionModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SearchForDoseInMedicationSectionModelResponse
    implements SearchForDoseInMedicationSectionModelResponse {
  const factory _SearchForDoseInMedicationSectionModelResponse(
          {final SearchForDoseInMedicationSectionDataModelResponse? data}) =
      _$SearchForDoseInMedicationSectionModelResponseImpl;

  factory _SearchForDoseInMedicationSectionModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$SearchForDoseInMedicationSectionModelResponseImpl.fromJson;

  @override
  SearchForDoseInMedicationSectionDataModelResponse? get data;

  /// Create a copy of SearchForDoseInMedicationSectionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchForDoseInMedicationSectionModelResponseImplCopyWith<
          _$SearchForDoseInMedicationSectionModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SearchForDoseInMedicationSectionDataModelResponse
    _$SearchForDoseInMedicationSectionDataModelResponseFromJson(
        Map<String, dynamic> json) {
  return _SearchForDoseInMedicationSectionDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SearchForDoseInMedicationSectionDataModelResponse {
  List<DoseModelInSearch>? get data => throw _privateConstructorUsedError;

  /// Serializes this SearchForDoseInMedicationSectionDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchForDoseInMedicationSectionDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchForDoseInMedicationSectionDataModelResponseCopyWith<
          SearchForDoseInMedicationSectionDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchForDoseInMedicationSectionDataModelResponseCopyWith<
    $Res> {
  factory $SearchForDoseInMedicationSectionDataModelResponseCopyWith(
          SearchForDoseInMedicationSectionDataModelResponse value,
          $Res Function(SearchForDoseInMedicationSectionDataModelResponse)
              then) =
      _$SearchForDoseInMedicationSectionDataModelResponseCopyWithImpl<$Res,
          SearchForDoseInMedicationSectionDataModelResponse>;
  @useResult
  $Res call({List<DoseModelInSearch>? data});
}

/// @nodoc
class _$SearchForDoseInMedicationSectionDataModelResponseCopyWithImpl<$Res,
        $Val extends SearchForDoseInMedicationSectionDataModelResponse>
    implements
        $SearchForDoseInMedicationSectionDataModelResponseCopyWith<$Res> {
  _$SearchForDoseInMedicationSectionDataModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchForDoseInMedicationSectionDataModelResponse
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
              as List<DoseModelInSearch>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWith<
        $Res>
    implements
        $SearchForDoseInMedicationSectionDataModelResponseCopyWith<$Res> {
  factory _$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWith(
          _$SearchForDoseInMedicationSectionDataModelResponseImpl value,
          $Res Function(_$SearchForDoseInMedicationSectionDataModelResponseImpl)
              then) =
      __$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWithImpl<
          $Res>;
  @override
  @useResult
  $Res call({List<DoseModelInSearch>? data});
}

/// @nodoc
class __$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWithImpl<
        $Res>
    extends _$SearchForDoseInMedicationSectionDataModelResponseCopyWithImpl<
        $Res, _$SearchForDoseInMedicationSectionDataModelResponseImpl>
    implements
        _$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWith<$Res> {
  __$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWithImpl(
      _$SearchForDoseInMedicationSectionDataModelResponseImpl _value,
      $Res Function(_$SearchForDoseInMedicationSectionDataModelResponseImpl)
          _then)
      : super(_value, _then);

  /// Create a copy of SearchForDoseInMedicationSectionDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SearchForDoseInMedicationSectionDataModelResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DoseModelInSearch>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchForDoseInMedicationSectionDataModelResponseImpl
    implements _SearchForDoseInMedicationSectionDataModelResponse {
  const _$SearchForDoseInMedicationSectionDataModelResponseImpl(
      {final List<DoseModelInSearch>? data})
      : _data = data;

  factory _$SearchForDoseInMedicationSectionDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SearchForDoseInMedicationSectionDataModelResponseImplFromJson(json);

  final List<DoseModelInSearch>? _data;
  @override
  List<DoseModelInSearch>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SearchForDoseInMedicationSectionDataModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchForDoseInMedicationSectionDataModelResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of SearchForDoseInMedicationSectionDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWith<
          _$SearchForDoseInMedicationSectionDataModelResponseImpl>
      get copyWith =>
          __$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWithImpl<
                  _$SearchForDoseInMedicationSectionDataModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchForDoseInMedicationSectionDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SearchForDoseInMedicationSectionDataModelResponse
    implements SearchForDoseInMedicationSectionDataModelResponse {
  const factory _SearchForDoseInMedicationSectionDataModelResponse(
          {final List<DoseModelInSearch>? data}) =
      _$SearchForDoseInMedicationSectionDataModelResponseImpl;

  factory _SearchForDoseInMedicationSectionDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$SearchForDoseInMedicationSectionDataModelResponseImpl.fromJson;

  @override
  List<DoseModelInSearch>? get data;

  /// Create a copy of SearchForDoseInMedicationSectionDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchForDoseInMedicationSectionDataModelResponseImplCopyWith<
          _$SearchForDoseInMedicationSectionDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DoseModelInSearch _$DoseModelInSearchFromJson(Map<String, dynamic> json) {
  return _DoseModelInSearch.fromJson(json);
}

/// @nodoc
mixin _$DoseModelInSearch {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get dose => throw _privateConstructorUsedError;

  /// Serializes this DoseModelInSearch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoseModelInSearch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoseModelInSearchCopyWith<DoseModelInSearch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoseModelInSearchCopyWith<$Res> {
  factory $DoseModelInSearchCopyWith(
          DoseModelInSearch value, $Res Function(DoseModelInSearch) then) =
      _$DoseModelInSearchCopyWithImpl<$Res, DoseModelInSearch>;
  @useResult
  $Res call({int? id, String? title, String? description, String? dose});
}

/// @nodoc
class _$DoseModelInSearchCopyWithImpl<$Res, $Val extends DoseModelInSearch>
    implements $DoseModelInSearchCopyWith<$Res> {
  _$DoseModelInSearchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoseModelInSearch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dose = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dose: freezed == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DoseModelInSearchImplCopyWith<$Res>
    implements $DoseModelInSearchCopyWith<$Res> {
  factory _$$DoseModelInSearchImplCopyWith(_$DoseModelInSearchImpl value,
          $Res Function(_$DoseModelInSearchImpl) then) =
      __$$DoseModelInSearchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? title, String? description, String? dose});
}

/// @nodoc
class __$$DoseModelInSearchImplCopyWithImpl<$Res>
    extends _$DoseModelInSearchCopyWithImpl<$Res, _$DoseModelInSearchImpl>
    implements _$$DoseModelInSearchImplCopyWith<$Res> {
  __$$DoseModelInSearchImplCopyWithImpl(_$DoseModelInSearchImpl _value,
      $Res Function(_$DoseModelInSearchImpl) _then)
      : super(_value, _then);

  /// Create a copy of DoseModelInSearch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dose = freezed,
  }) {
    return _then(_$DoseModelInSearchImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dose: freezed == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoseModelInSearchImpl implements _DoseModelInSearch {
  const _$DoseModelInSearchImpl(
      {this.id, this.title, this.description, this.dose});

  factory _$DoseModelInSearchImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoseModelInSearchImplFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? dose;

  @override
  String toString() {
    return 'DoseModelInSearch(id: $id, title: $title, description: $description, dose: $dose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoseModelInSearchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dose, dose) || other.dose == dose));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, dose);

  /// Create a copy of DoseModelInSearch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoseModelInSearchImplCopyWith<_$DoseModelInSearchImpl> get copyWith =>
      __$$DoseModelInSearchImplCopyWithImpl<_$DoseModelInSearchImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoseModelInSearchImplToJson(
      this,
    );
  }
}

abstract class _DoseModelInSearch implements DoseModelInSearch {
  const factory _DoseModelInSearch(
      {final int? id,
      final String? title,
      final String? description,
      final String? dose}) = _$DoseModelInSearchImpl;

  factory _DoseModelInSearch.fromJson(Map<String, dynamic> json) =
      _$DoseModelInSearchImpl.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get dose;

  /// Create a copy of DoseModelInSearch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoseModelInSearchImplCopyWith<_$DoseModelInSearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
