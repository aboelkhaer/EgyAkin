import 'package:egy_akin/features/change_password/presentation/cubit/change_password_cubit.dart';

import '../../../../exports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordCubit cubit = ChangePasswordCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Container(),
    );
  }
}
