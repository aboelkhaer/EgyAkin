import '../../../exports.dart';

part 'get_current_patient_model.g.dart';

@JsonSerializable()
class GetCurrentPatientstModelResponse extends BaseResponse {
  @JsonKey(name: 'score_value')
  String? scoreValue;
  @JsonKey(name: 'data')
  List<BasePatientModel>? basePatientList;

  GetCurrentPatientstModelResponse({
    this.basePatientList,
  });

  factory GetCurrentPatientstModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetCurrentPatientstModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetCurrentPatientstModelResponseToJson(this);
}
