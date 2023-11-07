import '../../../exports.dart';

part 'base_comment_model.g.dart';

@JsonSerializable(includeIfNull: true)
class BaseCommentModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'doctor')
  BaseDoctorModel? baseDoctorModel;

  BaseCommentModel({
    this.id,
    this.content,
    this.updatedAt,
    this.baseDoctorModel,
  });
  factory BaseCommentModel.fromJson(Map<String, dynamic> json) =>
      _$BaseCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseCommentModelToJson(this);
}
