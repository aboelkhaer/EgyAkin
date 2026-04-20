import '../../../../exports.dart';

class BuildSelectValueQuestion extends StatelessWidget {
  final List<QuestionModel> questionList;
  final int index;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onChangedForOtherField;
  final String? Function(dynamic)? validator;
  final dynamic selected;
  final bool isAddPatient;
  final Map<String, dynamic>? formData;
  final bool showAiFilledBanner;
  final VoidCallback? onClearAiFilledMark;

  const BuildSelectValueQuestion({
    super.key,
    required this.questionList,
    required this.validator,
    required this.selected,
    required this.index,
    required this.onChanged,
    required this.onChangedForOtherField,
    this.isAddPatient = false,
    this.formData,
    this.showAiFilledBanner = false,
    this.onClearAiFilledMark,
  });

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final menuMaxHeight = (screenH * 0.38).clamp(200.0, 380.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showAiFilledBanner) const AiFilledFieldBanner(),
        Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<dynamic>(
            menuMaxHeight: menuMaxHeight,
            hint: Text(isAddPatient
                ? (!formData!.containsKey(questionList[index].id.toString()) ||
                        formData![questionList[index].id.toString()]
                                ['answers'] ==
                            '' ||
                        formData![questionList[index].id.toString()]
                                ['answers'] ==
                            null
                    ? AppStrings.choose
                    : formData![questionList[index].id.toString()]['answers'])
                : (questionList[index].answer['answers'] == '' ||
                        questionList[index].answer['answers'] == null
                    ? context.tr(AppStrings.choose)
                    : questionList[index].answer['answers'])),
            validator: validator,
            value: selected,

            items: questionList[index].values!.map((value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),

            onChanged: (v) {
              onClearAiFilledMark?.call();
              onChanged?.call(v);
            },
            isExpanded: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),

            // decoration: const InputDecoration(label: Text('Choose')),
          ),
        ),
        isAddPatient
            ? (formData!.containsKey(questionList[index].id.toString()) &&
                    formData![questionList[index].id.toString()]['answers'] ==
                        'Others')
                ? Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(context.tr(AppStrings.yourOtherAnswer),
                              style: const TextStyle(
                                color: Colors.grey,
                              )),
                        ],
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        title: context.tr(AppStrings.answerHere),
                        initialValue: isAddPatient
                            ? (formData!.containsKey(
                                    questionList[index].id.toString())
                                ? formData![questionList[index].id.toString()]
                                    ['other_field']
                                : '')
                            : questionList[index].answer['other_field'],
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: validator,
                        onChanged: (v) {
                          onClearAiFilledMark?.call();
                          onChangedForOtherField?.call(v);
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink()
            : questionList[index].answer['answers'] == 'Others'
                ? Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(context.tr(AppStrings.yourOtherAnswer),
                              style: const TextStyle(
                                color: Colors.grey,
                              )),
                        ],
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        title: context.tr(AppStrings.answerHere),
                        initialValue: questionList[index].answer['other_field'],
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: validator,
                        onChanged: (v) {
                          onClearAiFilledMark?.call();
                          onChangedForOtherField?.call(v);
                        },
                      )
                    ],
                  )
                : const SizedBox.shrink(),
      ],
    );
  }
}
