import '../../../../exports.dart';

class OTPRow extends StatelessWidget {
  final Key formKey;
  final FocusNode? firstOTPFocusNode;
  final Function(String) firstOTPOnChanged;
  final Function(String) secondOTPOnChanged;
  final Function(String) thirdOTPOnChanged;
  final Function(String) fourthOTPOnChanged;
  final String? Function(String?) firstOTPValidator;
  final String? Function(String?) secondOTPValidator;
  final String? Function(String?) thirdOTPValidator;
  final String? Function(String?) fourthOTPValidator;

  const OTPRow(
      {super.key,
      required this.formKey,
      this.firstOTPFocusNode,
      required this.firstOTPOnChanged,
      required this.secondOTPOnChanged,
      required this.thirdOTPOnChanged,
      required this.fourthOTPOnChanged,
      required this.firstOTPValidator,
      required this.secondOTPValidator,
      required this.thirdOTPValidator,
      required this.fourthOTPValidator});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 70,
            width: 60,
            child: CustomTextFormField(
              title: '',
              textInputType: TextInputType.number,
              isOTP: true,
              autoFocus: true,
              focusNode: firstOTPFocusNode,
              onSave: (pin1) {},
              onChanged: firstOTPOnChanged,
              validator: firstOTPValidator,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 70,
            width: 60,
            child: CustomTextFormField(
              title: '',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSave: (pin2) {},
              isOTP: true,
              onChanged: secondOTPOnChanged,
              validator: secondOTPValidator,
              // autoFocus: true,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 70,
            width: 60,
            child: CustomTextFormField(
              title: '',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSave: (pin3) {},
              isOTP: true,
              onChanged: thirdOTPOnChanged,
              validator: thirdOTPValidator,
              // autoFocus: true,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 70,
            width: 60,
            child: CustomTextFormField(
              title: '',
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSave: (pin4) {},
              isOTP: true,
              onChanged: fourthOTPOnChanged,
              validator: fourthOTPValidator,
              // autoFocus: true,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
