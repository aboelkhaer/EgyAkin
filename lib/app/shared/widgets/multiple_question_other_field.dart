import '../../../exports.dart';

/// "Others" free-text field for multiple-choice questions.
/// Keeps [TextEditingController] in sync when [initialValue] arrives after load.
class MultipleQuestionOtherField extends StatefulWidget {
  final String initialValue;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClearAiFilledMark;

  const MultipleQuestionOtherField({
    super.key,
    required this.initialValue,
    this.validator,
    this.onChanged,
    this.onClearAiFilledMark,
  });

  @override
  State<MultipleQuestionOtherField> createState() =>
      _MultipleQuestionOtherFieldState();
}

class _MultipleQuestionOtherFieldState extends State<MultipleQuestionOtherField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _applyInitialValueIfNeeded();
  }

  @override
  void didUpdateWidget(MultipleQuestionOtherField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _applyInitialValueIfNeeded();
  }

  void _applyInitialValueIfNeeded() {
    final value = widget.initialValue;
    if (value.isEmpty || value == _controller.text) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.initialValue.isNotEmpty &&
          widget.initialValue != _controller.text) {
        _controller.value = TextEditingValue(
          text: widget.initialValue,
          selection: TextSelection.collapsed(
            offset: widget.initialValue.length,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      title: context.tr(AppStrings.answerHere),
      textFormFieldController: _controller,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: widget.validator,
      onChanged: (value) {
        widget.onClearAiFilledMark?.call();
        widget.onChanged?.call(value);
      },
    );
  }
}
