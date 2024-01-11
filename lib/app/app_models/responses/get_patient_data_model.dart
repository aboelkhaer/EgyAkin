import '../../../exports.dart';

part 'get_patient_data_model.g.dart';

@JsonSerializable()
class GetPatientDataModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  BasePatientModel? basePatientModel;

  GetPatientDataModelResponse({
    this.basePatientModel,
  });

  factory GetPatientDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPatientDataModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetPatientDataModelResponseToJson(this);
}
