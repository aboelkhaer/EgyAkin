// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_response_of_search_model.freezed.dart';
part 'get_response_of_search_model.g.dart';

@freezed
class GetResponseOfSearchModel with _$GetResponseOfSearchModel {
  const factory GetResponseOfSearchModel({
    GetPostsCommunityDataModelResponse? data,
  }) = _GetResponseOfSearchModel;
  factory GetResponseOfSearchModel.fromJson(Map<String, dynamic> json) =>
      _$GetResponseOfSearchModelFromJson(json);
}
