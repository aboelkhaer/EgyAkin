import 'package:egy_akin/features/contact_us/domain/usecases/add_contact_us_usecase.dart';
import 'package:egy_akin/features/contact_us/presentation/cubit/contact_us_state.dart';

import '../../../../exports.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this._addContactUsUsecase)
      : super(const ContactUsState.initial());
  final AddContactUsUsecase _addContactUsUsecase;
  static ContactUsCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> feedbackFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String feedback = '';

  addContactUs() async {
    if (formKey.currentState!.validate()) {
      emit(const ContactUsState.loading());

      final result = await _addContactUsUsecase.excute(feedback);
      result.fold(
        (l) {
          emit(ContactUsState.error(l.message));
        },
        (r) async {
          emit(ContactUsState.loaded(r.message.toString()));
        },
      );
    }
  }
}
