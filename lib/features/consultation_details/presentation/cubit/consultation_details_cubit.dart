import 'package:egy_akin/features/consultation_details/domain/usecases/lock_or_unlock_consultation_usecase.dart';
import 'package:egy_akin/features/consultation_details/presentation/cubit/consultation_details_state.dart';

import '../../../../exports.dart';

class ConsultationDetailsCubit extends Cubit<ConsultationDetailsState> {
  ConsultationDetailsCubit(this._getConsultationDetailsUsecase,
      this._addConsultationReplyUsecase, this._lockOrUnlockConsultationUsecase)
      : super(const ConsultationDetailsState.initial());
  final GetConsultationDetailsUsecase _getConsultationDetailsUsecase;
  final AddConsultationReplyUsecase _addConsultationReplyUsecase;
  final LockOrUnlockConsultationUsecase _lockOrUnlockConsultationUsecase;
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
        // Determine initial lock status based on isOpen field
        bool initialIsLocked = !(r.isOpen ?? true); // Default to unlocked if isOpen is null
        emit(ConsultationDetailsState.loaded(
            r, '', false, false, '', false, initialIsLocked));
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
            '',
            value.isLocking,
            value.isLocked),
      ),
    );
  }

  addConsultationReply(
      {required String consultationId, required String reply}) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => ConsultationDetailsState.loaded(
            value.consultDetails,
            value.newCommentValue,
            true,
            false,
            '',
            value.isLocking,
            value.isLocked),
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
                l.message,
                value.isLocking,
                value.isLocked),
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
                r.message.toString(),
                value.isLocking,
                value.isLocked),
          ),
        );
      },
    );
  }

  lockOrUnlockConsultation(String consultationId, bool isOpen) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => ConsultationDetailsState.loaded(
        value.consultDetails,
        value.newCommentValue,
        value.isSendingConsultation,
        value.isSendedConsultation,
        '',
        true,
        false,
      ),
    ));
    final result = await _lockOrUnlockConsultationUsecase.execute(
      LockOrUnlockConsultationUsecaseInput(
        consultationId: consultationId,
        isOpen: isOpen,
      ),
    );
    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => ConsultationDetailsState.loaded(
            value.consultDetails,
            value.newCommentValue,
            value.isSendingConsultation,
            value.isSendedConsultation,
            l.message,
            false,
           false,
          ),
        ));
      },
      (r) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => ConsultationDetailsState.loaded(
            value.consultDetails.copyWith(isOpen: isOpen), // Update the consultation details with new isOpen value
            value.newCommentValue,
            value.isSendingConsultation,
            value.isSendedConsultation,
            r.message.toString(),
            false,
            !isOpen, // isLocked should be the opposite of isOpen
          ),
        ));
      },
    );
  }
}
