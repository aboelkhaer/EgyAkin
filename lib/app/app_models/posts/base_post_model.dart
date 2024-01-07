import '../../../exports.dart';

part 'base_post_model.g.dart';

@JsonSerializable(includeIfNull: true)
class BasePostModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'hidden')
  bool? hidden;
  @JsonKey(name: 'doctor_id')
  String? doctorId;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'doctor')
  BaseDoctorModel? baseDoctorModel;

  BasePostModel({
    this.id,
    this.title,
    this.content,
    this.image,
    this.hidden,
    this.doctorId,
    this.updatedAt,
    this.baseDoctorModel,
  });
  factory BasePostModel.fromJson(Map<String, dynamic> json) =>
      _$BasePostModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasePostModelToJson(this);
}
