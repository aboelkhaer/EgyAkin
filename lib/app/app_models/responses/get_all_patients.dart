import '../../../exports.dart';

part 'get_all_patients.g.dart';

@JsonSerializable()
class GetAllBasPatientstModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<BasePatientModel>? basePatientList;

  GetAllBasPatientstModelResponse({
    this.basePatientList,
  });

  factory GetAllBasPatientstModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllBasPatientstModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetAllBasPatientstModelResponseToJson(this);
}
