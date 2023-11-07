import '../../../exports.dart';

part 'base_question_model.g.dart';

@JsonSerializable(includeIfNull: true)
class BaseQuestionModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'question')
  String? question;
  @JsonKey(name: 'values')
  List<dynamic>? values;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'keyboard_type')
  String? keyboardType;
  @JsonKey(name: 'mandatory')
  bool? mandatory;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'answer')
  dynamic answer;

  BaseQuestionModel({
    this.id,
    this.question,
    this.values,
    this.type,
    this.keyboardType,
    this.mandatory,
    this.updatedAt,
    this.answer,
  });
  factory BaseQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$BaseQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseQuestionModelToJson(this);
}
