import '../../../../exports.dart';

class BuildSectionDetailsIfFinalSubmitTrue extends StatelessWidget {
  const BuildSectionDetailsIfFinalSubmitTrue({
    super.key,
    required SectionDetailsController controller,
  }) : _controller = controller;

  final SectionDetailsController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isSectionDetailsLoading.value
          ? const SingleChildScrollView(
              child: ShimmerLoadingPatientsCards(ishorizontal: false))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _controller.questionModelList!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var question = _controller.questionModelList![index];
                      return Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    '${index + 1} - ${question.question!}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    question.type ==
                                            AppStrings.questionTypeMultiple
                                        ? convertDynamicToString(question)
                                        : question.type ==
                                                AppStrings.questionTypeDate
                                            ? formatDateTime(question.answer)
                                            : question.question ==
                                                    AppStrings.nationalID
                                                ? hideNationalId(
                                                    question.answer)
                                                : question.answer ?? '...',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade900,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
