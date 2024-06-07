import 'package:egy_akin/features/change_password/presentation/cubit/change_password_state.dart';

import '../../../../exports.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState.initial());
  static ChangePasswordCubit get(context) => BlocProvider.of(context);
}
