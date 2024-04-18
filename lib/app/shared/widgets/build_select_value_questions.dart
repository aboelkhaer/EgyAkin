import '../../../../exports.dart';

class BuildSelectValueQuestion extends StatelessWidget {
  final List<QuestionModel> questionList;
  final int index;
  final Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final dynamic selected;

  const BuildSelectValueQuestion({
    super.key,
    required this.questionList,
    required this.validator,
    required this.selected,
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<dynamic>(
        hint: Text(questionList[index].answer ?? 'Choose'),
        validator: validator,
        value: selected,

        items: questionList[index].values!.map((value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),

        onChanged: onChanged,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        // decoration: const InputDecoration(label: Text('Choose')),
      ),
    );
  }
}
