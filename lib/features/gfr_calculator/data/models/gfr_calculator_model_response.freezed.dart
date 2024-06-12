// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gfr_calculator_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GFRCalculatorModelResponse _$GFRCalculatorModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GFRCalculatorModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GFRCalculatorModelResponse {
  String? get age => throw _privateConstructorUsedError;
  String? get creatinine => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get equationType => throw _privateConstructorUsedError;
  String? get weight => throw _privateConstructorUsedError;
  String? get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GFRCalculatorModelResponseCopyWith<GFRCalculatorModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GFRCalculatorModelResponseCopyWith<$Res> {
  factory $GFRCalculatorModelResponseCopyWith(GFRCalculatorModelResponse value,
          $Res Function(GFRCalculatorModelResponse) then) =
      _$GFRCalculatorModelResponseCopyWithImpl<$Res,
          GFRCalculatorModelResponse>;
  @useResult
  $Res call(
      {String? age,
      String? creatinine,
      String? gender,
      String? equationType,
      String? weight,
      String? height});
}

/// @nodoc
class _$GFRCalculatorModelResponseCopyWithImpl<$Res,
        $Val extends GFRCalculatorModelResponse>
    implements $GFRCalculatorModelResponseCopyWith<$Res> {
  _$GFRCalculatorModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? creatinine = freezed,
    Object? gender = freezed,
    Object? equationType = freezed,
    Object? weight = freezed,
    Object? height = freezed,
  }) {
    return _then(_value.copyWith(
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      creatinine: freezed == creatinine
          ? _value.creatinine
          : creatinine // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      equationType: freezed == equationType
          ? _value.equationType
          : equationType // ignore: cast_nullable_to_non_nullable
              as String?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GFRCalculatorModelResponseImplCopyWith<$Res>
    implements $GFRCalculatorModelResponseCopyWith<$Res> {
  factory _$$GFRCalculatorModelResponseImplCopyWith(
          _$GFRCalculatorModelResponseImpl value,
          $Res Function(_$GFRCalculatorModelResponseImpl) then) =
      __$$GFRCalculatorModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? age,
      String? creatinine,
      String? gender,
      String? equationType,
      String? weight,
      String? height});
}

/// @nodoc
class __$$GFRCalculatorModelResponseImplCopyWithImpl<$Res>
    extends _$GFRCalculatorModelResponseCopyWithImpl<$Res,
        _$GFRCalculatorModelResponseImpl>
    implements _$$GFRCalculatorModelResponseImplCopyWith<$Res> {
  __$$GFRCalculatorModelResponseImplCopyWithImpl(
      _$GFRCalculatorModelResponseImpl _value,
      $Res Function(_$GFRCalculatorModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? creatinine = freezed,
    Object? gender = freezed,
    Object? equationType = freezed,
    Object? weight = freezed,
    Object? height = freezed,
  }) {
    return _then(_$GFRCalculatorModelResponseImpl(
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      creatinine: freezed == creatinine
          ? _value.creatinine
          : creatinine // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      equationType: freezed == equationType
          ? _value.equationType
          : equationType // ignore: cast_nullable_to_non_nullable
              as String?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GFRCalculatorModelResponseImpl implements _GFRCalculatorModelResponse {
  const _$GFRCalculatorModelResponseImpl(
      {this.age,
      this.creatinine,
      this.gender,
      this.equationType,
      this.weight,
      this.height});

  factory _$GFRCalculatorModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GFRCalculatorModelResponseImplFromJson(json);

  @override
  final String? age;
  @override
  final String? creatinine;
  @override
  final String? gender;
  @override
  final String? equationType;
  @override
  final String? weight;
  @override
  final String? height;

  @override
  String toString() {
    return 'GFRCalculatorModelResponse(age: $age, creatinine: $creatinine, gender: $gender, equationType: $equationType, weight: $weight, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GFRCalculatorModelResponseImpl &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.creatinine, creatinine) ||
                other.creatinine == creatinine) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.equationType, equationType) ||
                other.equationType == equationType) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, age, creatinine, gender, equationType, weight, height);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GFRCalculatorModelResponseImplCopyWith<_$GFRCalculatorModelResponseImpl>
      get copyWith => __$$GFRCalculatorModelResponseImplCopyWithImpl<
          _$GFRCalculatorModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GFRCalculatorModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GFRCalculatorModelResponse
    implements GFRCalculatorModelResponse {
  const factory _GFRCalculatorModelResponse(
      {final String? age,
      final String? creatinine,
      final String? gender,
      final String? equationType,
      final String? weight,
      final String? height}) = _$GFRCalculatorModelResponseImpl;

  factory _GFRCalculatorModelResponse.fromJson(Map<String, dynamic> json) =
      _$GFRCalculatorModelResponseImpl.fromJson;

  @override
  String? get age;
  @override
  String? get creatinine;
  @override
  String? get gender;
  @override
  String? get equationType;
  @override
  String? get weight;
  @override
  String? get height;
  @override
  @JsonKey(ignore: true)
  _$$GFRCalculatorModelResponseImplCopyWith<_$GFRCalculatorModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GFRCalculatorHistoryModelResponse _$GFRCalculatorHistoryModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GFRCalculatorHistoryModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GFRCalculatorHistoryModelResponse {
  String? get age => throw _privateConstructorUsedError;
  String? get creatinine => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get result => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get weight => throw _privateConstructorUsedError;
  String? get height => throw _privateConstructorUsedError;
  String? get equationType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GFRCalculatorHistoryModelResponseCopyWith<GFRCalculatorHistoryModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GFRCalculatorHistoryModelResponseCopyWith<$Res> {
  factory $GFRCalculatorHistoryModelResponseCopyWith(
          GFRCalculatorHistoryModelResponse value,
          $Res Function(GFRCalculatorHistoryModelResponse) then) =
      _$GFRCalculatorHistoryModelResponseCopyWithImpl<$Res,
          GFRCalculatorHistoryModelResponse>;
  @useResult
  $Res call(
      {String? age,
      String? creatinine,
      String? gender,
      String? result,
      String? date,
      String? weight,
      String? height,
      String? equationType});
}

/// @nodoc
class _$GFRCalculatorHistoryModelResponseCopyWithImpl<$Res,
        $Val extends GFRCalculatorHistoryModelResponse>
    implements $GFRCalculatorHistoryModelResponseCopyWith<$Res> {
  _$GFRCalculatorHistoryModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? creatinine = freezed,
    Object? gender = freezed,
    Object? result = freezed,
    Object? date = freezed,
    Object? weight = freezed,
    Object? height = freezed,
    Object? equationType = freezed,
  }) {
    return _then(_value.copyWith(
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      creatinine: freezed == creatinine
          ? _value.creatinine
          : creatinine // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String?,
      equationType: freezed == equationType
          ? _value.equationType
          : equationType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GFRCalculatorHistoryModelResponseImplCopyWith<$Res>
    implements $GFRCalculatorHistoryModelResponseCopyWith<$Res> {
  factory _$$GFRCalculatorHistoryModelResponseImplCopyWith(
          _$GFRCalculatorHistoryModelResponseImpl value,
          $Res Function(_$GFRCalculatorHistoryModelResponseImpl) then) =
      __$$GFRCalculatorHistoryModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? age,
      String? creatinine,
      String? gender,
      String? result,
      String? date,
      String? weight,
      String? height,
      String? equationType});
}

/// @nodoc
class __$$GFRCalculatorHistoryModelResponseImplCopyWithImpl<$Res>
    extends _$GFRCalculatorHistoryModelResponseCopyWithImpl<$Res,
        _$GFRCalculatorHistoryModelResponseImpl>
    implements _$$GFRCalculatorHistoryModelResponseImplCopyWith<$Res> {
  __$$GFRCalculatorHistoryModelResponseImplCopyWithImpl(
      _$GFRCalculatorHistoryModelResponseImpl _value,
      $Res Function(_$GFRCalculatorHistoryModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? creatinine = freezed,
    Object? gender = freezed,
    Object? result = freezed,
    Object? date = freezed,
    Object? weight = freezed,
    Object? height = freezed,
    Object? equationType = freezed,
  }) {
    return _then(_$GFRCalculatorHistoryModelResponseImpl(
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      creatinine: freezed == creatinine
          ? _value.creatinine
          : creatinine // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String?,
      equationType: freezed == equationType
          ? _value.equationType
          : equationType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GFRCalculatorHistoryModelResponseImpl
    implements _GFRCalculatorHistoryModelResponse {
  const _$GFRCalculatorHistoryModelResponseImpl(
      {this.age,
      this.creatinine,
      this.gender,
      this.result,
      this.date,
      this.weight,
      this.height,
      this.equationType});

  factory _$GFRCalculatorHistoryModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GFRCalculatorHistoryModelResponseImplFromJson(json);

  @override
  final String? age;
  @override
  final String? creatinine;
  @override
  final String? gender;
  @override
  final String? result;
  @override
  final String? date;
  @override
  final String? weight;
  @override
  final String? height;
  @override
  final String? equationType;

  @override
  String toString() {
    return 'GFRCalculatorHistoryModelResponse(age: $age, creatinine: $creatinine, gender: $gender, result: $result, date: $date, weight: $weight, height: $height, equationType: $equationType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GFRCalculatorHistoryModelResponseImpl &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.creatinine, creatinine) ||
                other.creatinine == creatinine) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.equationType, equationType) ||
                other.equationType == equationType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, age, creatinine, gender, result,
      date, weight, height, equationType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GFRCalculatorHistoryModelResponseImplCopyWith<
          _$GFRCalculatorHistoryModelResponseImpl>
      get copyWith => __$$GFRCalculatorHistoryModelResponseImplCopyWithImpl<
          _$GFRCalculatorHistoryModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GFRCalculatorHistoryModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GFRCalculatorHistoryModelResponse
    implements GFRCalculatorHistoryModelResponse {
  const factory _GFRCalculatorHistoryModelResponse(
      {final String? age,
      final String? creatinine,
      final String? gender,
      final String? result,
      final String? date,
      final String? weight,
      final String? height,
      final String? equationType}) = _$GFRCalculatorHistoryModelResponseImpl;

  factory _GFRCalculatorHistoryModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GFRCalculatorHistoryModelResponseImpl.fromJson;

  @override
  String? get age;
  @override
  String? get creatinine;
  @override
  String? get gender;
  @override
  String? get result;
  @override
  String? get date;
  @override
  String? get weight;
  @override
  String? get height;
  @override
  String? get equationType;
  @override
  @JsonKey(ignore: true)
  _$$GFRCalculatorHistoryModelResponseImplCopyWith<
          _$GFRCalculatorHistoryModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
