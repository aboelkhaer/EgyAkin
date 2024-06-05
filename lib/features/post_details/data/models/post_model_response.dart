// ignore_for_file: invalid_annotation_target

import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_model_response.freezed.dart';
part 'post_model_response.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    int? id,
    String? title,
    String? content,
    String? image,
    bool? hidden,
    @JsonKey(name: 'updated_at') String? updatedAt,
    DoctorModel? doctor,
  }) = _PostModel;
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
