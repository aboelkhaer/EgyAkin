import 'package:egy_akin/features/send_consultation/domain/usecases/add_doctors_for_consultation_usecase.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/get_members_for_consultation_usecase.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/remove_member_from_consultation_usecase.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/send_group_invitation_usecase.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';

import '../../../../exports.dart';

class SendConsultationCubit extends Cubit<SendConsultationState> {
  SendConsultationCubit(
      this._getConsultationSearchUsecase,
      this._sendConsultationUsecase,
      this._sendGroupInvitationUsecase,
      this._getMembersForConsultationUsecase,
      this._removeMemberFromConsultationUsecase,
      this._addDoctorsForConsultationUsecase)
      : super(const SendConsultationState.initial());
  final GetConsultationSearchUsecase _getConsultationSearchUsecase;
  final SendConsultationUsecase _sendConsultationUsecase;
  final SendGroupInvitationUsecase _sendGroupInvitationUsecase;
  final GetMembersForConsultationUsecase _getMembersForConsultationUsecase;
  final RemoveMemberFromConsultationUsecase
      _removeMemberFromConsultationUsecase;
  final AddDoctorsForConsultationUsecase _addDoctorsForConsultationUsecase;
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
      loaded: (value) => SendConsultationState.loaded(
        value.isSearching,
        value.isSearched,
        '',
        value.response,
        counterChanges,
        false,
        false,
        value.membersForConsultation,
        false,
        false,
      ),
    ));
  }

  getConsultationSearch() async {
    if (searchController.text.trim().isNotEmpty) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => SendConsultationState.loaded(
          true,
          false,
          '',
          null,
          counterChanges,
          false,
          false,
          value.membersForConsultation,
          false,
          false,
        ),
      ));

      final result =
          await _getConsultationSearchUsecase.execute(searchController.text);
      // searchController.clear();
      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => SendConsultationState.loaded(
              false,
              false,
              l.message,
              null,
              counterChanges,
              false,
              false,
              value.membersForConsultation,
              false,
              false,
            ),
          ));
        },
        (r) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => SendConsultationState.loaded(
              false,
              true,
              '',
              r,
              counterChanges,
              false,
              false,
              value.membersForConsultation,
              false,
              false,
            ),
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
        null,
        false,
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
            null,
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
              null,
              false,
              false,
            ),
          ),
        );
      },
    );
  }

  sendGroupInvitation(String groupId) async {
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
        null,
        false,
        false,
      ),
    ));
    final result = await _sendGroupInvitationUsecase.execute(
      SendGroupInvitationUsecaseInput(
        groupId: groupId,
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
            null,
            false,
            false,
          ),
        ));
      },
      (r) {
        doctorsChecked.clear();
        searchController.clear();

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
              null,
              false,
              false,
            ),
          ),
        );
      },
    );
  }

  emitLoadedIfNotForMembers() {
    emit(const SendConsultationState.loaded(
      false,
      false,
      '',
      null,
      0,
      false,
      false,
      null,
      false,
      false,
    ));
  }

  getMembersForConsultation(String consultationId) async {
    emit(const SendConsultationState.loading());
    final result =
        await _getMembersForConsultationUsecase.execute(consultationId);
    result.fold(
      (l) {
        emit(SendConsultationState.error(l.message));
      },
      (r) {
        // Debug logging to see what we're getting
        debugPrint('=== DEBUG: Members for consultation response ===');
        debugPrint('Response: $r');
        debugPrint('Data: ${r.data}');
        debugPrint('Data length: ${r.data?.length}');
        debugPrint('Response toJson: ${r.toJson()}');
        debugPrint('Response runtimeType: ${r.runtimeType}');
        debugPrint('Response toString: ${r.toString()}');
        if (r.data != null) {
          for (int i = 0; i < r.data!.length; i++) {
            debugPrint('Member $i: ${r.data![i]}');
          }
        }
        debugPrint('==============================================');

        emit(
          SendConsultationState.loaded(
            false,
            false,
            '',
            const GetConsultationSearchModelResponse(),
            counterChanges,
            false,
            false,
            r,
            false,
            false,
          ),
        );
      },
    );
  }

  removeMemberFromConsultation(String consultationId, String doctorId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => SendConsultationState.loaded(
        value.isSearching,
        value.isSearched,
        '',
        value.response,
        counterChanges,
        false,
        false,
        value.membersForConsultation?.copyWith(
            data: value.membersForConsultation?.data
                ?.where((element) => element.id != int.parse(doctorId))
                .toList()),
        false,
        false,
      ),
    ));
    final result = await _removeMemberFromConsultationUsecase.execute(
        RemoveMemberFromConsultationUsecaseInput(
            consultationId: consultationId, doctorId: doctorId));
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
            value.membersForConsultation,
            false,
            false,
          ),
        ));
      },
      (r) {
        // After successful removal, refresh the members list
        // getMembersForConsultation(consultationId);
      },
    );
  }

  addDoctorsForConsultation(
      String consultationId, List<String> doctorsIDS) async {
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
        value.membersForConsultation,
        false,
        false,
      ),
    ));
    final result = await _addDoctorsForConsultationUsecase.execute(
      AddDoctorsForConsultationUsecaseInput(
        consultationId: consultationId,
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
            value.membersForConsultation,
            false,
            false,
          ),
        ));
      },
      (r) {
        // Clear the doctorsChecked list after successful addition
        doctorsChecked.clear();
        // Refresh the members list to show the updated consultation members
        getMembersForConsultation(consultationId);
      },
    );
  }
}
