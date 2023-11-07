import '../../../exports.dart';

part 'semi_patient_model.g.dart';

@JsonSerializable()
class SemiPatientModel extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'doctor_id')
  int? doctorId;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'submit_status')
  bool? submitStatus;

  SemiPatientModel({
    this.id,
    this.name,
    this.doctorId,
    this.message,
    this.submitStatus,
  });

  factory SemiPatientModel.fromJson(Map<String, dynamic> json) =>
      _$SemiPatientModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SemiPatientModelToJson(this);
}
