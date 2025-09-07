import '../../../../exports.dart'; // Ensure this is correctly imported

class CreatePollScreen extends StatefulWidget {
  final Function(PollModel) onPollCreated;
  final int initialOptionCount;
  final PollModel? existingPoll;

  const CreatePollScreen({
    super.key,
    required this.onPollCreated,
    this.initialOptionCount = 2,
    this.existingPoll,
  });

  @override
  _CreatePollScreenState createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  bool _allowMultipleChoices = false;
  bool _allowAddOptions = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingPoll != null) {
      _questionController.text = widget.existingPoll!.question ?? '';
      _allowMultipleChoices =
          widget.existingPoll!.allowMultipleChoices ?? false;
      _allowAddOptions = widget.existingPoll!.allowAddOptions ?? false;
      for (var option in widget.existingPoll!.options ?? []) {
        _optionControllers.add(TextEditingController(text: option));
      }
    } else {
      for (int i = 0; i < widget.initialOptionCount; i++) {
        _optionControllers.add(TextEditingController());
      }
    }
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _removeOption(int index) {
    if (index >= 0 && index < _optionControllers.length) {
      setState(() {
        _optionControllers
            .removeAt(index); // Remove the controller at the specified index
      });
    }
  }

  void _submitPoll() {
    if (_formKey.currentState!.validate()) {
      final poll = PollModel(
        question: _questionController.text,
        options:
            _optionControllers.map((controller) => controller.text).toList(),
        allowMultipleChoices: _allowMultipleChoices,
        allowAddOptions: _allowAddOptions,
      );

      widget.onPollCreated(poll);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.tr(AppStrings.createPoll)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _submitPoll,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Field (Optional)
                CustomTextFormField(
                  title: context.tr(AppStrings.askAQuestion),
                  textFormFieldController: _questionController,
                  textInputType: TextInputType.text,
                  validator: (value) => null,
                  maxLength: 200,
                ),
                const SizedBox(height: 20),

                // Options Title
                 Text(
                  context.tr(AppStrings.options),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Render Options
                Column(
                  children: List.generate(
                    _optionControllers.length,
                    (index) => Padding(
                      key: ValueKey(_optionControllers[
                          index]), // Unique key for each widget
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              key: ValueKey(
                                  'option_$index'), // Unique key for each CustomTextFormField
                              title: '${context.tr(AppStrings.option)} ${index + 1}',
                              textFormFieldController:
                                  _optionControllers[index],
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr(AppStrings.pleaseEnterAnOption);
                                }
                                return null;
                              },
                            ),
                          ),
                          if (_optionControllers.length > 2)
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () => _removeOption(index),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Add Another Option Button
                TextButton(
                  onPressed: _addOption,
                  child:  Text('+ ${context.tr(AppStrings.addAnotherOption)}'),
                ),
                const SizedBox(height: 20),

                // Settings Section
                 Text(
                  context.tr(AppStrings.settings),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                SwitchListTile(
                  title:  Text(
                    context.tr(AppStrings.allowAddOptions),
                  ),
                  value: _allowAddOptions,
                  onChanged: (value) {
                    setState(() {
                      _allowAddOptions = value;
                    });
                  },
                ),
                SwitchListTile(
                  title:  Text(
                    context.tr(AppStrings.allowMultipleChoices),
                  ),
                  value: _allowMultipleChoices,
                  onChanged: (value) {
                    setState(() {
                      _allowMultipleChoices = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
