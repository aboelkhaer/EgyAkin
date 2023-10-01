import 'package:json_annotation/json_annotation.dart';

part 'patient_home_model.g.dart';

@JsonSerializable()
class PatientHomeModelResponse {
  @JsonKey(name: 'value')
  bool? value;
  @JsonKey(name: 'data')
  List<PatientHomeModel>? patientHomeModel;

  PatientHomeModelResponse({
    this.value,
    this.patientHomeModel,
  });

  factory PatientHomeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientHomeModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PatientHomeModelResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class PatientHomeModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'owner_id')
  int? ownerId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'hospital')
  String? hospital;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  PatientHomeModel({
    this.id,
    this.ownerId,
    this.name,
    this.hospital,
    this.createdAt,
    this.updatedAt,
  });
  factory PatientHomeModel.fromJson(Map<String, dynamic> json) =>
      _$PatientHomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientHomeModelToJson(this);
}
