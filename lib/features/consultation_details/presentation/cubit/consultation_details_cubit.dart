import 'package:egy_akin/features/consultation_details/domain/usecases/get_consultation_details_usecase.dart';
import 'package:egy_akin/features/consultation_details/presentation/cubit/consultation_details_state.dart';

import '../../../../exports.dart';

class ConsultationDetailsCubit extends Cubit<ConsultationDetailsState> {
  ConsultationDetailsCubit(this._getConsultationDetailsUsecase)
      : super(const ConsultationDetailsState.initial());
  final GetConsultationDetailsUsecase _getConsultationDetailsUsecase;
  static ConsultationDetailsCubit get(context) => BlocProvider.of(context);

  getConsultationDetails(String consultationId) async {
    emit(const ConsultationDetailsState.loading());

    final result = await _getConsultationDetailsUsecase.execute(consultationId);
    result.fold(
      (l) {
        emit(ConsultationDetailsState.error(l.message));
      },
      (r) async {
        emit(ConsultationDetailsState.loaded(r));
      },
    );
  }
}
