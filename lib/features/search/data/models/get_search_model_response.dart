import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../exports.dart';
part 'get_search_model_response.freezed.dart';
part 'get_search_model_response.g.dart';

@freezed
class GetSearchModelResponse with _$GetSearchModelResponse {
  const factory GetSearchModelResponse({
    bool? value,
    List<PatientHomeDataModel>? data,
  }) = _GetSearchModelResponse;
  factory GetSearchModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSearchModelResponseFromJson(json);
}
