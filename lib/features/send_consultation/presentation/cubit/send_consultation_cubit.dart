import 'dart:developer';

import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/get_consultation_search_usecase.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/send_consultation_usecase.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';

import '../../../../exports.dart';

class SendConsultationCubit extends Cubit<SendConsultationState> {
  SendConsultationCubit(
      this._getConsultationSearchUsecase, this._sendConsultationUsecase)
      : super(const SendConsultationState.loaded(
            false, false, '', null, 0, false, false));
  final GetConsultationSearchUsecase _getConsultationSearchUsecase;
  final SendConsultationUsecase _sendConsultationUsecase;
  static SendConsultationCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  final List<DoctorModelInConsultationModelResponse> doctorsChecked = [];
  String consultMessage = '';
  ScrollController horizontalScrollController = ScrollController();
  bool isDoctorChecked(DoctorModelInConsultationModelResponse doctor) {
    return doctorsChecked.any((d) => d.id == doctor.id);
  }

  int counterChanges = 0;
  updateScreen() {
    counterChanges += 1;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => SendConsultationState.loaded(value.isSearching,
          value.isSearched, '', value.response, counterChanges, false, false),
    ));
  }

  getConsultationSearch() async {
    if (searchController.text.trim().isNotEmpty) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => SendConsultationState.loaded(
            true, false, '', null, counterChanges, false, false),
      ));

      final result =
          await _getConsultationSearchUsecase.execute(searchController.text);
      searchController.clear();
      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => SendConsultationState.loaded(
                false, false, l.message, null, counterChanges, false, false),
          ));
        },
        (r) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => SendConsultationState.loaded(
                false, true, '', r, counterChanges, false, false),
          ));
        },
      );
    }
  }

  sendConsultation(String patientId) async {
    List<String> doctorsIDS =
        doctorsChecked.map((doctor) => doctor.id.toString()).toList();

    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => SendConsultationState.loaded(
        value.isSearching,
        value.isSearched,
        '',
        value.response,
        value.counterChanges,
        true,
        false,
      ),
    ));
    final result = await _sendConsultationUsecase.execute(
      SendConsultationUsecaseInput(
        patientId: patientId,
        message: consultMessage,
        doctorsIDS: doctorsIDS,
      ),
    );

    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => SendConsultationState.loaded(
            value.isSearching,
            value.isSearched,
            l.message,
            value.response,
            value.counterChanges,
            false,
            false,
          ),
        ));
      },
      (r) {
        doctorsChecked.clear();

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => SendConsultationState.loaded(
              value.isSearching,
              value.isSearched,
              r.message.toString(),
              value.response?.copyWith(data: []),
              value.counterChanges,
              false,
              true,
            ),
          ),
        );
      },
    );
  }
}
