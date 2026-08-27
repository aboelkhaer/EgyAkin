import '../../../../exports.dart';

/// Invisible marker so soft-keyboard backspace still fires [onChanged]
/// when the OTP box looks empty.
const String _otpMarker = '\u200b';

class OTPRow extends StatefulWidget {
  final Key formKey;
  final FocusNode? firstOTPFocusNode;
  final FocusNode? secondOTPFocusNode;
  final FocusNode? thirdOTPFocusNode;
  final FocusNode? fourthOTPFocusNode;
  final Function(String) firstOTPOnChanged;
  final Function(String) secondOTPOnChanged;
  final Function(String) thirdOTPOnChanged;
  final Function(String) fourthOTPOnChanged;
  final String? Function(String?) firstOTPValidator;
  final String? Function(String?) secondOTPValidator;
  final String? Function(String?) thirdOTPValidator;
  final String? Function(String?) fourthOTPValidator;

  const OTPRow({
    super.key,
    required this.formKey,
    this.firstOTPFocusNode,
    this.secondOTPFocusNode,
    this.thirdOTPFocusNode,
    this.fourthOTPFocusNode,
    required this.firstOTPOnChanged,
    required this.secondOTPOnChanged,
    required this.thirdOTPOnChanged,
    required this.fourthOTPOnChanged,
    required this.firstOTPValidator,
    required this.secondOTPValidator,
    required this.thirdOTPValidator,
    required this.fourthOTPValidator,
  });

  @override
  State<OTPRow> createState() => _OTPRowState();
}

class _OTPRowState extends State<OTPRow> {
  late final FocusNode _pin1Focus;
  late final FocusNode _pin2Focus;
  late final FocusNode _pin3Focus;
  late final FocusNode _pin4Focus;

  late final bool _ownsPin1;
  late final bool _ownsPin2;
  late final bool _ownsPin3;
  late final bool _ownsPin4;

  late final TextEditingController _pin1Controller;
  late final TextEditingController _pin2Controller;
  late final TextEditingController _pin3Controller;
  late final TextEditingController _pin4Controller;

  @override
  void initState() {
    super.initState();
    _ownsPin1 = widget.firstOTPFocusNode == null;
    _ownsPin2 = widget.secondOTPFocusNode == null;
    _ownsPin3 = widget.thirdOTPFocusNode == null;
    _ownsPin4 = widget.fourthOTPFocusNode == null;

    _pin1Focus = widget.firstOTPFocusNode ?? FocusNode();
    _pin2Focus = widget.secondOTPFocusNode ?? FocusNode();
    _pin3Focus = widget.thirdOTPFocusNode ?? FocusNode();
    _pin4Focus = widget.fourthOTPFocusNode ?? FocusNode();

    _pin1Controller = TextEditingController(text: _otpMarker);
    _pin2Controller = TextEditingController(text: _otpMarker);
    _pin3Controller = TextEditingController(text: _otpMarker);
    _pin4Controller = TextEditingController(text: _otpMarker);

    _attachFocusListener(_pin1Focus, _pin1Controller);
    _attachFocusListener(_pin2Focus, _pin2Controller);
    _attachFocusListener(_pin3Focus, _pin3Controller);
    _attachFocusListener(_pin4Focus, _pin4Controller);
  }

  void _attachFocusListener(
    FocusNode focus,
    TextEditingController controller,
  ) {
    focus.addListener(() {
      if (!focus.hasFocus) return;
      final digit = _digitOf(controller.text);
      controller.value = TextEditingValue(
        text: '$_otpMarker$digit',
        selection: TextSelection(
          baseOffset: 0,
          extentOffset: '$_otpMarker$digit'.length,
        ),
      );
    });
  }

  String _digitOf(String raw) => raw.replaceAll(_otpMarker, '');

  void _setMarked(
    TextEditingController controller, {
    required String digit,
  }) {
    final text = '$_otpMarker$digit';
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _handleChanged({
    required String value,
    required TextEditingController controller,
    required Function(String) onChanged,
    FocusNode? next,
    FocusNode? previous,
  }) {
    final cleaned = _digitOf(value);

    if (cleaned.isEmpty) {
      // Marker deleted (field looked empty) → move to previous.
      // Digit cleared but marker remains → stay on this field.
      final markerDeleted = value.isEmpty;
      _setMarked(controller, digit: '');
      onChanged('');
      if (markerDeleted) {
        previous?.requestFocus();
      }
      return;
    }

    final digit = cleaned.substring(cleaned.length - 1);
    _setMarked(controller, digit: digit);
    onChanged(digit);
    if (next != null) {
      next.requestFocus();
    } else {
      // Last OTP field filled — dismiss keyboard.
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  String? _wrapValidator(String? Function(String?) validator, String? value) {
    return validator(_digitOf(value ?? ''));
  }

  @override
  void dispose() {
    if (_ownsPin1) _pin1Focus.dispose();
    if (_ownsPin2) _pin2Focus.dispose();
    if (_ownsPin3) _pin3Focus.dispose();
    if (_ownsPin4) _pin4Focus.dispose();
    _pin1Controller.dispose();
    _pin2Controller.dispose();
    _pin3Controller.dispose();
    _pin4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _otpBox(
              controller: _pin1Controller,
              focusNode: _pin1Focus,
              autoFocus: true,
              onChanged: (value) => _handleChanged(
                value: value,
                controller: _pin1Controller,
                onChanged: widget.firstOTPOnChanged,
                next: _pin2Focus,
              ),
              validator: widget.firstOTPValidator,
            ),
            _otpBox(
              controller: _pin2Controller,
              focusNode: _pin2Focus,
              onChanged: (value) => _handleChanged(
                value: value,
                controller: _pin2Controller,
                onChanged: widget.secondOTPOnChanged,
                next: _pin3Focus,
                previous: _pin1Focus,
              ),
              validator: widget.secondOTPValidator,
            ),
            _otpBox(
              controller: _pin3Controller,
              focusNode: _pin3Focus,
              onChanged: (value) => _handleChanged(
                value: value,
                controller: _pin3Controller,
                onChanged: widget.thirdOTPOnChanged,
                next: _pin4Focus,
                previous: _pin2Focus,
              ),
              validator: widget.thirdOTPValidator,
            ),
            _otpBox(
              controller: _pin4Controller,
              focusNode: _pin4Focus,
              textInputAction: TextInputAction.done,
              onChanged: (value) => _handleChanged(
                value: value,
                controller: _pin4Controller,
                onChanged: widget.fourthOTPOnChanged,
                previous: _pin3Focus,
              ),
              validator: widget.fourthOTPValidator,
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox({
    required TextEditingController controller,
    required FocusNode focusNode,
    required Function(String) onChanged,
    required String? Function(String?) validator,
    bool autoFocus = false,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return SizedBox(
      height: 70,
      width: 60,
      child: CustomTextFormField(
        title: '',
        textFormFieldController: controller,
        textInputType: TextInputType.number,
        textInputAction: textInputAction,
        isOTP: true,
        autoFocus: autoFocus,
        focusNode: focusNode,
        onSave: (_) {},
        onChanged: onChanged,
        validator: (value) => _wrapValidator(validator, value),
        textAlign: TextAlign.center,
        // Marker + digit.
        maxLength: 2,
        style: Theme.of(context).textTheme.titleLarge,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[\d\u200b]')),
          LengthLimitingTextInputFormatter(2),
        ],
      ),
    );
  }
}
