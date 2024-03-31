// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_model_response.freezed.dart';
part 'authentication_model_response.g.dart';

@freezed
class AuthenticationModelResponse with _$AuthenticationModelResponse {
  const factory AuthenticationModelResponse({
    bool? value,
    String? token,
    @JsonKey(name: 'data') DoctorModel? doctorModel,
  }) = _AuthenticationModelResponse;
  factory AuthenticationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationModelResponseFromJson(json);
}

@freezed
class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
    int? id,
    @JsonKey(name: 'name') String? firstName,
    @JsonKey(name: 'lname') String? lastName,
    String? email,
    String? age,
    String? specialty,
    String? token,
    String? password,
    String? workingplace,
    String? phone,
    String? job,
    String? gender,
    String? image,
    @JsonKey(name: 'password_confirmation') String? passwordConfirmation,
    @JsonKey(name: 'syndicate_card') String? syndicateCard,
    String? highestdegree,
    @JsonKey(name: 'registration_number') String? registrationNumber,
    @JsonKey(name: 'email_verified_at') String? emailVerifiedAt,
    bool? blocked,
    bool? limited,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _DoctorModel;
  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);
}
