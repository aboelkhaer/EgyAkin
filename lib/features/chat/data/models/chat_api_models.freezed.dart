// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatEnvelopeModel _$ChatEnvelopeModelFromJson(Map<String, dynamic> json) {
  return _ChatEnvelopeModel.fromJson(json);
}

/// @nodoc
mixin _$ChatEnvelopeModel {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  /// Serializes this ChatEnvelopeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatEnvelopeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatEnvelopeModelCopyWith<ChatEnvelopeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEnvelopeModelCopyWith<$Res> {
  factory $ChatEnvelopeModelCopyWith(
          ChatEnvelopeModel value, $Res Function(ChatEnvelopeModel) then) =
      _$ChatEnvelopeModelCopyWithImpl<$Res, ChatEnvelopeModel>;
  @useResult
  $Res call({bool? value, String? message, dynamic data});
}

/// @nodoc
class _$ChatEnvelopeModelCopyWithImpl<$Res, $Val extends ChatEnvelopeModel>
    implements $ChatEnvelopeModelCopyWith<$Res> {
  _$ChatEnvelopeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatEnvelopeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatEnvelopeModelImplCopyWith<$Res>
    implements $ChatEnvelopeModelCopyWith<$Res> {
  factory _$$ChatEnvelopeModelImplCopyWith(_$ChatEnvelopeModelImpl value,
          $Res Function(_$ChatEnvelopeModelImpl) then) =
      __$$ChatEnvelopeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, dynamic data});
}

/// @nodoc
class __$$ChatEnvelopeModelImplCopyWithImpl<$Res>
    extends _$ChatEnvelopeModelCopyWithImpl<$Res, _$ChatEnvelopeModelImpl>
    implements _$$ChatEnvelopeModelImplCopyWith<$Res> {
  __$$ChatEnvelopeModelImplCopyWithImpl(_$ChatEnvelopeModelImpl _value,
      $Res Function(_$ChatEnvelopeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatEnvelopeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ChatEnvelopeModelImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatEnvelopeModelImpl implements _ChatEnvelopeModel {
  const _$ChatEnvelopeModelImpl({this.value, this.message, this.data});

  factory _$ChatEnvelopeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatEnvelopeModelImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'ChatEnvelopeModel(value: $value, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatEnvelopeModelImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, message, const DeepCollectionEquality().hash(data));

  /// Create a copy of ChatEnvelopeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatEnvelopeModelImplCopyWith<_$ChatEnvelopeModelImpl> get copyWith =>
      __$$ChatEnvelopeModelImplCopyWithImpl<_$ChatEnvelopeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatEnvelopeModelImplToJson(
      this,
    );
  }
}

abstract class _ChatEnvelopeModel implements ChatEnvelopeModel {
  const factory _ChatEnvelopeModel(
      {final bool? value,
      final String? message,
      final dynamic data}) = _$ChatEnvelopeModelImpl;

  factory _ChatEnvelopeModel.fromJson(Map<String, dynamic> json) =
      _$ChatEnvelopeModelImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  dynamic get data;

  /// Create a copy of ChatEnvelopeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatEnvelopeModelImplCopyWith<_$ChatEnvelopeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatUserModel _$ChatUserModelFromJson(Map<String, dynamic> json) {
  return _ChatUserModel.fromJson(json);
}

/// @nodoc
mixin _$ChatUserModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get lname => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get specialty => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;
  @JsonKey(name: 'isSyndicateCardRequired')
  String? get isSyndicateCardRequired => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  String? get joinedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'mute_notifications', fromJson: _flexibleBoolFromJson)
  bool? get muteNotifications => throw _privateConstructorUsedError;

  /// Serializes this ChatUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatUserModelCopyWith<ChatUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatUserModelCopyWith<$Res> {
  factory $ChatUserModelCopyWith(
          ChatUserModel value, $Res Function(ChatUserModel) then) =
      _$ChatUserModelCopyWithImpl<$Res, ChatUserModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? lname,
      String? image,
      String? specialty,
      String? workingplace,
      @JsonKey(name: 'isSyndicateCardRequired') String? isSyndicateCardRequired,
      String? role,
      @JsonKey(name: 'joined_at') String? joinedAt,
      @JsonKey(name: 'mute_notifications', fromJson: _flexibleBoolFromJson)
      bool? muteNotifications});
}

/// @nodoc
class _$ChatUserModelCopyWithImpl<$Res, $Val extends ChatUserModel>
    implements $ChatUserModelCopyWith<$Res> {
  _$ChatUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lname = freezed,
    Object? image = freezed,
    Object? specialty = freezed,
    Object? workingplace = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? role = freezed,
    Object? joinedAt = freezed,
    Object? muteNotifications = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lname: freezed == lname
          ? _value.lname
          : lname // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      muteNotifications: freezed == muteNotifications
          ? _value.muteNotifications
          : muteNotifications // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatUserModelImplCopyWith<$Res>
    implements $ChatUserModelCopyWith<$Res> {
  factory _$$ChatUserModelImplCopyWith(
          _$ChatUserModelImpl value, $Res Function(_$ChatUserModelImpl) then) =
      __$$ChatUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? lname,
      String? image,
      String? specialty,
      String? workingplace,
      @JsonKey(name: 'isSyndicateCardRequired') String? isSyndicateCardRequired,
      String? role,
      @JsonKey(name: 'joined_at') String? joinedAt,
      @JsonKey(name: 'mute_notifications', fromJson: _flexibleBoolFromJson)
      bool? muteNotifications});
}

/// @nodoc
class __$$ChatUserModelImplCopyWithImpl<$Res>
    extends _$ChatUserModelCopyWithImpl<$Res, _$ChatUserModelImpl>
    implements _$$ChatUserModelImplCopyWith<$Res> {
  __$$ChatUserModelImplCopyWithImpl(
      _$ChatUserModelImpl _value, $Res Function(_$ChatUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lname = freezed,
    Object? image = freezed,
    Object? specialty = freezed,
    Object? workingplace = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? role = freezed,
    Object? joinedAt = freezed,
    Object? muteNotifications = freezed,
  }) {
    return _then(_$ChatUserModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lname: freezed == lname
          ? _value.lname
          : lname // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      muteNotifications: freezed == muteNotifications
          ? _value.muteNotifications
          : muteNotifications // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatUserModelImpl implements _ChatUserModel {
  const _$ChatUserModelImpl(
      {this.id,
      this.name,
      this.lname,
      this.image,
      this.specialty,
      this.workingplace,
      @JsonKey(name: 'isSyndicateCardRequired') this.isSyndicateCardRequired,
      this.role,
      @JsonKey(name: 'joined_at') this.joinedAt,
      @JsonKey(name: 'mute_notifications', fromJson: _flexibleBoolFromJson)
      this.muteNotifications});

  factory _$ChatUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatUserModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? lname;
  @override
  final String? image;
  @override
  final String? specialty;
  @override
  final String? workingplace;
  @override
  @JsonKey(name: 'isSyndicateCardRequired')
  final String? isSyndicateCardRequired;
  @override
  final String? role;
  @override
  @JsonKey(name: 'joined_at')
  final String? joinedAt;
  @override
  @JsonKey(name: 'mute_notifications', fromJson: _flexibleBoolFromJson)
  final bool? muteNotifications;

  @override
  String toString() {
    return 'ChatUserModel(id: $id, name: $name, lname: $lname, image: $image, specialty: $specialty, workingplace: $workingplace, isSyndicateCardRequired: $isSyndicateCardRequired, role: $role, joinedAt: $joinedAt, muteNotifications: $muteNotifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lname, lname) || other.lname == lname) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace) &&
            (identical(
                    other.isSyndicateCardRequired, isSyndicateCardRequired) ||
                other.isSyndicateCardRequired == isSyndicateCardRequired) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.muteNotifications, muteNotifications) ||
                other.muteNotifications == muteNotifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      lname,
      image,
      specialty,
      workingplace,
      isSyndicateCardRequired,
      role,
      joinedAt,
      muteNotifications);

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatUserModelImplCopyWith<_$ChatUserModelImpl> get copyWith =>
      __$$ChatUserModelImplCopyWithImpl<_$ChatUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatUserModelImplToJson(
      this,
    );
  }
}

abstract class _ChatUserModel implements ChatUserModel {
  const factory _ChatUserModel(
      {final int? id,
      final String? name,
      final String? lname,
      final String? image,
      final String? specialty,
      final String? workingplace,
      @JsonKey(name: 'isSyndicateCardRequired')
      final String? isSyndicateCardRequired,
      final String? role,
      @JsonKey(name: 'joined_at') final String? joinedAt,
      @JsonKey(name: 'mute_notifications', fromJson: _flexibleBoolFromJson)
      final bool? muteNotifications}) = _$ChatUserModelImpl;

  factory _ChatUserModel.fromJson(Map<String, dynamic> json) =
      _$ChatUserModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get lname;
  @override
  String? get image;
  @override
  String? get specialty;
  @override
  String? get workingplace;
  @override
  @JsonKey(name: 'isSyndicateCardRequired')
  String? get isSyndicateCardRequired;
  @override
  String? get role;
  @override
  @JsonKey(name: 'joined_at')
  String? get joinedAt;
  @override
  @JsonKey(name: 'mute_notifications', fromJson: _flexibleBoolFromJson)
  bool? get muteNotifications;

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatUserModelImplCopyWith<_$ChatUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatAttachmentModel _$ChatAttachmentModelFromJson(Map<String, dynamic> json) {
  return _ChatAttachmentModel.fromJson(json);
}

/// @nodoc
mixin _$ChatAttachmentModel {
  int? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_name')
  String? get originalName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mime_type')
  String? get mimeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'size_bytes', fromJson: _flexibleIntFromJson)
  int? get sizeBytes => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_seconds', fromJson: _flexibleIntFromJson)
  int? get durationSeconds => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _attachmentUrlFromJson)
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this ChatAttachmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatAttachmentModelCopyWith<ChatAttachmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatAttachmentModelCopyWith<$Res> {
  factory $ChatAttachmentModelCopyWith(
          ChatAttachmentModel value, $Res Function(ChatAttachmentModel) then) =
      _$ChatAttachmentModelCopyWithImpl<$Res, ChatAttachmentModel>;
  @useResult
  $Res call(
      {int? id,
      String? type,
      @JsonKey(name: 'original_name') String? originalName,
      @JsonKey(name: 'mime_type') String? mimeType,
      @JsonKey(name: 'size_bytes', fromJson: _flexibleIntFromJson)
      int? sizeBytes,
      @JsonKey(name: 'duration_seconds', fromJson: _flexibleIntFromJson)
      int? durationSeconds,
      @JsonKey(fromJson: _attachmentUrlFromJson) String? url});
}

/// @nodoc
class _$ChatAttachmentModelCopyWithImpl<$Res, $Val extends ChatAttachmentModel>
    implements $ChatAttachmentModelCopyWith<$Res> {
  _$ChatAttachmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? originalName = freezed,
    Object? mimeType = freezed,
    Object? sizeBytes = freezed,
    Object? durationSeconds = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeBytes: freezed == sizeBytes
          ? _value.sizeBytes
          : sizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      durationSeconds: freezed == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatAttachmentModelImplCopyWith<$Res>
    implements $ChatAttachmentModelCopyWith<$Res> {
  factory _$$ChatAttachmentModelImplCopyWith(_$ChatAttachmentModelImpl value,
          $Res Function(_$ChatAttachmentModelImpl) then) =
      __$$ChatAttachmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? type,
      @JsonKey(name: 'original_name') String? originalName,
      @JsonKey(name: 'mime_type') String? mimeType,
      @JsonKey(name: 'size_bytes', fromJson: _flexibleIntFromJson)
      int? sizeBytes,
      @JsonKey(name: 'duration_seconds', fromJson: _flexibleIntFromJson)
      int? durationSeconds,
      @JsonKey(fromJson: _attachmentUrlFromJson) String? url});
}

/// @nodoc
class __$$ChatAttachmentModelImplCopyWithImpl<$Res>
    extends _$ChatAttachmentModelCopyWithImpl<$Res, _$ChatAttachmentModelImpl>
    implements _$$ChatAttachmentModelImplCopyWith<$Res> {
  __$$ChatAttachmentModelImplCopyWithImpl(_$ChatAttachmentModelImpl _value,
      $Res Function(_$ChatAttachmentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? originalName = freezed,
    Object? mimeType = freezed,
    Object? sizeBytes = freezed,
    Object? durationSeconds = freezed,
    Object? url = freezed,
  }) {
    return _then(_$ChatAttachmentModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeBytes: freezed == sizeBytes
          ? _value.sizeBytes
          : sizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      durationSeconds: freezed == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatAttachmentModelImpl implements _ChatAttachmentModel {
  const _$ChatAttachmentModelImpl(
      {this.id,
      this.type,
      @JsonKey(name: 'original_name') this.originalName,
      @JsonKey(name: 'mime_type') this.mimeType,
      @JsonKey(name: 'size_bytes', fromJson: _flexibleIntFromJson)
      this.sizeBytes,
      @JsonKey(name: 'duration_seconds', fromJson: _flexibleIntFromJson)
      this.durationSeconds,
      @JsonKey(fromJson: _attachmentUrlFromJson) this.url});

  factory _$ChatAttachmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatAttachmentModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? type;
  @override
  @JsonKey(name: 'original_name')
  final String? originalName;
  @override
  @JsonKey(name: 'mime_type')
  final String? mimeType;
  @override
  @JsonKey(name: 'size_bytes', fromJson: _flexibleIntFromJson)
  final int? sizeBytes;
  @override
  @JsonKey(name: 'duration_seconds', fromJson: _flexibleIntFromJson)
  final int? durationSeconds;
  @override
  @JsonKey(fromJson: _attachmentUrlFromJson)
  final String? url;

  @override
  String toString() {
    return 'ChatAttachmentModel(id: $id, type: $type, originalName: $originalName, mimeType: $mimeType, sizeBytes: $sizeBytes, durationSeconds: $durationSeconds, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatAttachmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, originalName, mimeType,
      sizeBytes, durationSeconds, url);

  /// Create a copy of ChatAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatAttachmentModelImplCopyWith<_$ChatAttachmentModelImpl> get copyWith =>
      __$$ChatAttachmentModelImplCopyWithImpl<_$ChatAttachmentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatAttachmentModelImplToJson(
      this,
    );
  }
}

abstract class _ChatAttachmentModel implements ChatAttachmentModel {
  const factory _ChatAttachmentModel(
          {final int? id,
          final String? type,
          @JsonKey(name: 'original_name') final String? originalName,
          @JsonKey(name: 'mime_type') final String? mimeType,
          @JsonKey(name: 'size_bytes', fromJson: _flexibleIntFromJson)
          final int? sizeBytes,
          @JsonKey(name: 'duration_seconds', fromJson: _flexibleIntFromJson)
          final int? durationSeconds,
          @JsonKey(fromJson: _attachmentUrlFromJson) final String? url}) =
      _$ChatAttachmentModelImpl;

  factory _ChatAttachmentModel.fromJson(Map<String, dynamic> json) =
      _$ChatAttachmentModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get type;
  @override
  @JsonKey(name: 'original_name')
  String? get originalName;
  @override
  @JsonKey(name: 'mime_type')
  String? get mimeType;
  @override
  @JsonKey(name: 'size_bytes', fromJson: _flexibleIntFromJson)
  int? get sizeBytes;
  @override
  @JsonKey(name: 'duration_seconds', fromJson: _flexibleIntFromJson)
  int? get durationSeconds;
  @override
  @JsonKey(fromJson: _attachmentUrlFromJson)
  String? get url;

  /// Create a copy of ChatAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatAttachmentModelImplCopyWith<_$ChatAttachmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatReactionModel _$ChatReactionModelFromJson(Map<String, dynamic> json) {
  return _ChatReactionModel.fromJson(json);
}

/// @nodoc
mixin _$ChatReactionModel {
  String? get emoji => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get count => throw _privateConstructorUsedError;
  List<ChatUserModel>? get users => throw _privateConstructorUsedError;

  /// Serializes this ChatReactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatReactionModelCopyWith<ChatReactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatReactionModelCopyWith<$Res> {
  factory $ChatReactionModelCopyWith(
          ChatReactionModel value, $Res Function(ChatReactionModel) then) =
      _$ChatReactionModelCopyWithImpl<$Res, ChatReactionModel>;
  @useResult
  $Res call(
      {String? emoji,
      @JsonKey(fromJson: _flexibleIntFromJson) int? count,
      List<ChatUserModel>? users});
}

/// @nodoc
class _$ChatReactionModelCopyWithImpl<$Res, $Val extends ChatReactionModel>
    implements $ChatReactionModelCopyWith<$Res> {
  _$ChatReactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = freezed,
    Object? count = freezed,
    Object? users = freezed,
  }) {
    return _then(_value.copyWith(
      emoji: freezed == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<ChatUserModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatReactionModelImplCopyWith<$Res>
    implements $ChatReactionModelCopyWith<$Res> {
  factory _$$ChatReactionModelImplCopyWith(_$ChatReactionModelImpl value,
          $Res Function(_$ChatReactionModelImpl) then) =
      __$$ChatReactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? emoji,
      @JsonKey(fromJson: _flexibleIntFromJson) int? count,
      List<ChatUserModel>? users});
}

/// @nodoc
class __$$ChatReactionModelImplCopyWithImpl<$Res>
    extends _$ChatReactionModelCopyWithImpl<$Res, _$ChatReactionModelImpl>
    implements _$$ChatReactionModelImplCopyWith<$Res> {
  __$$ChatReactionModelImplCopyWithImpl(_$ChatReactionModelImpl _value,
      $Res Function(_$ChatReactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = freezed,
    Object? count = freezed,
    Object? users = freezed,
  }) {
    return _then(_$ChatReactionModelImpl(
      emoji: freezed == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<ChatUserModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatReactionModelImpl implements _ChatReactionModel {
  const _$ChatReactionModelImpl(
      {this.emoji,
      @JsonKey(fromJson: _flexibleIntFromJson) this.count,
      final List<ChatUserModel>? users})
      : _users = users;

  factory _$ChatReactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatReactionModelImplFromJson(json);

  @override
  final String? emoji;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? count;
  final List<ChatUserModel>? _users;
  @override
  List<ChatUserModel>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChatReactionModel(emoji: $emoji, count: $count, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatReactionModelImpl &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, emoji, count, const DeepCollectionEquality().hash(_users));

  /// Create a copy of ChatReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatReactionModelImplCopyWith<_$ChatReactionModelImpl> get copyWith =>
      __$$ChatReactionModelImplCopyWithImpl<_$ChatReactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatReactionModelImplToJson(
      this,
    );
  }
}

abstract class _ChatReactionModel implements ChatReactionModel {
  const factory _ChatReactionModel(
      {final String? emoji,
      @JsonKey(fromJson: _flexibleIntFromJson) final int? count,
      final List<ChatUserModel>? users}) = _$ChatReactionModelImpl;

  factory _ChatReactionModel.fromJson(Map<String, dynamic> json) =
      _$ChatReactionModelImpl.fromJson;

  @override
  String? get emoji;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get count;
  @override
  List<ChatUserModel>? get users;

  /// Create a copy of ChatReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatReactionModelImplCopyWith<_$ChatReactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatReplyToModel _$ChatReplyToModelFromJson(Map<String, dynamic> json) {
  return _ChatReplyToModel.fromJson(json);
}

/// @nodoc
mixin _$ChatReplyToModel {
  int? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson)
  int? get senderId => throw _privateConstructorUsedError;
  ChatUserModel? get sender => throw _privateConstructorUsedError;

  /// Serializes this ChatReplyToModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatReplyToModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatReplyToModelCopyWith<ChatReplyToModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatReplyToModelCopyWith<$Res> {
  factory $ChatReplyToModelCopyWith(
          ChatReplyToModel value, $Res Function(ChatReplyToModel) then) =
      _$ChatReplyToModelCopyWithImpl<$Res, ChatReplyToModel>;
  @useResult
  $Res call(
      {int? id,
      String? type,
      String? content,
      @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson) int? senderId,
      ChatUserModel? sender});

  $ChatUserModelCopyWith<$Res>? get sender;
}

/// @nodoc
class _$ChatReplyToModelCopyWithImpl<$Res, $Val extends ChatReplyToModel>
    implements $ChatReplyToModelCopyWith<$Res> {
  _$ChatReplyToModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatReplyToModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? content = freezed,
    Object? senderId = freezed,
    Object? sender = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
    ) as $Val);
  }

  /// Create a copy of ChatReplyToModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserModelCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $ChatUserModelCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatReplyToModelImplCopyWith<$Res>
    implements $ChatReplyToModelCopyWith<$Res> {
  factory _$$ChatReplyToModelImplCopyWith(_$ChatReplyToModelImpl value,
          $Res Function(_$ChatReplyToModelImpl) then) =
      __$$ChatReplyToModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? type,
      String? content,
      @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson) int? senderId,
      ChatUserModel? sender});

  @override
  $ChatUserModelCopyWith<$Res>? get sender;
}

/// @nodoc
class __$$ChatReplyToModelImplCopyWithImpl<$Res>
    extends _$ChatReplyToModelCopyWithImpl<$Res, _$ChatReplyToModelImpl>
    implements _$$ChatReplyToModelImplCopyWith<$Res> {
  __$$ChatReplyToModelImplCopyWithImpl(_$ChatReplyToModelImpl _value,
      $Res Function(_$ChatReplyToModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatReplyToModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? content = freezed,
    Object? senderId = freezed,
    Object? sender = freezed,
  }) {
    return _then(_$ChatReplyToModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatReplyToModelImpl implements _ChatReplyToModel {
  const _$ChatReplyToModelImpl(
      {this.id,
      this.type,
      this.content,
      @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson) this.senderId,
      this.sender});

  factory _$ChatReplyToModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatReplyToModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? type;
  @override
  final String? content;
  @override
  @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson)
  final int? senderId;
  @override
  final ChatUserModel? sender;

  @override
  String toString() {
    return 'ChatReplyToModel(id: $id, type: $type, content: $content, senderId: $senderId, sender: $sender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatReplyToModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.sender, sender) || other.sender == sender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, content, senderId, sender);

  /// Create a copy of ChatReplyToModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatReplyToModelImplCopyWith<_$ChatReplyToModelImpl> get copyWith =>
      __$$ChatReplyToModelImplCopyWithImpl<_$ChatReplyToModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatReplyToModelImplToJson(
      this,
    );
  }
}

abstract class _ChatReplyToModel implements ChatReplyToModel {
  const factory _ChatReplyToModel(
      {final int? id,
      final String? type,
      final String? content,
      @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson)
      final int? senderId,
      final ChatUserModel? sender}) = _$ChatReplyToModelImpl;

  factory _ChatReplyToModel.fromJson(Map<String, dynamic> json) =
      _$ChatReplyToModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get type;
  @override
  String? get content;
  @override
  @JsonKey(name: 'sender_id', fromJson: _flexibleIntFromJson)
  int? get senderId;
  @override
  ChatUserModel? get sender;

  /// Create a copy of ChatReplyToModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatReplyToModelImplCopyWith<_$ChatReplyToModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatDeliveryReceiptModel _$ChatDeliveryReceiptModelFromJson(
    Map<String, dynamic> json) {
  return _ChatDeliveryReceiptModel.fromJson(json);
}

/// @nodoc
mixin _$ChatDeliveryReceiptModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get lname => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get specialty => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;
  @JsonKey(name: 'isSyndicateCardRequired')
  String? get isSyndicateCardRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_at')
  String? get deliveredAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_at')
  String? get readAt => throw _privateConstructorUsedError;

  /// Serializes this ChatDeliveryReceiptModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatDeliveryReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatDeliveryReceiptModelCopyWith<ChatDeliveryReceiptModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDeliveryReceiptModelCopyWith<$Res> {
  factory $ChatDeliveryReceiptModelCopyWith(ChatDeliveryReceiptModel value,
          $Res Function(ChatDeliveryReceiptModel) then) =
      _$ChatDeliveryReceiptModelCopyWithImpl<$Res, ChatDeliveryReceiptModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? lname,
      String? image,
      String? specialty,
      String? workingplace,
      @JsonKey(name: 'isSyndicateCardRequired') String? isSyndicateCardRequired,
      @JsonKey(name: 'delivered_at') String? deliveredAt,
      @JsonKey(name: 'read_at') String? readAt});
}

/// @nodoc
class _$ChatDeliveryReceiptModelCopyWithImpl<$Res,
        $Val extends ChatDeliveryReceiptModel>
    implements $ChatDeliveryReceiptModelCopyWith<$Res> {
  _$ChatDeliveryReceiptModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatDeliveryReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lname = freezed,
    Object? image = freezed,
    Object? specialty = freezed,
    Object? workingplace = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lname: freezed == lname
          ? _value.lname
          : lname // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as String?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatDeliveryReceiptModelImplCopyWith<$Res>
    implements $ChatDeliveryReceiptModelCopyWith<$Res> {
  factory _$$ChatDeliveryReceiptModelImplCopyWith(
          _$ChatDeliveryReceiptModelImpl value,
          $Res Function(_$ChatDeliveryReceiptModelImpl) then) =
      __$$ChatDeliveryReceiptModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? lname,
      String? image,
      String? specialty,
      String? workingplace,
      @JsonKey(name: 'isSyndicateCardRequired') String? isSyndicateCardRequired,
      @JsonKey(name: 'delivered_at') String? deliveredAt,
      @JsonKey(name: 'read_at') String? readAt});
}

/// @nodoc
class __$$ChatDeliveryReceiptModelImplCopyWithImpl<$Res>
    extends _$ChatDeliveryReceiptModelCopyWithImpl<$Res,
        _$ChatDeliveryReceiptModelImpl>
    implements _$$ChatDeliveryReceiptModelImplCopyWith<$Res> {
  __$$ChatDeliveryReceiptModelImplCopyWithImpl(
      _$ChatDeliveryReceiptModelImpl _value,
      $Res Function(_$ChatDeliveryReceiptModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatDeliveryReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lname = freezed,
    Object? image = freezed,
    Object? specialty = freezed,
    Object? workingplace = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
  }) {
    return _then(_$ChatDeliveryReceiptModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lname: freezed == lname
          ? _value.lname
          : lname // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as String?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatDeliveryReceiptModelImpl implements _ChatDeliveryReceiptModel {
  const _$ChatDeliveryReceiptModelImpl(
      {this.id,
      this.name,
      this.lname,
      this.image,
      this.specialty,
      this.workingplace,
      @JsonKey(name: 'isSyndicateCardRequired') this.isSyndicateCardRequired,
      @JsonKey(name: 'delivered_at') this.deliveredAt,
      @JsonKey(name: 'read_at') this.readAt});

  factory _$ChatDeliveryReceiptModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatDeliveryReceiptModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? lname;
  @override
  final String? image;
  @override
  final String? specialty;
  @override
  final String? workingplace;
  @override
  @JsonKey(name: 'isSyndicateCardRequired')
  final String? isSyndicateCardRequired;
  @override
  @JsonKey(name: 'delivered_at')
  final String? deliveredAt;
  @override
  @JsonKey(name: 'read_at')
  final String? readAt;

  @override
  String toString() {
    return 'ChatDeliveryReceiptModel(id: $id, name: $name, lname: $lname, image: $image, specialty: $specialty, workingplace: $workingplace, isSyndicateCardRequired: $isSyndicateCardRequired, deliveredAt: $deliveredAt, readAt: $readAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDeliveryReceiptModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lname, lname) || other.lname == lname) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace) &&
            (identical(
                    other.isSyndicateCardRequired, isSyndicateCardRequired) ||
                other.isSyndicateCardRequired == isSyndicateCardRequired) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, lname, image,
      specialty, workingplace, isSyndicateCardRequired, deliveredAt, readAt);

  /// Create a copy of ChatDeliveryReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDeliveryReceiptModelImplCopyWith<_$ChatDeliveryReceiptModelImpl>
      get copyWith => __$$ChatDeliveryReceiptModelImplCopyWithImpl<
          _$ChatDeliveryReceiptModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatDeliveryReceiptModelImplToJson(
      this,
    );
  }
}

abstract class _ChatDeliveryReceiptModel implements ChatDeliveryReceiptModel {
  const factory _ChatDeliveryReceiptModel(
          {final int? id,
          final String? name,
          final String? lname,
          final String? image,
          final String? specialty,
          final String? workingplace,
          @JsonKey(name: 'isSyndicateCardRequired')
          final String? isSyndicateCardRequired,
          @JsonKey(name: 'delivered_at') final String? deliveredAt,
          @JsonKey(name: 'read_at') final String? readAt}) =
      _$ChatDeliveryReceiptModelImpl;

  factory _ChatDeliveryReceiptModel.fromJson(Map<String, dynamic> json) =
      _$ChatDeliveryReceiptModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get lname;
  @override
  String? get image;
  @override
  String? get specialty;
  @override
  String? get workingplace;
  @override
  @JsonKey(name: 'isSyndicateCardRequired')
  String? get isSyndicateCardRequired;
  @override
  @JsonKey(name: 'delivered_at')
  String? get deliveredAt;
  @override
  @JsonKey(name: 'read_at')
  String? get readAt;

  /// Create a copy of ChatDeliveryReceiptModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatDeliveryReceiptModelImplCopyWith<_$ChatDeliveryReceiptModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) {
  return _ChatMessageModel.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  int? get conversationId => throw _privateConstructorUsedError;
  ChatUserModel? get sender => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'system_event')
  String? get systemEvent => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  List<ChatAttachmentModel>? get attachments =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_to')
  ChatReplyToModel? get replyTo => throw _privateConstructorUsedError;
  List<ChatUserModel>? get reads => throw _privateConstructorUsedError;
  @JsonKey(name: 'reads_count', fromJson: _flexibleIntFromJson)
  int? get readsCount => throw _privateConstructorUsedError;
  List<ChatReactionModel>? get reactions => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_to_count', fromJson: _flexibleIntFromJson)
  int? get deliveredToCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'seen_by_count', fromJson: _flexibleIntFromJson)
  int? get seenByCount => throw _privateConstructorUsedError;
  List<ChatDeliveryReceiptModel>? get delivery =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted', fromJson: _flexibleBoolFromJson)
  bool? get isDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_edited', fromJson: _flexibleBoolFromJson)
  bool? get isEdited => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_forwarded', fromJson: _flexibleBoolFromJson)
  bool? get isForwarded => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageModelCopyWith<ChatMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageModelCopyWith<$Res> {
  factory $ChatMessageModelCopyWith(
          ChatMessageModel value, $Res Function(ChatMessageModel) then) =
      _$ChatMessageModelCopyWithImpl<$Res, ChatMessageModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      int? conversationId,
      ChatUserModel? sender,
      String? type,
      @JsonKey(name: 'system_event') String? systemEvent,
      String? content,
      List<ChatAttachmentModel>? attachments,
      @JsonKey(name: 'reply_to') ChatReplyToModel? replyTo,
      List<ChatUserModel>? reads,
      @JsonKey(name: 'reads_count', fromJson: _flexibleIntFromJson)
      int? readsCount,
      List<ChatReactionModel>? reactions,
      String? status,
      @JsonKey(name: 'delivered_to_count', fromJson: _flexibleIntFromJson)
      int? deliveredToCount,
      @JsonKey(name: 'seen_by_count', fromJson: _flexibleIntFromJson)
      int? seenByCount,
      List<ChatDeliveryReceiptModel>? delivery,
      @JsonKey(name: 'is_deleted', fromJson: _flexibleBoolFromJson)
      bool? isDeleted,
      @JsonKey(name: 'is_edited', fromJson: _flexibleBoolFromJson)
      bool? isEdited,
      @JsonKey(name: 'is_forwarded', fromJson: _flexibleBoolFromJson)
      bool? isForwarded,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});

  $ChatUserModelCopyWith<$Res>? get sender;
  $ChatReplyToModelCopyWith<$Res>? get replyTo;
}

/// @nodoc
class _$ChatMessageModelCopyWithImpl<$Res, $Val extends ChatMessageModel>
    implements $ChatMessageModelCopyWith<$Res> {
  _$ChatMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? conversationId = freezed,
    Object? sender = freezed,
    Object? type = freezed,
    Object? systemEvent = freezed,
    Object? content = freezed,
    Object? attachments = freezed,
    Object? replyTo = freezed,
    Object? reads = freezed,
    Object? readsCount = freezed,
    Object? reactions = freezed,
    Object? status = freezed,
    Object? deliveredToCount = freezed,
    Object? seenByCount = freezed,
    Object? delivery = freezed,
    Object? isDeleted = freezed,
    Object? isEdited = freezed,
    Object? isForwarded = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      systemEvent: freezed == systemEvent
          ? _value.systemEvent
          : systemEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<ChatAttachmentModel>?,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as ChatReplyToModel?,
      reads: freezed == reads
          ? _value.reads
          : reads // ignore: cast_nullable_to_non_nullable
              as List<ChatUserModel>?,
      readsCount: freezed == readsCount
          ? _value.readsCount
          : readsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ChatReactionModel>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveredToCount: freezed == deliveredToCount
          ? _value.deliveredToCount
          : deliveredToCount // ignore: cast_nullable_to_non_nullable
              as int?,
      seenByCount: freezed == seenByCount
          ? _value.seenByCount
          : seenByCount // ignore: cast_nullable_to_non_nullable
              as int?,
      delivery: freezed == delivery
          ? _value.delivery
          : delivery // ignore: cast_nullable_to_non_nullable
              as List<ChatDeliveryReceiptModel>?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEdited: freezed == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool?,
      isForwarded: freezed == isForwarded
          ? _value.isForwarded
          : isForwarded // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserModelCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $ChatUserModelCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatReplyToModelCopyWith<$Res>? get replyTo {
    if (_value.replyTo == null) {
      return null;
    }

    return $ChatReplyToModelCopyWith<$Res>(_value.replyTo!, (value) {
      return _then(_value.copyWith(replyTo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageModelImplCopyWith<$Res>
    implements $ChatMessageModelCopyWith<$Res> {
  factory _$$ChatMessageModelImplCopyWith(_$ChatMessageModelImpl value,
          $Res Function(_$ChatMessageModelImpl) then) =
      __$$ChatMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      int? conversationId,
      ChatUserModel? sender,
      String? type,
      @JsonKey(name: 'system_event') String? systemEvent,
      String? content,
      List<ChatAttachmentModel>? attachments,
      @JsonKey(name: 'reply_to') ChatReplyToModel? replyTo,
      List<ChatUserModel>? reads,
      @JsonKey(name: 'reads_count', fromJson: _flexibleIntFromJson)
      int? readsCount,
      List<ChatReactionModel>? reactions,
      String? status,
      @JsonKey(name: 'delivered_to_count', fromJson: _flexibleIntFromJson)
      int? deliveredToCount,
      @JsonKey(name: 'seen_by_count', fromJson: _flexibleIntFromJson)
      int? seenByCount,
      List<ChatDeliveryReceiptModel>? delivery,
      @JsonKey(name: 'is_deleted', fromJson: _flexibleBoolFromJson)
      bool? isDeleted,
      @JsonKey(name: 'is_edited', fromJson: _flexibleBoolFromJson)
      bool? isEdited,
      @JsonKey(name: 'is_forwarded', fromJson: _flexibleBoolFromJson)
      bool? isForwarded,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});

  @override
  $ChatUserModelCopyWith<$Res>? get sender;
  @override
  $ChatReplyToModelCopyWith<$Res>? get replyTo;
}

/// @nodoc
class __$$ChatMessageModelImplCopyWithImpl<$Res>
    extends _$ChatMessageModelCopyWithImpl<$Res, _$ChatMessageModelImpl>
    implements _$$ChatMessageModelImplCopyWith<$Res> {
  __$$ChatMessageModelImplCopyWithImpl(_$ChatMessageModelImpl _value,
      $Res Function(_$ChatMessageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? conversationId = freezed,
    Object? sender = freezed,
    Object? type = freezed,
    Object? systemEvent = freezed,
    Object? content = freezed,
    Object? attachments = freezed,
    Object? replyTo = freezed,
    Object? reads = freezed,
    Object? readsCount = freezed,
    Object? reactions = freezed,
    Object? status = freezed,
    Object? deliveredToCount = freezed,
    Object? seenByCount = freezed,
    Object? delivery = freezed,
    Object? isDeleted = freezed,
    Object? isEdited = freezed,
    Object? isForwarded = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ChatMessageModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      systemEvent: freezed == systemEvent
          ? _value.systemEvent
          : systemEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<ChatAttachmentModel>?,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as ChatReplyToModel?,
      reads: freezed == reads
          ? _value._reads
          : reads // ignore: cast_nullable_to_non_nullable
              as List<ChatUserModel>?,
      readsCount: freezed == readsCount
          ? _value.readsCount
          : readsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      reactions: freezed == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ChatReactionModel>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveredToCount: freezed == deliveredToCount
          ? _value.deliveredToCount
          : deliveredToCount // ignore: cast_nullable_to_non_nullable
              as int?,
      seenByCount: freezed == seenByCount
          ? _value.seenByCount
          : seenByCount // ignore: cast_nullable_to_non_nullable
              as int?,
      delivery: freezed == delivery
          ? _value._delivery
          : delivery // ignore: cast_nullable_to_non_nullable
              as List<ChatDeliveryReceiptModel>?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEdited: freezed == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool?,
      isForwarded: freezed == isForwarded
          ? _value.isForwarded
          : isForwarded // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageModelImpl implements _ChatMessageModel {
  const _$ChatMessageModelImpl(
      {this.id,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      this.conversationId,
      this.sender,
      this.type,
      @JsonKey(name: 'system_event') this.systemEvent,
      this.content,
      final List<ChatAttachmentModel>? attachments,
      @JsonKey(name: 'reply_to') this.replyTo,
      final List<ChatUserModel>? reads,
      @JsonKey(name: 'reads_count', fromJson: _flexibleIntFromJson)
      this.readsCount,
      final List<ChatReactionModel>? reactions,
      this.status,
      @JsonKey(name: 'delivered_to_count', fromJson: _flexibleIntFromJson)
      this.deliveredToCount,
      @JsonKey(name: 'seen_by_count', fromJson: _flexibleIntFromJson)
      this.seenByCount,
      final List<ChatDeliveryReceiptModel>? delivery,
      @JsonKey(name: 'is_deleted', fromJson: _flexibleBoolFromJson)
      this.isDeleted,
      @JsonKey(name: 'is_edited', fromJson: _flexibleBoolFromJson)
      this.isEdited,
      @JsonKey(name: 'is_forwarded', fromJson: _flexibleBoolFromJson)
      this.isForwarded,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _attachments = attachments,
        _reads = reads,
        _reactions = reactions,
        _delivery = delivery;

  factory _$ChatMessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  final int? conversationId;
  @override
  final ChatUserModel? sender;
  @override
  final String? type;
  @override
  @JsonKey(name: 'system_event')
  final String? systemEvent;
  @override
  final String? content;
  final List<ChatAttachmentModel>? _attachments;
  @override
  List<ChatAttachmentModel>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'reply_to')
  final ChatReplyToModel? replyTo;
  final List<ChatUserModel>? _reads;
  @override
  List<ChatUserModel>? get reads {
    final value = _reads;
    if (value == null) return null;
    if (_reads is EqualUnmodifiableListView) return _reads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'reads_count', fromJson: _flexibleIntFromJson)
  final int? readsCount;
  final List<ChatReactionModel>? _reactions;
  @override
  List<ChatReactionModel>? get reactions {
    final value = _reactions;
    if (value == null) return null;
    if (_reactions is EqualUnmodifiableListView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? status;
  @override
  @JsonKey(name: 'delivered_to_count', fromJson: _flexibleIntFromJson)
  final int? deliveredToCount;
  @override
  @JsonKey(name: 'seen_by_count', fromJson: _flexibleIntFromJson)
  final int? seenByCount;
  final List<ChatDeliveryReceiptModel>? _delivery;
  @override
  List<ChatDeliveryReceiptModel>? get delivery {
    final value = _delivery;
    if (value == null) return null;
    if (_delivery is EqualUnmodifiableListView) return _delivery;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_deleted', fromJson: _flexibleBoolFromJson)
  final bool? isDeleted;
  @override
  @JsonKey(name: 'is_edited', fromJson: _flexibleBoolFromJson)
  final bool? isEdited;
  @override
  @JsonKey(name: 'is_forwarded', fromJson: _flexibleBoolFromJson)
  final bool? isForwarded;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'ChatMessageModel(id: $id, conversationId: $conversationId, sender: $sender, type: $type, systemEvent: $systemEvent, content: $content, attachments: $attachments, replyTo: $replyTo, reads: $reads, readsCount: $readsCount, reactions: $reactions, status: $status, deliveredToCount: $deliveredToCount, seenByCount: $seenByCount, delivery: $delivery, isDeleted: $isDeleted, isEdited: $isEdited, isForwarded: $isForwarded, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.systemEvent, systemEvent) ||
                other.systemEvent == systemEvent) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            const DeepCollectionEquality().equals(other._reads, _reads) &&
            (identical(other.readsCount, readsCount) ||
                other.readsCount == readsCount) &&
            const DeepCollectionEquality()
                .equals(other._reactions, _reactions) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deliveredToCount, deliveredToCount) ||
                other.deliveredToCount == deliveredToCount) &&
            (identical(other.seenByCount, seenByCount) ||
                other.seenByCount == seenByCount) &&
            const DeepCollectionEquality().equals(other._delivery, _delivery) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isForwarded, isForwarded) ||
                other.isForwarded == isForwarded) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        conversationId,
        sender,
        type,
        systemEvent,
        content,
        const DeepCollectionEquality().hash(_attachments),
        replyTo,
        const DeepCollectionEquality().hash(_reads),
        readsCount,
        const DeepCollectionEquality().hash(_reactions),
        status,
        deliveredToCount,
        seenByCount,
        const DeepCollectionEquality().hash(_delivery),
        isDeleted,
        isEdited,
        isForwarded,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageModelImplCopyWith<_$ChatMessageModelImpl> get copyWith =>
      __$$ChatMessageModelImplCopyWithImpl<_$ChatMessageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageModelImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageModel implements ChatMessageModel {
  const factory _ChatMessageModel(
          {final int? id,
          @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
          final int? conversationId,
          final ChatUserModel? sender,
          final String? type,
          @JsonKey(name: 'system_event') final String? systemEvent,
          final String? content,
          final List<ChatAttachmentModel>? attachments,
          @JsonKey(name: 'reply_to') final ChatReplyToModel? replyTo,
          final List<ChatUserModel>? reads,
          @JsonKey(name: 'reads_count', fromJson: _flexibleIntFromJson)
          final int? readsCount,
          final List<ChatReactionModel>? reactions,
          final String? status,
          @JsonKey(name: 'delivered_to_count', fromJson: _flexibleIntFromJson)
          final int? deliveredToCount,
          @JsonKey(name: 'seen_by_count', fromJson: _flexibleIntFromJson)
          final int? seenByCount,
          final List<ChatDeliveryReceiptModel>? delivery,
          @JsonKey(name: 'is_deleted', fromJson: _flexibleBoolFromJson)
          final bool? isDeleted,
          @JsonKey(name: 'is_edited', fromJson: _flexibleBoolFromJson)
          final bool? isEdited,
          @JsonKey(name: 'is_forwarded', fromJson: _flexibleBoolFromJson)
          final bool? isForwarded,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt}) =
      _$ChatMessageModelImpl;

  factory _ChatMessageModel.fromJson(Map<String, dynamic> json) =
      _$ChatMessageModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  int? get conversationId;
  @override
  ChatUserModel? get sender;
  @override
  String? get type;
  @override
  @JsonKey(name: 'system_event')
  String? get systemEvent;
  @override
  String? get content;
  @override
  List<ChatAttachmentModel>? get attachments;
  @override
  @JsonKey(name: 'reply_to')
  ChatReplyToModel? get replyTo;
  @override
  List<ChatUserModel>? get reads;
  @override
  @JsonKey(name: 'reads_count', fromJson: _flexibleIntFromJson)
  int? get readsCount;
  @override
  List<ChatReactionModel>? get reactions;
  @override
  String? get status;
  @override
  @JsonKey(name: 'delivered_to_count', fromJson: _flexibleIntFromJson)
  int? get deliveredToCount;
  @override
  @JsonKey(name: 'seen_by_count', fromJson: _flexibleIntFromJson)
  int? get seenByCount;
  @override
  List<ChatDeliveryReceiptModel>? get delivery;
  @override
  @JsonKey(name: 'is_deleted', fromJson: _flexibleBoolFromJson)
  bool? get isDeleted;
  @override
  @JsonKey(name: 'is_edited', fromJson: _flexibleBoolFromJson)
  bool? get isEdited;
  @override
  @JsonKey(name: 'is_forwarded', fromJson: _flexibleBoolFromJson)
  bool? get isForwarded;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageModelImplCopyWith<_$ChatMessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessagesListModelResponse _$ChatMessagesListModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ChatMessagesListModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatMessagesListModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<ChatMessageModel>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more', fromJson: _flexibleBoolFromJson)
  bool? get hasMore => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  int? get conversationId => throw _privateConstructorUsedError;

  /// Serializes this ChatMessagesListModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessagesListModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessagesListModelResponseCopyWith<ChatMessagesListModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessagesListModelResponseCopyWith<$Res> {
  factory $ChatMessagesListModelResponseCopyWith(
          ChatMessagesListModelResponse value,
          $Res Function(ChatMessagesListModelResponse) then) =
      _$ChatMessagesListModelResponseCopyWithImpl<$Res,
          ChatMessagesListModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      String? message,
      List<ChatMessageModel>? data,
      @JsonKey(name: 'has_more', fromJson: _flexibleBoolFromJson) bool? hasMore,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      int? conversationId});
}

/// @nodoc
class _$ChatMessagesListModelResponseCopyWithImpl<$Res,
        $Val extends ChatMessagesListModelResponse>
    implements $ChatMessagesListModelResponseCopyWith<$Res> {
  _$ChatMessagesListModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessagesListModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
    Object? hasMore = freezed,
    Object? conversationId = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>?,
      hasMore: freezed == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessagesListModelResponseImplCopyWith<$Res>
    implements $ChatMessagesListModelResponseCopyWith<$Res> {
  factory _$$ChatMessagesListModelResponseImplCopyWith(
          _$ChatMessagesListModelResponseImpl value,
          $Res Function(_$ChatMessagesListModelResponseImpl) then) =
      __$$ChatMessagesListModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      String? message,
      List<ChatMessageModel>? data,
      @JsonKey(name: 'has_more', fromJson: _flexibleBoolFromJson) bool? hasMore,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      int? conversationId});
}

/// @nodoc
class __$$ChatMessagesListModelResponseImplCopyWithImpl<$Res>
    extends _$ChatMessagesListModelResponseCopyWithImpl<$Res,
        _$ChatMessagesListModelResponseImpl>
    implements _$$ChatMessagesListModelResponseImplCopyWith<$Res> {
  __$$ChatMessagesListModelResponseImplCopyWithImpl(
      _$ChatMessagesListModelResponseImpl _value,
      $Res Function(_$ChatMessagesListModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessagesListModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
    Object? hasMore = freezed,
    Object? conversationId = freezed,
  }) {
    return _then(_$ChatMessagesListModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>?,
      hasMore: freezed == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessagesListModelResponseImpl
    implements _ChatMessagesListModelResponse {
  const _$ChatMessagesListModelResponseImpl(
      {this.value,
      this.message,
      final List<ChatMessageModel>? data,
      @JsonKey(name: 'has_more', fromJson: _flexibleBoolFromJson) this.hasMore,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      this.conversationId})
      : _data = data;

  factory _$ChatMessagesListModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChatMessagesListModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  final List<ChatMessageModel>? _data;
  @override
  List<ChatMessageModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'has_more', fromJson: _flexibleBoolFromJson)
  final bool? hasMore;
  @override
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  final int? conversationId;

  @override
  String toString() {
    return 'ChatMessagesListModelResponse(value: $value, message: $message, data: $data, hasMore: $hasMore, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessagesListModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, message,
      const DeepCollectionEquality().hash(_data), hasMore, conversationId);

  /// Create a copy of ChatMessagesListModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessagesListModelResponseImplCopyWith<
          _$ChatMessagesListModelResponseImpl>
      get copyWith => __$$ChatMessagesListModelResponseImplCopyWithImpl<
          _$ChatMessagesListModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessagesListModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatMessagesListModelResponse
    implements ChatMessagesListModelResponse {
  const factory _ChatMessagesListModelResponse(
      {final bool? value,
      final String? message,
      final List<ChatMessageModel>? data,
      @JsonKey(name: 'has_more', fromJson: _flexibleBoolFromJson)
      final bool? hasMore,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      final int? conversationId}) = _$ChatMessagesListModelResponseImpl;

  factory _ChatMessagesListModelResponse.fromJson(Map<String, dynamic> json) =
      _$ChatMessagesListModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  List<ChatMessageModel>? get data;
  @override
  @JsonKey(name: 'has_more', fromJson: _flexibleBoolFromJson)
  bool? get hasMore;
  @override
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  int? get conversationId;

  /// Create a copy of ChatMessagesListModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessagesListModelResponseImplCopyWith<
          _$ChatMessagesListModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatMessageEnvelopeModelResponse _$ChatMessageEnvelopeModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ChatMessageEnvelopeModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageEnvelopeModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  ChatMessageModel? get data => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageEnvelopeModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageEnvelopeModelResponseCopyWith<ChatMessageEnvelopeModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageEnvelopeModelResponseCopyWith<$Res> {
  factory $ChatMessageEnvelopeModelResponseCopyWith(
          ChatMessageEnvelopeModelResponse value,
          $Res Function(ChatMessageEnvelopeModelResponse) then) =
      _$ChatMessageEnvelopeModelResponseCopyWithImpl<$Res,
          ChatMessageEnvelopeModelResponse>;
  @useResult
  $Res call({bool? value, String? message, ChatMessageModel? data});

  $ChatMessageModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$ChatMessageEnvelopeModelResponseCopyWithImpl<$Res,
        $Val extends ChatMessageEnvelopeModelResponse>
    implements $ChatMessageEnvelopeModelResponseCopyWith<$Res> {
  _$ChatMessageEnvelopeModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatMessageModel?,
    ) as $Val);
  }

  /// Create a copy of ChatMessageEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ChatMessageModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageEnvelopeModelResponseImplCopyWith<$Res>
    implements $ChatMessageEnvelopeModelResponseCopyWith<$Res> {
  factory _$$ChatMessageEnvelopeModelResponseImplCopyWith(
          _$ChatMessageEnvelopeModelResponseImpl value,
          $Res Function(_$ChatMessageEnvelopeModelResponseImpl) then) =
      __$$ChatMessageEnvelopeModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, ChatMessageModel? data});

  @override
  $ChatMessageModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ChatMessageEnvelopeModelResponseImplCopyWithImpl<$Res>
    extends _$ChatMessageEnvelopeModelResponseCopyWithImpl<$Res,
        _$ChatMessageEnvelopeModelResponseImpl>
    implements _$$ChatMessageEnvelopeModelResponseImplCopyWith<$Res> {
  __$$ChatMessageEnvelopeModelResponseImplCopyWithImpl(
      _$ChatMessageEnvelopeModelResponseImpl _value,
      $Res Function(_$ChatMessageEnvelopeModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ChatMessageEnvelopeModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatMessageModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageEnvelopeModelResponseImpl
    implements _ChatMessageEnvelopeModelResponse {
  const _$ChatMessageEnvelopeModelResponseImpl(
      {this.value, this.message, this.data});

  factory _$ChatMessageEnvelopeModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChatMessageEnvelopeModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  @override
  final ChatMessageModel? data;

  @override
  String toString() {
    return 'ChatMessageEnvelopeModelResponse(value: $value, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageEnvelopeModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, message, data);

  /// Create a copy of ChatMessageEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageEnvelopeModelResponseImplCopyWith<
          _$ChatMessageEnvelopeModelResponseImpl>
      get copyWith => __$$ChatMessageEnvelopeModelResponseImplCopyWithImpl<
          _$ChatMessageEnvelopeModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageEnvelopeModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageEnvelopeModelResponse
    implements ChatMessageEnvelopeModelResponse {
  const factory _ChatMessageEnvelopeModelResponse(
      {final bool? value,
      final String? message,
      final ChatMessageModel? data}) = _$ChatMessageEnvelopeModelResponseImpl;

  factory _ChatMessageEnvelopeModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$ChatMessageEnvelopeModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  ChatMessageModel? get data;

  /// Create a copy of ChatMessageEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageEnvelopeModelResponseImplCopyWith<
          _$ChatMessageEnvelopeModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatReactionsEnvelopeModelResponse _$ChatReactionsEnvelopeModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ChatReactionsEnvelopeModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatReactionsEnvelopeModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  ChatReactionsDataModel? get data => throw _privateConstructorUsedError;

  /// Serializes this ChatReactionsEnvelopeModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatReactionsEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatReactionsEnvelopeModelResponseCopyWith<
          ChatReactionsEnvelopeModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatReactionsEnvelopeModelResponseCopyWith<$Res> {
  factory $ChatReactionsEnvelopeModelResponseCopyWith(
          ChatReactionsEnvelopeModelResponse value,
          $Res Function(ChatReactionsEnvelopeModelResponse) then) =
      _$ChatReactionsEnvelopeModelResponseCopyWithImpl<$Res,
          ChatReactionsEnvelopeModelResponse>;
  @useResult
  $Res call({bool? value, String? message, ChatReactionsDataModel? data});

  $ChatReactionsDataModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$ChatReactionsEnvelopeModelResponseCopyWithImpl<$Res,
        $Val extends ChatReactionsEnvelopeModelResponse>
    implements $ChatReactionsEnvelopeModelResponseCopyWith<$Res> {
  _$ChatReactionsEnvelopeModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatReactionsEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatReactionsDataModel?,
    ) as $Val);
  }

  /// Create a copy of ChatReactionsEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatReactionsDataModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ChatReactionsDataModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatReactionsEnvelopeModelResponseImplCopyWith<$Res>
    implements $ChatReactionsEnvelopeModelResponseCopyWith<$Res> {
  factory _$$ChatReactionsEnvelopeModelResponseImplCopyWith(
          _$ChatReactionsEnvelopeModelResponseImpl value,
          $Res Function(_$ChatReactionsEnvelopeModelResponseImpl) then) =
      __$$ChatReactionsEnvelopeModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, ChatReactionsDataModel? data});

  @override
  $ChatReactionsDataModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ChatReactionsEnvelopeModelResponseImplCopyWithImpl<$Res>
    extends _$ChatReactionsEnvelopeModelResponseCopyWithImpl<$Res,
        _$ChatReactionsEnvelopeModelResponseImpl>
    implements _$$ChatReactionsEnvelopeModelResponseImplCopyWith<$Res> {
  __$$ChatReactionsEnvelopeModelResponseImplCopyWithImpl(
      _$ChatReactionsEnvelopeModelResponseImpl _value,
      $Res Function(_$ChatReactionsEnvelopeModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatReactionsEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ChatReactionsEnvelopeModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatReactionsDataModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatReactionsEnvelopeModelResponseImpl
    implements _ChatReactionsEnvelopeModelResponse {
  const _$ChatReactionsEnvelopeModelResponseImpl(
      {this.value, this.message, this.data});

  factory _$ChatReactionsEnvelopeModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChatReactionsEnvelopeModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  @override
  final ChatReactionsDataModel? data;

  @override
  String toString() {
    return 'ChatReactionsEnvelopeModelResponse(value: $value, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatReactionsEnvelopeModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, message, data);

  /// Create a copy of ChatReactionsEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatReactionsEnvelopeModelResponseImplCopyWith<
          _$ChatReactionsEnvelopeModelResponseImpl>
      get copyWith => __$$ChatReactionsEnvelopeModelResponseImplCopyWithImpl<
          _$ChatReactionsEnvelopeModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatReactionsEnvelopeModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatReactionsEnvelopeModelResponse
    implements ChatReactionsEnvelopeModelResponse {
  const factory _ChatReactionsEnvelopeModelResponse(
          {final bool? value,
          final String? message,
          final ChatReactionsDataModel? data}) =
      _$ChatReactionsEnvelopeModelResponseImpl;

  factory _ChatReactionsEnvelopeModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$ChatReactionsEnvelopeModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  ChatReactionsDataModel? get data;

  /// Create a copy of ChatReactionsEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatReactionsEnvelopeModelResponseImplCopyWith<
          _$ChatReactionsEnvelopeModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatReactionsDataModel _$ChatReactionsDataModelFromJson(
    Map<String, dynamic> json) {
  return _ChatReactionsDataModel.fromJson(json);
}

/// @nodoc
mixin _$ChatReactionsDataModel {
  List<ChatReactionModel>? get reactions => throw _privateConstructorUsedError;

  /// Serializes this ChatReactionsDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatReactionsDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatReactionsDataModelCopyWith<ChatReactionsDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatReactionsDataModelCopyWith<$Res> {
  factory $ChatReactionsDataModelCopyWith(ChatReactionsDataModel value,
          $Res Function(ChatReactionsDataModel) then) =
      _$ChatReactionsDataModelCopyWithImpl<$Res, ChatReactionsDataModel>;
  @useResult
  $Res call({List<ChatReactionModel>? reactions});
}

/// @nodoc
class _$ChatReactionsDataModelCopyWithImpl<$Res,
        $Val extends ChatReactionsDataModel>
    implements $ChatReactionsDataModelCopyWith<$Res> {
  _$ChatReactionsDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatReactionsDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reactions = freezed,
  }) {
    return _then(_value.copyWith(
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ChatReactionModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatReactionsDataModelImplCopyWith<$Res>
    implements $ChatReactionsDataModelCopyWith<$Res> {
  factory _$$ChatReactionsDataModelImplCopyWith(
          _$ChatReactionsDataModelImpl value,
          $Res Function(_$ChatReactionsDataModelImpl) then) =
      __$$ChatReactionsDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ChatReactionModel>? reactions});
}

/// @nodoc
class __$$ChatReactionsDataModelImplCopyWithImpl<$Res>
    extends _$ChatReactionsDataModelCopyWithImpl<$Res,
        _$ChatReactionsDataModelImpl>
    implements _$$ChatReactionsDataModelImplCopyWith<$Res> {
  __$$ChatReactionsDataModelImplCopyWithImpl(
      _$ChatReactionsDataModelImpl _value,
      $Res Function(_$ChatReactionsDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatReactionsDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reactions = freezed,
  }) {
    return _then(_$ChatReactionsDataModelImpl(
      reactions: freezed == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ChatReactionModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatReactionsDataModelImpl implements _ChatReactionsDataModel {
  const _$ChatReactionsDataModelImpl({final List<ChatReactionModel>? reactions})
      : _reactions = reactions;

  factory _$ChatReactionsDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatReactionsDataModelImplFromJson(json);

  final List<ChatReactionModel>? _reactions;
  @override
  List<ChatReactionModel>? get reactions {
    final value = _reactions;
    if (value == null) return null;
    if (_reactions is EqualUnmodifiableListView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChatReactionsDataModel(reactions: $reactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatReactionsDataModelImpl &&
            const DeepCollectionEquality()
                .equals(other._reactions, _reactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_reactions));

  /// Create a copy of ChatReactionsDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatReactionsDataModelImplCopyWith<_$ChatReactionsDataModelImpl>
      get copyWith => __$$ChatReactionsDataModelImplCopyWithImpl<
          _$ChatReactionsDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatReactionsDataModelImplToJson(
      this,
    );
  }
}

abstract class _ChatReactionsDataModel implements ChatReactionsDataModel {
  const factory _ChatReactionsDataModel(
          {final List<ChatReactionModel>? reactions}) =
      _$ChatReactionsDataModelImpl;

  factory _ChatReactionsDataModel.fromJson(Map<String, dynamic> json) =
      _$ChatReactionsDataModelImpl.fromJson;

  @override
  List<ChatReactionModel>? get reactions;

  /// Create a copy of ChatReactionsDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatReactionsDataModelImplCopyWith<_$ChatReactionsDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatUsersSearchModelResponse _$ChatUsersSearchModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ChatUsersSearchModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatUsersSearchModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<ChatUserModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this ChatUsersSearchModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatUsersSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatUsersSearchModelResponseCopyWith<ChatUsersSearchModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatUsersSearchModelResponseCopyWith<$Res> {
  factory $ChatUsersSearchModelResponseCopyWith(
          ChatUsersSearchModelResponse value,
          $Res Function(ChatUsersSearchModelResponse) then) =
      _$ChatUsersSearchModelResponseCopyWithImpl<$Res,
          ChatUsersSearchModelResponse>;
  @useResult
  $Res call({bool? value, String? message, List<ChatUserModel>? data});
}

/// @nodoc
class _$ChatUsersSearchModelResponseCopyWithImpl<$Res,
        $Val extends ChatUsersSearchModelResponse>
    implements $ChatUsersSearchModelResponseCopyWith<$Res> {
  _$ChatUsersSearchModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatUsersSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChatUserModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatUsersSearchModelResponseImplCopyWith<$Res>
    implements $ChatUsersSearchModelResponseCopyWith<$Res> {
  factory _$$ChatUsersSearchModelResponseImplCopyWith(
          _$ChatUsersSearchModelResponseImpl value,
          $Res Function(_$ChatUsersSearchModelResponseImpl) then) =
      __$$ChatUsersSearchModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, List<ChatUserModel>? data});
}

/// @nodoc
class __$$ChatUsersSearchModelResponseImplCopyWithImpl<$Res>
    extends _$ChatUsersSearchModelResponseCopyWithImpl<$Res,
        _$ChatUsersSearchModelResponseImpl>
    implements _$$ChatUsersSearchModelResponseImplCopyWith<$Res> {
  __$$ChatUsersSearchModelResponseImplCopyWithImpl(
      _$ChatUsersSearchModelResponseImpl _value,
      $Res Function(_$ChatUsersSearchModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatUsersSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ChatUsersSearchModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChatUserModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatUsersSearchModelResponseImpl
    implements _ChatUsersSearchModelResponse {
  const _$ChatUsersSearchModelResponseImpl(
      {this.value, this.message, final List<ChatUserModel>? data})
      : _data = data;

  factory _$ChatUsersSearchModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChatUsersSearchModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  final List<ChatUserModel>? _data;
  @override
  List<ChatUserModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChatUsersSearchModelResponse(value: $value, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatUsersSearchModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, message, const DeepCollectionEquality().hash(_data));

  /// Create a copy of ChatUsersSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatUsersSearchModelResponseImplCopyWith<
          _$ChatUsersSearchModelResponseImpl>
      get copyWith => __$$ChatUsersSearchModelResponseImplCopyWithImpl<
          _$ChatUsersSearchModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatUsersSearchModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatUsersSearchModelResponse
    implements ChatUsersSearchModelResponse {
  const factory _ChatUsersSearchModelResponse(
      {final bool? value,
      final String? message,
      final List<ChatUserModel>? data}) = _$ChatUsersSearchModelResponseImpl;

  factory _ChatUsersSearchModelResponse.fromJson(Map<String, dynamic> json) =
      _$ChatUsersSearchModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  List<ChatUserModel>? get data;

  /// Create a copy of ChatUsersSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatUsersSearchModelResponseImplCopyWith<
          _$ChatUsersSearchModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatPaginatorMeta _$ChatPaginatorMetaFromJson(Map<String, dynamic> json) {
  return _ChatPaginatorMeta.fromJson(json);
}

/// @nodoc
mixin _$ChatPaginatorMeta {
  @JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
  int? get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson)
  int? get perPage => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
  int? get lastPage => throw _privateConstructorUsedError;

  /// Serializes this ChatPaginatorMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatPaginatorMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatPaginatorMetaCopyWith<ChatPaginatorMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatPaginatorMetaCopyWith<$Res> {
  factory $ChatPaginatorMetaCopyWith(
          ChatPaginatorMeta value, $Res Function(ChatPaginatorMeta) then) =
      _$ChatPaginatorMetaCopyWithImpl<$Res, ChatPaginatorMeta>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
      int? currentPage,
      @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson) int? perPage,
      @JsonKey(fromJson: _flexibleIntFromJson) int? total,
      @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
      int? lastPage});
}

/// @nodoc
class _$ChatPaginatorMetaCopyWithImpl<$Res, $Val extends ChatPaginatorMeta>
    implements $ChatPaginatorMetaCopyWith<$Res> {
  _$ChatPaginatorMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatPaginatorMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? lastPage = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatPaginatorMetaImplCopyWith<$Res>
    implements $ChatPaginatorMetaCopyWith<$Res> {
  factory _$$ChatPaginatorMetaImplCopyWith(_$ChatPaginatorMetaImpl value,
          $Res Function(_$ChatPaginatorMetaImpl) then) =
      __$$ChatPaginatorMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
      int? currentPage,
      @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson) int? perPage,
      @JsonKey(fromJson: _flexibleIntFromJson) int? total,
      @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
      int? lastPage});
}

/// @nodoc
class __$$ChatPaginatorMetaImplCopyWithImpl<$Res>
    extends _$ChatPaginatorMetaCopyWithImpl<$Res, _$ChatPaginatorMetaImpl>
    implements _$$ChatPaginatorMetaImplCopyWith<$Res> {
  __$$ChatPaginatorMetaImplCopyWithImpl(_$ChatPaginatorMetaImpl _value,
      $Res Function(_$ChatPaginatorMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatPaginatorMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? lastPage = freezed,
  }) {
    return _then(_$ChatPaginatorMetaImpl(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatPaginatorMetaImpl implements _ChatPaginatorMeta {
  const _$ChatPaginatorMetaImpl(
      {@JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
      this.currentPage,
      @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson) this.perPage,
      @JsonKey(fromJson: _flexibleIntFromJson) this.total,
      @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
      this.lastPage});

  factory _$ChatPaginatorMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatPaginatorMetaImplFromJson(json);

  @override
  @JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
  final int? currentPage;
  @override
  @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson)
  final int? perPage;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? total;
  @override
  @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
  final int? lastPage;

  @override
  String toString() {
    return 'ChatPaginatorMeta(currentPage: $currentPage, perPage: $perPage, total: $total, lastPage: $lastPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatPaginatorMetaImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, perPage, total, lastPage);

  /// Create a copy of ChatPaginatorMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatPaginatorMetaImplCopyWith<_$ChatPaginatorMetaImpl> get copyWith =>
      __$$ChatPaginatorMetaImplCopyWithImpl<_$ChatPaginatorMetaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatPaginatorMetaImplToJson(
      this,
    );
  }
}

abstract class _ChatPaginatorMeta implements ChatPaginatorMeta {
  const factory _ChatPaginatorMeta(
      {@JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
      final int? currentPage,
      @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson)
      final int? perPage,
      @JsonKey(fromJson: _flexibleIntFromJson) final int? total,
      @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
      final int? lastPage}) = _$ChatPaginatorMetaImpl;

  factory _ChatPaginatorMeta.fromJson(Map<String, dynamic> json) =
      _$ChatPaginatorMetaImpl.fromJson;

  @override
  @JsonKey(name: 'current_page', fromJson: _flexibleIntFromJson)
  int? get currentPage;
  @override
  @JsonKey(name: 'per_page', fromJson: _flexibleIntFromJson)
  int? get perPage;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get total;
  @override
  @JsonKey(name: 'last_page', fromJson: _flexibleIntFromJson)
  int? get lastPage;

  /// Create a copy of ChatPaginatorMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatPaginatorMetaImplCopyWith<_$ChatPaginatorMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessageSearchHit _$ChatMessageSearchHitFromJson(Map<String, dynamic> json) {
  return _ChatMessageSearchHit.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageSearchHit {
  @JsonKey(name: 'message_id', fromJson: _flexibleIntFromJson)
  int? get messageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  int? get conversationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_type')
  String? get chatType => throw _privateConstructorUsedError;
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  int? get contextId => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_title')
  String? get conversationTitle => throw _privateConstructorUsedError;
  ChatUserModel? get sender => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageSearchHit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageSearchHit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageSearchHitCopyWith<ChatMessageSearchHit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageSearchHitCopyWith<$Res> {
  factory $ChatMessageSearchHitCopyWith(ChatMessageSearchHit value,
          $Res Function(ChatMessageSearchHit) then) =
      _$ChatMessageSearchHitCopyWithImpl<$Res, ChatMessageSearchHit>;
  @useResult
  $Res call(
      {@JsonKey(name: 'message_id', fromJson: _flexibleIntFromJson)
      int? messageId,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      int? conversationId,
      @JsonKey(name: 'chat_type') String? chatType,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      int? contextId,
      @JsonKey(name: 'conversation_title') String? conversationTitle,
      ChatUserModel? sender,
      String? content,
      @JsonKey(name: 'created_at') String? createdAt});

  $ChatUserModelCopyWith<$Res>? get sender;
}

/// @nodoc
class _$ChatMessageSearchHitCopyWithImpl<$Res,
        $Val extends ChatMessageSearchHit>
    implements $ChatMessageSearchHitCopyWith<$Res> {
  _$ChatMessageSearchHitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageSearchHit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = freezed,
    Object? conversationId = freezed,
    Object? chatType = freezed,
    Object? contextId = freezed,
    Object? conversationTitle = freezed,
    Object? sender = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
      chatType: freezed == chatType
          ? _value.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as String?,
      contextId: freezed == contextId
          ? _value.contextId
          : contextId // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationTitle: freezed == conversationTitle
          ? _value.conversationTitle
          : conversationTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ChatMessageSearchHit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserModelCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $ChatUserModelCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageSearchHitImplCopyWith<$Res>
    implements $ChatMessageSearchHitCopyWith<$Res> {
  factory _$$ChatMessageSearchHitImplCopyWith(_$ChatMessageSearchHitImpl value,
          $Res Function(_$ChatMessageSearchHitImpl) then) =
      __$$ChatMessageSearchHitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'message_id', fromJson: _flexibleIntFromJson)
      int? messageId,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      int? conversationId,
      @JsonKey(name: 'chat_type') String? chatType,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      int? contextId,
      @JsonKey(name: 'conversation_title') String? conversationTitle,
      ChatUserModel? sender,
      String? content,
      @JsonKey(name: 'created_at') String? createdAt});

  @override
  $ChatUserModelCopyWith<$Res>? get sender;
}

/// @nodoc
class __$$ChatMessageSearchHitImplCopyWithImpl<$Res>
    extends _$ChatMessageSearchHitCopyWithImpl<$Res, _$ChatMessageSearchHitImpl>
    implements _$$ChatMessageSearchHitImplCopyWith<$Res> {
  __$$ChatMessageSearchHitImplCopyWithImpl(_$ChatMessageSearchHitImpl _value,
      $Res Function(_$ChatMessageSearchHitImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageSearchHit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = freezed,
    Object? conversationId = freezed,
    Object? chatType = freezed,
    Object? contextId = freezed,
    Object? conversationTitle = freezed,
    Object? sender = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChatMessageSearchHitImpl(
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
      chatType: freezed == chatType
          ? _value.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as String?,
      contextId: freezed == contextId
          ? _value.contextId
          : contextId // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationTitle: freezed == conversationTitle
          ? _value.conversationTitle
          : conversationTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageSearchHitImpl implements _ChatMessageSearchHit {
  const _$ChatMessageSearchHitImpl(
      {@JsonKey(name: 'message_id', fromJson: _flexibleIntFromJson)
      this.messageId,
      @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
      this.conversationId,
      @JsonKey(name: 'chat_type') this.chatType,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      this.contextId,
      @JsonKey(name: 'conversation_title') this.conversationTitle,
      this.sender,
      this.content,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$ChatMessageSearchHitImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageSearchHitImplFromJson(json);

  @override
  @JsonKey(name: 'message_id', fromJson: _flexibleIntFromJson)
  final int? messageId;
  @override
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  final int? conversationId;
  @override
  @JsonKey(name: 'chat_type')
  final String? chatType;
  @override
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  final int? contextId;
  @override
  @JsonKey(name: 'conversation_title')
  final String? conversationTitle;
  @override
  final ChatUserModel? sender;
  @override
  final String? content;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'ChatMessageSearchHit(messageId: $messageId, conversationId: $conversationId, chatType: $chatType, contextId: $contextId, conversationTitle: $conversationTitle, sender: $sender, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageSearchHitImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.chatType, chatType) ||
                other.chatType == chatType) &&
            (identical(other.contextId, contextId) ||
                other.contextId == contextId) &&
            (identical(other.conversationTitle, conversationTitle) ||
                other.conversationTitle == conversationTitle) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, conversationId,
      chatType, contextId, conversationTitle, sender, content, createdAt);

  /// Create a copy of ChatMessageSearchHit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageSearchHitImplCopyWith<_$ChatMessageSearchHitImpl>
      get copyWith =>
          __$$ChatMessageSearchHitImplCopyWithImpl<_$ChatMessageSearchHitImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageSearchHitImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageSearchHit implements ChatMessageSearchHit {
  const factory _ChatMessageSearchHit(
          {@JsonKey(name: 'message_id', fromJson: _flexibleIntFromJson)
          final int? messageId,
          @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
          final int? conversationId,
          @JsonKey(name: 'chat_type') final String? chatType,
          @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
          final int? contextId,
          @JsonKey(name: 'conversation_title') final String? conversationTitle,
          final ChatUserModel? sender,
          final String? content,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$ChatMessageSearchHitImpl;

  factory _ChatMessageSearchHit.fromJson(Map<String, dynamic> json) =
      _$ChatMessageSearchHitImpl.fromJson;

  @override
  @JsonKey(name: 'message_id', fromJson: _flexibleIntFromJson)
  int? get messageId;
  @override
  @JsonKey(name: 'conversation_id', fromJson: _flexibleIntFromJson)
  int? get conversationId;
  @override
  @JsonKey(name: 'chat_type')
  String? get chatType;
  @override
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  int? get contextId;
  @override
  @JsonKey(name: 'conversation_title')
  String? get conversationTitle;
  @override
  ChatUserModel? get sender;
  @override
  String? get content;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of ChatMessageSearchHit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageSearchHitImplCopyWith<_$ChatMessageSearchHitImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatMessageSearchData {
  List<ChatMessageSearchHit>? get items => throw _privateConstructorUsedError;
  ChatPaginatorMeta? get meta => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageSearchData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageSearchDataCopyWith<ChatMessageSearchData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageSearchDataCopyWith<$Res> {
  factory $ChatMessageSearchDataCopyWith(ChatMessageSearchData value,
          $Res Function(ChatMessageSearchData) then) =
      _$ChatMessageSearchDataCopyWithImpl<$Res, ChatMessageSearchData>;
  @useResult
  $Res call({List<ChatMessageSearchHit>? items, ChatPaginatorMeta? meta});

  $ChatPaginatorMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$ChatMessageSearchDataCopyWithImpl<$Res,
        $Val extends ChatMessageSearchData>
    implements $ChatMessageSearchDataCopyWith<$Res> {
  _$ChatMessageSearchDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageSearchData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageSearchHit>?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as ChatPaginatorMeta?,
    ) as $Val);
  }

  /// Create a copy of ChatMessageSearchData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatPaginatorMetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $ChatPaginatorMetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageSearchDataImplCopyWith<$Res>
    implements $ChatMessageSearchDataCopyWith<$Res> {
  factory _$$ChatMessageSearchDataImplCopyWith(
          _$ChatMessageSearchDataImpl value,
          $Res Function(_$ChatMessageSearchDataImpl) then) =
      __$$ChatMessageSearchDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ChatMessageSearchHit>? items, ChatPaginatorMeta? meta});

  @override
  $ChatPaginatorMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$ChatMessageSearchDataImplCopyWithImpl<$Res>
    extends _$ChatMessageSearchDataCopyWithImpl<$Res,
        _$ChatMessageSearchDataImpl>
    implements _$$ChatMessageSearchDataImplCopyWith<$Res> {
  __$$ChatMessageSearchDataImplCopyWithImpl(_$ChatMessageSearchDataImpl _value,
      $Res Function(_$ChatMessageSearchDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageSearchData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? meta = freezed,
  }) {
    return _then(_$ChatMessageSearchDataImpl(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageSearchHit>?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as ChatPaginatorMeta?,
    ));
  }
}

/// @nodoc

class _$ChatMessageSearchDataImpl implements _ChatMessageSearchData {
  const _$ChatMessageSearchDataImpl(
      {final List<ChatMessageSearchHit>? items, this.meta})
      : _items = items;

  final List<ChatMessageSearchHit>? _items;
  @override
  List<ChatMessageSearchHit>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ChatPaginatorMeta? meta;

  @override
  String toString() {
    return 'ChatMessageSearchData(items: $items, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageSearchDataImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), meta);

  /// Create a copy of ChatMessageSearchData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageSearchDataImplCopyWith<_$ChatMessageSearchDataImpl>
      get copyWith => __$$ChatMessageSearchDataImplCopyWithImpl<
          _$ChatMessageSearchDataImpl>(this, _$identity);
}

abstract class _ChatMessageSearchData implements ChatMessageSearchData {
  const factory _ChatMessageSearchData(
      {final List<ChatMessageSearchHit>? items,
      final ChatPaginatorMeta? meta}) = _$ChatMessageSearchDataImpl;

  @override
  List<ChatMessageSearchHit>? get items;
  @override
  ChatPaginatorMeta? get meta;

  /// Create a copy of ChatMessageSearchData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageSearchDataImplCopyWith<_$ChatMessageSearchDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatMessageSearchModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  ChatMessageSearchData? get data => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageSearchModelResponseCopyWith<ChatMessageSearchModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageSearchModelResponseCopyWith<$Res> {
  factory $ChatMessageSearchModelResponseCopyWith(
          ChatMessageSearchModelResponse value,
          $Res Function(ChatMessageSearchModelResponse) then) =
      _$ChatMessageSearchModelResponseCopyWithImpl<$Res,
          ChatMessageSearchModelResponse>;
  @useResult
  $Res call({bool? value, String? message, ChatMessageSearchData? data});

  $ChatMessageSearchDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$ChatMessageSearchModelResponseCopyWithImpl<$Res,
        $Val extends ChatMessageSearchModelResponse>
    implements $ChatMessageSearchModelResponseCopyWith<$Res> {
  _$ChatMessageSearchModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatMessageSearchData?,
    ) as $Val);
  }

  /// Create a copy of ChatMessageSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageSearchDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ChatMessageSearchDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageSearchModelResponseImplCopyWith<$Res>
    implements $ChatMessageSearchModelResponseCopyWith<$Res> {
  factory _$$ChatMessageSearchModelResponseImplCopyWith(
          _$ChatMessageSearchModelResponseImpl value,
          $Res Function(_$ChatMessageSearchModelResponseImpl) then) =
      __$$ChatMessageSearchModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, ChatMessageSearchData? data});

  @override
  $ChatMessageSearchDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ChatMessageSearchModelResponseImplCopyWithImpl<$Res>
    extends _$ChatMessageSearchModelResponseCopyWithImpl<$Res,
        _$ChatMessageSearchModelResponseImpl>
    implements _$$ChatMessageSearchModelResponseImplCopyWith<$Res> {
  __$$ChatMessageSearchModelResponseImplCopyWithImpl(
      _$ChatMessageSearchModelResponseImpl _value,
      $Res Function(_$ChatMessageSearchModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ChatMessageSearchModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatMessageSearchData?,
    ));
  }
}

/// @nodoc

class _$ChatMessageSearchModelResponseImpl
    implements _ChatMessageSearchModelResponse {
  const _$ChatMessageSearchModelResponseImpl(
      {this.value, this.message, this.data});

  @override
  final bool? value;
  @override
  final String? message;
  @override
  final ChatMessageSearchData? data;

  @override
  String toString() {
    return 'ChatMessageSearchModelResponse(value: $value, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageSearchModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, message, data);

  /// Create a copy of ChatMessageSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageSearchModelResponseImplCopyWith<
          _$ChatMessageSearchModelResponseImpl>
      get copyWith => __$$ChatMessageSearchModelResponseImplCopyWithImpl<
          _$ChatMessageSearchModelResponseImpl>(this, _$identity);
}

abstract class _ChatMessageSearchModelResponse
    implements ChatMessageSearchModelResponse {
  const factory _ChatMessageSearchModelResponse(
          {final bool? value,
          final String? message,
          final ChatMessageSearchData? data}) =
      _$ChatMessageSearchModelResponseImpl;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  ChatMessageSearchData? get data;

  /// Create a copy of ChatMessageSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageSearchModelResponseImplCopyWith<
          _$ChatMessageSearchModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatConversationModel _$ChatConversationModelFromJson(
    Map<String, dynamic> json) {
  return _ChatConversationModel.fromJson(json);
}

/// @nodoc
mixin _$ChatConversationModel {
  int? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  int? get contextId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by', fromJson: _flexibleIntFromJson)
  int? get createdBy => throw _privateConstructorUsedError;
  ChatUserModel? get creator => throw _privateConstructorUsedError;
  @JsonKey(name: 'my_role')
  String? get myRole => throw _privateConstructorUsedError;
  List<ChatUserModel>? get participants => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ChatConversationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatConversationModelCopyWith<ChatConversationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatConversationModelCopyWith<$Res> {
  factory $ChatConversationModelCopyWith(ChatConversationModel value,
          $Res Function(ChatConversationModel) then) =
      _$ChatConversationModelCopyWithImpl<$Res, ChatConversationModel>;
  @useResult
  $Res call(
      {int? id,
      String? type,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      int? contextId,
      String? name,
      String? description,
      String? image,
      @JsonKey(name: 'created_by', fromJson: _flexibleIntFromJson)
      int? createdBy,
      ChatUserModel? creator,
      @JsonKey(name: 'my_role') String? myRole,
      List<ChatUserModel>? participants,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});

  $ChatUserModelCopyWith<$Res>? get creator;
}

/// @nodoc
class _$ChatConversationModelCopyWithImpl<$Res,
        $Val extends ChatConversationModel>
    implements $ChatConversationModelCopyWith<$Res> {
  _$ChatConversationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? contextId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? createdBy = freezed,
    Object? creator = freezed,
    Object? myRole = freezed,
    Object? participants = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      contextId: freezed == contextId
          ? _value.contextId
          : contextId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as int?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
      myRole: freezed == myRole
          ? _value.myRole
          : myRole // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: freezed == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<ChatUserModel>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ChatConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserModelCopyWith<$Res>? get creator {
    if (_value.creator == null) {
      return null;
    }

    return $ChatUserModelCopyWith<$Res>(_value.creator!, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatConversationModelImplCopyWith<$Res>
    implements $ChatConversationModelCopyWith<$Res> {
  factory _$$ChatConversationModelImplCopyWith(
          _$ChatConversationModelImpl value,
          $Res Function(_$ChatConversationModelImpl) then) =
      __$$ChatConversationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? type,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      int? contextId,
      String? name,
      String? description,
      String? image,
      @JsonKey(name: 'created_by', fromJson: _flexibleIntFromJson)
      int? createdBy,
      ChatUserModel? creator,
      @JsonKey(name: 'my_role') String? myRole,
      List<ChatUserModel>? participants,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});

  @override
  $ChatUserModelCopyWith<$Res>? get creator;
}

/// @nodoc
class __$$ChatConversationModelImplCopyWithImpl<$Res>
    extends _$ChatConversationModelCopyWithImpl<$Res,
        _$ChatConversationModelImpl>
    implements _$$ChatConversationModelImplCopyWith<$Res> {
  __$$ChatConversationModelImplCopyWithImpl(_$ChatConversationModelImpl _value,
      $Res Function(_$ChatConversationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? contextId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? createdBy = freezed,
    Object? creator = freezed,
    Object? myRole = freezed,
    Object? participants = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ChatConversationModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      contextId: freezed == contextId
          ? _value.contextId
          : contextId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as int?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as ChatUserModel?,
      myRole: freezed == myRole
          ? _value.myRole
          : myRole // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: freezed == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<ChatUserModel>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatConversationModelImpl implements _ChatConversationModel {
  const _$ChatConversationModelImpl(
      {this.id,
      this.type,
      @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
      this.contextId,
      this.name,
      this.description,
      this.image,
      @JsonKey(name: 'created_by', fromJson: _flexibleIntFromJson)
      this.createdBy,
      this.creator,
      @JsonKey(name: 'my_role') this.myRole,
      final List<ChatUserModel>? participants,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _participants = participants;

  factory _$ChatConversationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatConversationModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? type;
  @override
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  final int? contextId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? image;
  @override
  @JsonKey(name: 'created_by', fromJson: _flexibleIntFromJson)
  final int? createdBy;
  @override
  final ChatUserModel? creator;
  @override
  @JsonKey(name: 'my_role')
  final String? myRole;
  final List<ChatUserModel>? _participants;
  @override
  List<ChatUserModel>? get participants {
    final value = _participants;
    if (value == null) return null;
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'ChatConversationModel(id: $id, type: $type, contextId: $contextId, name: $name, description: $description, image: $image, createdBy: $createdBy, creator: $creator, myRole: $myRole, participants: $participants, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatConversationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.contextId, contextId) ||
                other.contextId == contextId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.myRole, myRole) || other.myRole == myRole) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      contextId,
      name,
      description,
      image,
      createdBy,
      creator,
      myRole,
      const DeepCollectionEquality().hash(_participants),
      createdAt,
      updatedAt);

  /// Create a copy of ChatConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatConversationModelImplCopyWith<_$ChatConversationModelImpl>
      get copyWith => __$$ChatConversationModelImplCopyWithImpl<
          _$ChatConversationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatConversationModelImplToJson(
      this,
    );
  }
}

abstract class _ChatConversationModel implements ChatConversationModel {
  const factory _ChatConversationModel(
          {final int? id,
          final String? type,
          @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
          final int? contextId,
          final String? name,
          final String? description,
          final String? image,
          @JsonKey(name: 'created_by', fromJson: _flexibleIntFromJson)
          final int? createdBy,
          final ChatUserModel? creator,
          @JsonKey(name: 'my_role') final String? myRole,
          final List<ChatUserModel>? participants,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt}) =
      _$ChatConversationModelImpl;

  factory _ChatConversationModel.fromJson(Map<String, dynamic> json) =
      _$ChatConversationModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get type;
  @override
  @JsonKey(name: 'context_id', fromJson: _flexibleIntFromJson)
  int? get contextId;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get image;
  @override
  @JsonKey(name: 'created_by', fromJson: _flexibleIntFromJson)
  int? get createdBy;
  @override
  ChatUserModel? get creator;
  @override
  @JsonKey(name: 'my_role')
  String? get myRole;
  @override
  List<ChatUserModel>? get participants;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of ChatConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatConversationModelImplCopyWith<_$ChatConversationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChatConversationEnvelopeModelResponse
    _$ChatConversationEnvelopeModelResponseFromJson(Map<String, dynamic> json) {
  return _ChatConversationEnvelopeModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatConversationEnvelopeModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  ChatConversationModel? get data => throw _privateConstructorUsedError;

  /// Serializes this ChatConversationEnvelopeModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatConversationEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatConversationEnvelopeModelResponseCopyWith<
          ChatConversationEnvelopeModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatConversationEnvelopeModelResponseCopyWith<$Res> {
  factory $ChatConversationEnvelopeModelResponseCopyWith(
          ChatConversationEnvelopeModelResponse value,
          $Res Function(ChatConversationEnvelopeModelResponse) then) =
      _$ChatConversationEnvelopeModelResponseCopyWithImpl<$Res,
          ChatConversationEnvelopeModelResponse>;
  @useResult
  $Res call({bool? value, String? message, ChatConversationModel? data});

  $ChatConversationModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$ChatConversationEnvelopeModelResponseCopyWithImpl<$Res,
        $Val extends ChatConversationEnvelopeModelResponse>
    implements $ChatConversationEnvelopeModelResponseCopyWith<$Res> {
  _$ChatConversationEnvelopeModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatConversationEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatConversationModel?,
    ) as $Val);
  }

  /// Create a copy of ChatConversationEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatConversationModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ChatConversationModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatConversationEnvelopeModelResponseImplCopyWith<$Res>
    implements $ChatConversationEnvelopeModelResponseCopyWith<$Res> {
  factory _$$ChatConversationEnvelopeModelResponseImplCopyWith(
          _$ChatConversationEnvelopeModelResponseImpl value,
          $Res Function(_$ChatConversationEnvelopeModelResponseImpl) then) =
      __$$ChatConversationEnvelopeModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, ChatConversationModel? data});

  @override
  $ChatConversationModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ChatConversationEnvelopeModelResponseImplCopyWithImpl<$Res>
    extends _$ChatConversationEnvelopeModelResponseCopyWithImpl<$Res,
        _$ChatConversationEnvelopeModelResponseImpl>
    implements _$$ChatConversationEnvelopeModelResponseImplCopyWith<$Res> {
  __$$ChatConversationEnvelopeModelResponseImplCopyWithImpl(
      _$ChatConversationEnvelopeModelResponseImpl _value,
      $Res Function(_$ChatConversationEnvelopeModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatConversationEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ChatConversationEnvelopeModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatConversationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatConversationEnvelopeModelResponseImpl
    implements _ChatConversationEnvelopeModelResponse {
  const _$ChatConversationEnvelopeModelResponseImpl(
      {this.value, this.message, this.data});

  factory _$ChatConversationEnvelopeModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChatConversationEnvelopeModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  @override
  final ChatConversationModel? data;

  @override
  String toString() {
    return 'ChatConversationEnvelopeModelResponse(value: $value, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatConversationEnvelopeModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, message, data);

  /// Create a copy of ChatConversationEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatConversationEnvelopeModelResponseImplCopyWith<
          _$ChatConversationEnvelopeModelResponseImpl>
      get copyWith => __$$ChatConversationEnvelopeModelResponseImplCopyWithImpl<
          _$ChatConversationEnvelopeModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatConversationEnvelopeModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatConversationEnvelopeModelResponse
    implements ChatConversationEnvelopeModelResponse {
  const factory _ChatConversationEnvelopeModelResponse(
          {final bool? value,
          final String? message,
          final ChatConversationModel? data}) =
      _$ChatConversationEnvelopeModelResponseImpl;

  factory _ChatConversationEnvelopeModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$ChatConversationEnvelopeModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  ChatConversationModel? get data;

  /// Create a copy of ChatConversationEnvelopeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatConversationEnvelopeModelResponseImplCopyWith<
          _$ChatConversationEnvelopeModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AblyTokenRequestModel _$AblyTokenRequestModelFromJson(
    Map<String, dynamic> json) {
  return _AblyTokenRequestModel.fromJson(json);
}

/// @nodoc
mixin _$AblyTokenRequestModel {
  String? get keyName => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get ttl => throw _privateConstructorUsedError;
  String? get capability => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get timestamp => throw _privateConstructorUsedError;
  String? get nonce => throw _privateConstructorUsedError;
  String? get mac => throw _privateConstructorUsedError;

  /// Serializes this AblyTokenRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AblyTokenRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AblyTokenRequestModelCopyWith<AblyTokenRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AblyTokenRequestModelCopyWith<$Res> {
  factory $AblyTokenRequestModelCopyWith(AblyTokenRequestModel value,
          $Res Function(AblyTokenRequestModel) then) =
      _$AblyTokenRequestModelCopyWithImpl<$Res, AblyTokenRequestModel>;
  @useResult
  $Res call(
      {String? keyName,
      @JsonKey(fromJson: _flexibleIntFromJson) int? ttl,
      String? capability,
      String? clientId,
      @JsonKey(fromJson: _flexibleIntFromJson) int? timestamp,
      String? nonce,
      String? mac});
}

/// @nodoc
class _$AblyTokenRequestModelCopyWithImpl<$Res,
        $Val extends AblyTokenRequestModel>
    implements $AblyTokenRequestModelCopyWith<$Res> {
  _$AblyTokenRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AblyTokenRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyName = freezed,
    Object? ttl = freezed,
    Object? capability = freezed,
    Object? clientId = freezed,
    Object? timestamp = freezed,
    Object? nonce = freezed,
    Object? mac = freezed,
  }) {
    return _then(_value.copyWith(
      keyName: freezed == keyName
          ? _value.keyName
          : keyName // ignore: cast_nullable_to_non_nullable
              as String?,
      ttl: freezed == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int?,
      capability: freezed == capability
          ? _value.capability
          : capability // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      nonce: freezed == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String?,
      mac: freezed == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AblyTokenRequestModelImplCopyWith<$Res>
    implements $AblyTokenRequestModelCopyWith<$Res> {
  factory _$$AblyTokenRequestModelImplCopyWith(
          _$AblyTokenRequestModelImpl value,
          $Res Function(_$AblyTokenRequestModelImpl) then) =
      __$$AblyTokenRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? keyName,
      @JsonKey(fromJson: _flexibleIntFromJson) int? ttl,
      String? capability,
      String? clientId,
      @JsonKey(fromJson: _flexibleIntFromJson) int? timestamp,
      String? nonce,
      String? mac});
}

/// @nodoc
class __$$AblyTokenRequestModelImplCopyWithImpl<$Res>
    extends _$AblyTokenRequestModelCopyWithImpl<$Res,
        _$AblyTokenRequestModelImpl>
    implements _$$AblyTokenRequestModelImplCopyWith<$Res> {
  __$$AblyTokenRequestModelImplCopyWithImpl(_$AblyTokenRequestModelImpl _value,
      $Res Function(_$AblyTokenRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AblyTokenRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyName = freezed,
    Object? ttl = freezed,
    Object? capability = freezed,
    Object? clientId = freezed,
    Object? timestamp = freezed,
    Object? nonce = freezed,
    Object? mac = freezed,
  }) {
    return _then(_$AblyTokenRequestModelImpl(
      keyName: freezed == keyName
          ? _value.keyName
          : keyName // ignore: cast_nullable_to_non_nullable
              as String?,
      ttl: freezed == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int?,
      capability: freezed == capability
          ? _value.capability
          : capability // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      nonce: freezed == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String?,
      mac: freezed == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AblyTokenRequestModelImpl implements _AblyTokenRequestModel {
  const _$AblyTokenRequestModelImpl(
      {this.keyName,
      @JsonKey(fromJson: _flexibleIntFromJson) this.ttl,
      this.capability,
      this.clientId,
      @JsonKey(fromJson: _flexibleIntFromJson) this.timestamp,
      this.nonce,
      this.mac});

  factory _$AblyTokenRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AblyTokenRequestModelImplFromJson(json);

  @override
  final String? keyName;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? ttl;
  @override
  final String? capability;
  @override
  final String? clientId;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  final int? timestamp;
  @override
  final String? nonce;
  @override
  final String? mac;

  @override
  String toString() {
    return 'AblyTokenRequestModel(keyName: $keyName, ttl: $ttl, capability: $capability, clientId: $clientId, timestamp: $timestamp, nonce: $nonce, mac: $mac)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AblyTokenRequestModelImpl &&
            (identical(other.keyName, keyName) || other.keyName == keyName) &&
            (identical(other.ttl, ttl) || other.ttl == ttl) &&
            (identical(other.capability, capability) ||
                other.capability == capability) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.mac, mac) || other.mac == mac));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, keyName, ttl, capability, clientId, timestamp, nonce, mac);

  /// Create a copy of AblyTokenRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AblyTokenRequestModelImplCopyWith<_$AblyTokenRequestModelImpl>
      get copyWith => __$$AblyTokenRequestModelImplCopyWithImpl<
          _$AblyTokenRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AblyTokenRequestModelImplToJson(
      this,
    );
  }
}

abstract class _AblyTokenRequestModel implements AblyTokenRequestModel {
  const factory _AblyTokenRequestModel(
      {final String? keyName,
      @JsonKey(fromJson: _flexibleIntFromJson) final int? ttl,
      final String? capability,
      final String? clientId,
      @JsonKey(fromJson: _flexibleIntFromJson) final int? timestamp,
      final String? nonce,
      final String? mac}) = _$AblyTokenRequestModelImpl;

  factory _AblyTokenRequestModel.fromJson(Map<String, dynamic> json) =
      _$AblyTokenRequestModelImpl.fromJson;

  @override
  String? get keyName;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get ttl;
  @override
  String? get capability;
  @override
  String? get clientId;
  @override
  @JsonKey(fromJson: _flexibleIntFromJson)
  int? get timestamp;
  @override
  String? get nonce;
  @override
  String? get mac;

  /// Create a copy of AblyTokenRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AblyTokenRequestModelImplCopyWith<_$AblyTokenRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
