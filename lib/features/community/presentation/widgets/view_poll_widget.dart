import 'package:egy_akin/features/poll_voters/presentation/cubit/poll_voters_cubit.dart';
import 'package:egy_akin/features/poll_voters/presentation/pages/poll_voters_screen.dart';

import '../../../../exports.dart';

class ViewPollWidget extends StatefulWidget {
  final PollModelResponse? poll;
  final Set<int> selectedOptions;
  final int? selectedOption;
  final Function(int? optionId) onOptionSelected;
  final Function(int optionId, bool isSelected) onOptionToggled;
  final bool initiallyExpanded;
  final Function(String pollId, String option)? onAddOption;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const ViewPollWidget({
    super.key,
    required this.poll,
    required this.selectedOptions,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.onOptionToggled,
    this.initiallyExpanded = false,
    this.onAddOption,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  _ViewPollWidgetState createState() => _ViewPollWidgetState();
}

class _ViewPollWidgetState extends State<ViewPollWidget> {
  late bool showAllOptions;
  final TextEditingController _newOptionController = TextEditingController();
  bool _isAddingOption = false;

  @override
  void initState() {
    super.initState();
    showAllOptions = widget.initiallyExpanded;
  }

  void _addNewOption() async {
    if (_newOptionController.text.isEmpty) return;

    setState(() {
      _isAddingOption = true;
    });

    await widget.onAddOption!(
        widget.poll!.id.toString(), _newOptionController.text);

    setState(() {
      _isAddingOption = false;
      _newOptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.poll == null) {
      return const SizedBox.shrink();
    }

    final optionsList = widget.poll!.options!;
    final optionsToShow =
        showAllOptions ? optionsList : optionsList.take(2).toList();

    return GestureDetector(
      onTap: () {
        setState(() {
          showAllOptions = !showAllOptions;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poll Header
                const Text(
                  'Poll',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),

                // Poll Question
                if (widget.poll?.question?.isNotEmpty ?? false)
                  Text(
                    widget.poll!.question!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                if (widget.poll?.question?.isNotEmpty ?? false)
                  const SizedBox(height: 16),

                // Poll Options
                ...optionsToShow.map((option) {
                  final totalVotes = optionsList.fold(
                      0, (sum, opt) => sum + (opt.votesCount ?? 0));
                  final votePercentage = totalVotes > 0
                      ? (option.votesCount ?? 0) / totalVotes
                      : 0.0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Checkbox for multiple choice, Radio for single choice
                            if (widget.poll?.allowMultipleChoice ?? false)
                              Checkbox(
                                value:
                                    widget.selectedOptions.contains(option.id),
                                onChanged: (bool? value) {
                                  widget.onOptionToggled(
                                      option.id!, value ?? false);
                                },
                                activeColor: AppColors.primary,
                              )
                            else
                              Radio<int>(
                                value: option.id!,
                                groupValue: widget.selectedOption,
                                onChanged: widget.onOptionSelected,
                                activeColor: AppColors.primary,
                              ),
                            const SizedBox(width: 8),

                            // Option Text
                            Expanded(
                              child: Text(
                                option.optionText ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),

                            // Clickable Vote Count
                            GestureDetector(
                              onTap: option.votesCount! > 0
                                  ? () {
                                      showCustomBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return BlocProvider(
                                            create: (context) =>
                                                PollVotersCubit(sl()),
                                            child: PollVotersScreen(
                                              pollId:
                                                  widget.poll!.id.toString(),
                                              optionId: option.id.toString(),
                                              currentDoctorModel:
                                                  widget.currentDoctorModel,
                                              homeDataModel:
                                                  widget.homeDataModel,
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  : () {},
                              child: Text(
                                '${option.votesCount ?? 0}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: option.votesCount! > 0
                                      ? AppColors.primary
                                      : Colors
                                          .grey.shade500, // Make it stand out
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Progress Bar for votes
                        LinearProgressIndicator(
                          value: votePercentage,
                          backgroundColor: Colors.grey.shade300,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  );
                }),

                // Add New Option Input
                if ((widget.poll?.allowAddOptions ?? false) &&
                    (optionsList.length == 2 || showAllOptions))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            title: 'Add a new option',
                            textFormFieldController: _newOptionController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an option';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Show loading indicator when adding a new option
                        _isAddingOption
                            ? IconButton(
                                color: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: _addNewOption,
                              ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),

                // Show "See More" if more than 2 options
                if (optionsList.length > 2)
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllOptions = !showAllOptions;
                        });
                      },
                      child: Text(
                        showAllOptions ? 'See Less' : 'See More',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
