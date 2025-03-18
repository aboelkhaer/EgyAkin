// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PollModelImpl _$$PollModelImplFromJson(Map<String, dynamic> json) =>
    _$PollModelImpl(
      question: json['question'] as String?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      allowMultipleChoices: json['allow_multiple_choice'] as bool?,
      allowAddOptions: json['allow_add_options'] as bool?,
    );

Map<String, dynamic> _$$PollModelImplToJson(_$PollModelImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'allow_multiple_choice': instance.allowMultipleChoices,
      'allow_add_options': instance.allowAddOptions,
    };
