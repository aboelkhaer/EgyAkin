// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_comments_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostCommentsModelResponse _$PostCommentsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _PostCommentsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$PostCommentsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  List<CommentModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this PostCommentsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCommentsModelResponseCopyWith<PostCommentsModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCommentsModelResponseCopyWith<$Res> {
  factory $PostCommentsModelResponseCopyWith(PostCommentsModelResponse value,
          $Res Function(PostCommentsModelResponse) then) =
      _$PostCommentsModelResponseCopyWithImpl<$Res, PostCommentsModelResponse>;
  @useResult
  $Res call({bool? value, List<CommentModel>? data});
}

/// @nodoc
class _$PostCommentsModelResponseCopyWithImpl<$Res,
        $Val extends PostCommentsModelResponse>
    implements $PostCommentsModelResponseCopyWith<$Res> {
  _$PostCommentsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostCommentsModelResponseImplCopyWith<$Res>
    implements $PostCommentsModelResponseCopyWith<$Res> {
  factory _$$PostCommentsModelResponseImplCopyWith(
          _$PostCommentsModelResponseImpl value,
          $Res Function(_$PostCommentsModelResponseImpl) then) =
      __$$PostCommentsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, List<CommentModel>? data});
}

/// @nodoc
class __$$PostCommentsModelResponseImplCopyWithImpl<$Res>
    extends _$PostCommentsModelResponseCopyWithImpl<$Res,
        _$PostCommentsModelResponseImpl>
    implements _$$PostCommentsModelResponseImplCopyWith<$Res> {
  __$$PostCommentsModelResponseImplCopyWithImpl(
      _$PostCommentsModelResponseImpl _value,
      $Res Function(_$PostCommentsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$PostCommentsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostCommentsModelResponseImpl implements _PostCommentsModelResponse {
  const _$PostCommentsModelResponseImpl(
      {this.value, final List<CommentModel>? data})
      : _data = data;

  factory _$PostCommentsModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCommentsModelResponseImplFromJson(json);

  @override
  final bool? value;
  final List<CommentModel>? _data;
  @override
  List<CommentModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PostCommentsModelResponse(value: $value, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCommentsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(_data));

  /// Create a copy of PostCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCommentsModelResponseImplCopyWith<_$PostCommentsModelResponseImpl>
      get copyWith => __$$PostCommentsModelResponseImplCopyWithImpl<
          _$PostCommentsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostCommentsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _PostCommentsModelResponse implements PostCommentsModelResponse {
  const factory _PostCommentsModelResponse(
      {final bool? value,
      final List<CommentModel>? data}) = _$PostCommentsModelResponseImpl;

  factory _PostCommentsModelResponse.fromJson(Map<String, dynamic> json) =
      _$PostCommentsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  List<CommentModel>? get data;

  /// Create a copy of PostCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostCommentsModelResponseImplCopyWith<_$PostCommentsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return _CommentModel.fromJson(json);
}

/// @nodoc
mixin _$CommentModel {
  int? get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  DoctorModel? get doctor => throw _privateConstructorUsedError;

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentModelCopyWith<CommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) then) =
      _$CommentModelCopyWithImpl<$Res, CommentModel>;
  @useResult
  $Res call(
      {int? id,
      String? content,
      @JsonKey(name: 'updated_at') String? updatedAt,
      DoctorModel? doctor});

  $DoctorModelCopyWith<$Res>? get doctor;
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res, $Val extends CommentModel>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? updatedAt = freezed,
    Object? doctor = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ) as $Val);
  }

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res>? get doctor {
    if (_value.doctor == null) {
      return null;
    }

    return $DoctorModelCopyWith<$Res>(_value.doctor!, (value) {
      return _then(_value.copyWith(doctor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentModelImplCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$$CommentModelImplCopyWith(
          _$CommentModelImpl value, $Res Function(_$CommentModelImpl) then) =
      __$$CommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? content,
      @JsonKey(name: 'updated_at') String? updatedAt,
      DoctorModel? doctor});

  @override
  $DoctorModelCopyWith<$Res>? get doctor;
}

/// @nodoc
class __$$CommentModelImplCopyWithImpl<$Res>
    extends _$CommentModelCopyWithImpl<$Res, _$CommentModelImpl>
    implements _$$CommentModelImplCopyWith<$Res> {
  __$$CommentModelImplCopyWithImpl(
      _$CommentModelImpl _value, $Res Function(_$CommentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? updatedAt = freezed,
    Object? doctor = freezed,
  }) {
    return _then(_$CommentModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentModelImpl implements _CommentModel {
  const _$CommentModelImpl(
      {this.id,
      this.content,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.doctor});

  factory _$CommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? content;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final DoctorModel? doctor;

  @override
  String toString() {
    return 'CommentModel(id: $id, content: $content, updatedAt: $updatedAt, doctor: $doctor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.doctor, doctor) || other.doctor == doctor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, updatedAt, doctor);

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      __$$CommentModelImplCopyWithImpl<_$CommentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentModelImplToJson(
      this,
    );
  }
}

abstract class _CommentModel implements CommentModel {
  const factory _CommentModel(
      {final int? id,
      final String? content,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final DoctorModel? doctor}) = _$CommentModelImpl;

  factory _CommentModel.fromJson(Map<String, dynamic> json) =
      _$CommentModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get content;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  DoctorModel? get doctor;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
