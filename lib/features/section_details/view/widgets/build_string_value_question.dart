import '../../../../exports.dart';

class BuildStringValueQuestions extends StatelessWidget {
  final List<BaseQuestionModel> questionList;
  final int index;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  const BuildStringValueQuestions({
    super.key,
    required this.questionList,
    required this.index,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var keyboardType = questionList[index].keyboardType;
    return CustomTextFormField(
      title: 'Answer here',
      textInputType: keyboardType == 'number'
          ? TextInputType.phone
          : keyboardType == 'email'
              ? TextInputType.emailAddress
              : keyboardType == 'date'
                  ? TextInputType.datetime
                  : TextInputType.text,
      textInputAction: TextInputAction.next,
      initialValue: questionList[index].answer,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
