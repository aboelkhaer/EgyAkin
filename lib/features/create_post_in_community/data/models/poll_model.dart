// class PollModel {
//   final String question;
//   final List<String> options;
//   final bool allowMultipleChoices;
//   final bool allowAddOptions;

//   PollModel({
//     required this.question,
//     required this.options,
//     this.allowMultipleChoices = false,
//     this.allowAddOptions = false,
//   });
// }

// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'poll_model.freezed.dart';
part 'poll_model.g.dart';

@freezed
class PollModel with _$PollModel {
  const factory PollModel({
    String? question,
    List<String>? options,
    @JsonKey(name: 'allow_multiple_choice') bool? allowMultipleChoices,
    @JsonKey(name: 'allow_add_options') bool? allowAddOptions,
  }) = _PollModel;
  factory PollModel.fromJson(Map<String, dynamic> json) =>
      _$PollModelFromJson(json);
}
