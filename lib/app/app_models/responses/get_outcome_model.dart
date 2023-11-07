import '../../../exports.dart';

part 'get_outcome_model.g.dart';

@JsonSerializable()
class GetOutcomeModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  GetOutcomeDataModelResponse? getOutcomeDataModelResponse;

  GetOutcomeModelResponse({
    this.getOutcomeDataModelResponse,
  });

  factory GetOutcomeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOutcomeModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetOutcomeModelResponseToJson(this);
}

@JsonSerializable()
class GetOutcomeDataModelResponse {
  @JsonKey(name: 'doctor_id')
  int? doctorId;
  @JsonKey(name: 'outcome_of_the_patient')
  String? outcomeOfThePatient;
  @JsonKey(name: 'creatinine_on_discharge')
  String? creatinineOnDischarge;
  @JsonKey(name: 'final_status')
  String? finalStatus;
  @JsonKey(name: 'other')
  String? other;
  @JsonKey(name: 'update_at')
  String? updateAt;
  @JsonKey(name: 'doctor')
  BaseDoctorModel? baseDoctorModel;

  GetOutcomeDataModelResponse({
    this.doctorId,
    this.outcomeOfThePatient,
    this.creatinineOnDischarge,
    this.finalStatus,
    this.other,
    this.updateAt,
    this.baseDoctorModel,
  });

  factory GetOutcomeDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOutcomeDataModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetOutcomeDataModelResponseToJson(this);
}
