import 'package:egy_akin/features/consultation_details/presentation/cubit/consultation_details_state.dart';

import '../../../../exports.dart';

class ConsultationDetailsCubit extends Cubit<ConsultationDetailsState> {
  ConsultationDetailsCubit(
      this._getConsultationDetailsUsecase, this._addConsultationReplyUsecase)
      : super(const ConsultationDetailsState.initial());
  final GetConsultationDetailsUsecase _getConsultationDetailsUsecase;
  final AddConsultationReplyUsecase _addConsultationReplyUsecase;
  static ConsultationDetailsCubit get(context) => BlocProvider.of(context);
  String newConsultation = '';

  getConsultationDetails(String consultationId) async {
    emit(const ConsultationDetailsState.loading());

    final result = await _getConsultationDetailsUsecase.execute(consultationId);
    result.fold(
      (l) {
        emit(ConsultationDetailsState.error(l.message));
      },
      (r) async {
        emit(ConsultationDetailsState.loaded(r, '', false, false, ''));
      },
    );
  }

  newConsultationValueChanged(String newConsultationValue) {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => ConsultationDetailsState.loaded(
            value.consultDetails,
            newConsultationValue,
            value.isSendingConsultation,
            value.isSendedConsultation,
            ''),
      ),
    );
  }

  addConsultationReply(
      {required String consultationId, required String reply}) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => ConsultationDetailsState.loaded(
            value.consultDetails, value.newCommentValue, true, false, ''),
      ),
    );

    final result = await _addConsultationReplyUsecase.execute(
        AddConsultationReplyUsecaseInput(
            consultationId: consultationId, reply: reply));
    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ConsultationDetailsState.loaded(
                value.consultDetails,
                value.newCommentValue,
                false,
                false,
                l.message),
          ),
        );
      },
      (r) async {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ConsultationDetailsState.loaded(
                value.consultDetails,
                value.newCommentValue,
                false,
                true,
                r.message.toString()),
          ),
        );
      },
    );
  }
}
