import '../../../exports.dart';

part 'base_doctor_model.g.dart';

@JsonSerializable(includeIfNull: true)
class BaseDoctorModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? firstName;
  @JsonKey(name: 'lname')
  String? lastName;

  BaseDoctorModel({
    this.id,
    this.firstName,
    this.lastName,
  });
  factory BaseDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$BaseDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseDoctorModelToJson(this);
}
