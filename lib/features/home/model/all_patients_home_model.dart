import 'package:json_annotation/json_annotation.dart';

part 'all_patients_home_model.g.dart';

@JsonSerializable()
class AllPatientHomeModelResponse {
  @JsonKey(name: 'value')
  bool? value;
  @JsonKey(name: 'data')
  List<AllPatientHomeModel>? allPatientHomeModel;

  AllPatientHomeModelResponse({
    this.value,
    this.allPatientHomeModel,
  });

  factory AllPatientHomeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPatientHomeModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllPatientHomeModelResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class AllPatientHomeModel {
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
  @JsonKey(name: 'owner')
  OwnerModel? ownerModel;

  AllPatientHomeModel({
    this.id,
    this.ownerId,
    this.name,
    this.hospital,
    this.createdAt,
    this.updatedAt,
    this.ownerModel,
  });
  factory AllPatientHomeModel.fromJson(Map<String, dynamic> json) =>
      _$AllPatientHomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllPatientHomeModelToJson(this);
}

@JsonSerializable(includeIfNull: true)
class OwnerModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'lname')
  String? lastName;

  OwnerModel({
    this.id,
    this.name,
    this.lastName,
  });
  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);
}
