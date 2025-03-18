import 'package:egy_akin/features/consultation_from_ai/data/models/get_ai_consultation_history_model_response.dart';
import 'package:egy_akin/features/consultation_from_ai/presentation/cubit/consultation_from_ai_state.dart';

import '../../../../exports.dart';

class ConsultationFromAICubit extends Cubit<ConsultationFromAIState> {
  ConsultationFromAICubit(this._getAiConsultationHistoryUsecase,
      this._sendAiConsultationRequestUsecase)
      : super(const ConsultationFromAIState.initial());
  static ConsultationFromAICubit get(context) => BlocProvider.of(context);
  String newConsultation = '';

  final GetAiConsultationHistoryUsecase _getAiConsultationHistoryUsecase;
  final SendAiConsultationRequestUsecase _sendAiConsultationRequestUsecase;
  ScrollController? scrollController;
  GetAiConsultationHistoryModelResponse aiHistoryResponse =
      const GetAiConsultationHistoryModelResponse();

  getAIConsultationHistory(String patientId) async {
    emit(const ConsultationFromAIState.loading());
    _currentPage = 1;

    final result = await _getAiConsultationHistoryUsecase
        .execute(GetAiConsultationHistoryUsecaseInput(
      patientId: patientId,
      page: 1,
    ));
    result.fold(
      (l) {
        emit(ConsultationFromAIState.error(l.message));
      },
      (response) async {
        aiHistoryResponse = response;
        emit(ConsultationFromAIState.loaded(
            aiHistoryResponse, false, false, '', false));
      },
    );
  }

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;
  void loadMorePatients(String patientId) async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => ConsultationFromAIState.loaded(
        value.aiHistoryResponse,
        false,
        false,
        '',
        true,
      ),
    ));
    final result = await _getAiConsultationHistoryUsecase
        .execute(GetAiConsultationHistoryUsecaseInput(
      patientId: patientId,
      page: _currentPage,
    ));
    result.fold(
      (l) {
        _currentPage--;
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => ConsultationFromAIState.loaded(
            value.aiHistoryResponse,
            false,
            false,
            l.message,
            false,
          ),
        ));
      },
      (loadMorePatients) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            responseData,
            isSeeMore,
            message,
            isApplyFilterLoading,
            isApplyFilterLoaded,
          ) {
            final updatedData = responseData.copyWith(
              history: responseData.history!.copyWith(
                data: [
                  ...responseData.history!.data!,
                  ...loadMorePatients.history!.data!
                ],
              ),
            );
            if (_currentPage >= responseData.history!.lastPage!) {
              isLastPage = true;
            } else {
              isLastPage = false;
            }
            isLoadingMoreForScroll = false;
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => ConsultationFromAIState.loaded(
                updatedData,
                false,
                false,
                '',
                false,
              ),
            ));
          },
          error: (error) {},
        );
      },
    );
  }

  sendAIConsultationRequest(String patientId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => ConsultationFromAIState.loaded(
        value.aiHistoryResponse,
        true,
        false,
        '',
        false,
      ),
    ));

    final result = await _sendAiConsultationRequestUsecase.execute(patientId);
    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => ConsultationFromAIState.loaded(
            value.aiHistoryResponse,
            false,
            false,
            l.message,
            false,
          ),
        ));
      },
      (response) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => ConsultationFromAIState.loaded(
            value.aiHistoryResponse,
            false,
            true,
            '',
            false,
          ),
        ));

        getAIConsultationHistory(patientId);
      },
    );
  }
}
