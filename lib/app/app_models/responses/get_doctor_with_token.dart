import '../../../exports.dart';

part 'get_doctor_with_token.g.dart';

@JsonSerializable()
class GetDoctorWithTokenModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  DoctorModel? doctorModel;
  @JsonKey(name: 'token')
  String? token;

  GetDoctorWithTokenModelResponse({
    this.doctorModel,
    this.token,
  });

  factory GetDoctorWithTokenModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDoctorWithTokenModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetDoctorWithTokenModelResponseToJson(this);
}
