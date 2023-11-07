import '../../../exports.dart';

part 'get_doctor_model.g.dart';

@JsonSerializable()
class GetDoctorModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  DoctorModel? doctorModel;

  GetDoctorModelResponse({
    this.doctorModel,
  });

  factory GetDoctorModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDoctorModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetDoctorModelResponseToJson(this);
}
