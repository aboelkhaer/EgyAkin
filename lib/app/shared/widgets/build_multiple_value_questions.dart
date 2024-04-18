import '../../../exports.dart';

class BuildMultipleValueQuestion extends StatelessWidget {
  final List<QuestionModel> questionList;
  final int index;
  final List<Widget> children;
  final String? Function(String?)? validator;
  final String initialValue;
  final Function(String)? onChanged;
  final List<dynamic> listContainOther;

  const BuildMultipleValueQuestion({
    super.key,
    required this.questionList,
    required this.index,
    required this.onChanged,
    required this.initialValue,
    required this.validator,
    required this.children,
    required this.listContainOther,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.center,
          children: children,
        ),
        const SizedBox(height: 16),
        listContainOther.contains('Others') ||
                listContainOther.contains('Other')
            ? CustomTextFormField(
                title: 'Answer here',
                initialValue: initialValue,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: validator,
                onChanged: onChanged,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
