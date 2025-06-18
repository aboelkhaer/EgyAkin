// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_recommendation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PatientRecommendationModel _$PatientRecommendationModelFromJson(
    Map<String, dynamic> json) {
  return _PatientRecommendationModel.fromJson(json);
}

/// @nodoc
mixin _$PatientRecommendationModel {
  String get id => throw _privateConstructorUsedError;
  String get doseName => throw _privateConstructorUsedError;
  String get dose => throw _privateConstructorUsedError;
  String get route => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;

  /// Serializes this PatientRecommendationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatientRecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientRecommendationModelCopyWith<PatientRecommendationModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientRecommendationModelCopyWith<$Res> {
  factory $PatientRecommendationModelCopyWith(PatientRecommendationModel value,
          $Res Function(PatientRecommendationModel) then) =
      _$PatientRecommendationModelCopyWithImpl<$Res,
          PatientRecommendationModel>;
  @useResult
  $Res call(
      {String id,
      String doseName,
      String dose,
      String route,
      String frequency,
      String duration});
}

/// @nodoc
class _$PatientRecommendationModelCopyWithImpl<$Res,
        $Val extends PatientRecommendationModel>
    implements $PatientRecommendationModelCopyWith<$Res> {
  _$PatientRecommendationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientRecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doseName = null,
    Object? dose = null,
    Object? route = null,
    Object? frequency = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      doseName: null == doseName
          ? _value.doseName
          : doseName // ignore: cast_nullable_to_non_nullable
              as String,
      dose: null == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientRecommendationModelImplCopyWith<$Res>
    implements $PatientRecommendationModelCopyWith<$Res> {
  factory _$$PatientRecommendationModelImplCopyWith(
          _$PatientRecommendationModelImpl value,
          $Res Function(_$PatientRecommendationModelImpl) then) =
      __$$PatientRecommendationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String doseName,
      String dose,
      String route,
      String frequency,
      String duration});
}

/// @nodoc
class __$$PatientRecommendationModelImplCopyWithImpl<$Res>
    extends _$PatientRecommendationModelCopyWithImpl<$Res,
        _$PatientRecommendationModelImpl>
    implements _$$PatientRecommendationModelImplCopyWith<$Res> {
  __$$PatientRecommendationModelImplCopyWithImpl(
      _$PatientRecommendationModelImpl _value,
      $Res Function(_$PatientRecommendationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientRecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doseName = null,
    Object? dose = null,
    Object? route = null,
    Object? frequency = null,
    Object? duration = null,
  }) {
    return _then(_$PatientRecommendationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      doseName: null == doseName
          ? _value.doseName
          : doseName // ignore: cast_nullable_to_non_nullable
              as String,
      dose: null == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientRecommendationModelImpl implements _PatientRecommendationModel {
  const _$PatientRecommendationModelImpl(
      {required this.id,
      required this.doseName,
      required this.dose,
      required this.route,
      required this.frequency,
      required this.duration});

  factory _$PatientRecommendationModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PatientRecommendationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String doseName;
  @override
  final String dose;
  @override
  final String route;
  @override
  final String frequency;
  @override
  final String duration;

  @override
  String toString() {
    return 'PatientRecommendationModel(id: $id, doseName: $doseName, dose: $dose, route: $route, frequency: $frequency, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientRecommendationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doseName, doseName) ||
                other.doseName == doseName) &&
            (identical(other.dose, dose) || other.dose == dose) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, doseName, dose, route, frequency, duration);

  /// Create a copy of PatientRecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientRecommendationModelImplCopyWith<_$PatientRecommendationModelImpl>
      get copyWith => __$$PatientRecommendationModelImplCopyWithImpl<
          _$PatientRecommendationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientRecommendationModelImplToJson(
      this,
    );
  }
}

abstract class _PatientRecommendationModel
    implements PatientRecommendationModel {
  const factory _PatientRecommendationModel(
      {required final String id,
      required final String doseName,
      required final String dose,
      required final String route,
      required final String frequency,
      required final String duration}) = _$PatientRecommendationModelImpl;

  factory _PatientRecommendationModel.fromJson(Map<String, dynamic> json) =
      _$PatientRecommendationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get doseName;
  @override
  String get dose;
  @override
  String get route;
  @override
  String get frequency;
  @override
  String get duration;

  /// Create a copy of PatientRecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientRecommendationModelImplCopyWith<_$PatientRecommendationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
