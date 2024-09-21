import 'package:egy_akin/features/change_password/presentation/cubit/change_password_state.dart';

import '../../../../exports.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._changePasswordUsecase)
      : super(const ChangePasswordState.initial());
  static ChangePasswordCubit get(context) => BlocProvider.of(context);
  final ChangePasswordUsecase _changePasswordUsecase;
  String oldPassword = '';
  TextEditingController newPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  changePassword() async {
    if (formKey.currentState!.validate()) {
      emit(const ChangePasswordState.loading());
      final result = await _changePasswordUsecase.execute(
        ChangePasswordUsecaseInput(
          oldPassword: oldPassword,
          newPassword: newPasswordController.text,
        ),
      );
      result.fold(
        (l) {
          emit(ChangePasswordState.error(l.message));
        },
        (r) async {
          oldPassword = '';
          newPasswordController.text = '';
          formKey.currentState?.reset();
          emit(ChangePasswordState.loaded(r.message.toString()));
        },
      );
    }
  }
}
