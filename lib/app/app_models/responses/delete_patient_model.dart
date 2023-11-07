import '../../../../exports.dart';

part 'delete_patient_model.g.dart';

@JsonSerializable()
class DeletePatientModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;

  DeletePatientModelResponse({
    this.message,
  });

  factory DeletePatientModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePatientModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeletePatientModelResponseToJson(this);
}
