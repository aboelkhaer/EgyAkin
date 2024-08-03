import 'package:egy_akin/features/send_consultation/domain/usecases/get_consultation_search_usecase.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';

import '../../../../exports.dart';

class SendConsultationCubit extends Cubit<SendConsultationState> {
  SendConsultationCubit(this._getConsultationSearchUsecase)
      : super(const SendConsultationState.loaded(false, false, '', null));
  final GetConsultationSearchUsecase _getConsultationSearchUsecase;
  static SendConsultationCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  List<String> doctorsIds = ['7'];

  getConsultationSearch() async {
    if (searchController.text.trim().isNotEmpty) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) =>
            const SendConsultationState.loaded(true, false, '', null),
      ));

      final result =
          await _getConsultationSearchUsecase.execute(searchController.text);
      searchController.clear();
      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) =>
                SendConsultationState.loaded(false, false, l.message, null),
          ));
        },
        (r) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => SendConsultationState.loaded(false, true, '', r),
          ));
        },
      );
    }
  }
}
