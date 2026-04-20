import '../../../exports.dart';

class BuildStringValueQuestions extends StatelessWidget {
  final List<QuestionModel> questionList;
  final int index;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final List<TextInputFormatter>? textInputFormatter;
  final bool showAiFilledBanner;
  final VoidCallback? onClearAiFilledMark;

  const BuildStringValueQuestions({
    super.key,
    required this.questionList,
    required this.index,
    this.initialValue,
    required this.onChanged,
    required this.validator,
    this.textInputFormatter,
    this.showAiFilledBanner = false,
    this.onClearAiFilledMark,
  });

  @override
  Widget build(BuildContext context) {
    var keyboardType = questionList[index].keyboardType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showAiFilledBanner) const AiFilledFieldBanner(),
        CustomTextFormField(
          title: context.tr(AppStrings.answerHere),
          textInputType: keyboardType == 'number'
              ? TextInputType.phone
              : keyboardType == 'email'
                  ? TextInputType.emailAddress
                  : keyboardType == 'date'
                      ? TextInputType.datetime
                      : TextInputType.text,
          textInputAction: TextInputAction.next,
          inputFormatters: textInputFormatter,
          initialValue: initialValue,
          validator: validator,
          onChanged: (v) {
            onClearAiFilledMark?.call();
            onChanged(v);
          },
        ),
      ],
    );
  }
}
