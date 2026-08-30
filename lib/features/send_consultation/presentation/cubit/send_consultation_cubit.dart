import 'package:egy_akin/features/send_consultation/domain/usecases/add_doctors_for_consultation_usecase.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/get_members_for_consultation_usecase.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/invite_external_consultation_usecase.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/remove_member_from_consultation_usecase.dart';
import 'package:egy_akin/features/send_consultation/domain/usecases/send_group_invitation_usecase.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';

import '../../../../exports.dart';
import 'package:egy_akin/features/send_consultation/presentation/widgets/invite_external_doctor_dialog.dart';

class SendConsultationCubit extends Cubit<SendConsultationState> {
  SendConsultationCubit(
      this._getConsultationSearchUsecase,
      this._sendConsultationUsecase,
      this._sendGroupInvitationUsecase,
      this._getMembersForConsultationUsecase,
      this._removeMemberFromConsultationUsecase,
      this._addDoctorsForConsultationUsecase,
      this._inviteExternalConsultationUsecase)
      : super(const SendConsultationState.initial());
  final GetConsultationSearchUsecase _getConsultationSearchUsecase;
  final SendConsultationUsecase _sendConsultationUsecase;
  final SendGroupInvitationUsecase _sendGroupInvitationUsecase;
  final GetMembersForConsultationUsecase _getMembersForConsultationUsecase;
  final RemoveMemberFromConsultationUsecase
      _removeMemberFromConsultationUsecase;
  final AddDoctorsForConsultationUsecase _addDoctorsForConsultationUsecase;
  final InviteExternalConsultationUsecase _inviteExternalConsultationUsecase;
  static SendConsultationCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  final List<DoctorModelInConsultationModelResponse> doctorsChecked = [];
  /// Email invites staged while creating a consultation (no id yet).
  final List<PendingExternalInvite> pendingExternalInvites = [];
  String consultMessage = '';
  ScrollController horizontalScrollController = ScrollController();
  bool isDoctorChecked(DoctorModelInConsultationModelResponse doctor) {
    return doctorsChecked.any((d) => d.id == doctor.id);
  }

  int get totalInviteCount =>
      doctorsChecked.length + pendingExternalInvites.length;

  bool queuePendingExternalInvite({
    required String email,
    String? inviteMessage,
  }) {
    final normalized = email.trim().toLowerCase();
    if (pendingExternalInvites
        .any((e) => e.email.toLowerCase() == normalized)) {
      return false;
    }
    pendingExternalInvites.add(
      PendingExternalInvite(email: email.trim(), inviteMessage: inviteMessage),
    );
    searchController.clear();
    counterChanges += 1;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => SendConsultationState.loaded(
        false,
        false,
        '',
        value.response?.copyWith(data: []),
        counterChanges,
        false,
        false,
        value.membersForConsultation,
        false,
        false,
      ),
    ));
    return true;
  }

  void removePendingExternalInvite(String email) {
    pendingExternalInvites.removeWhere(
      (e) => e.email.toLowerCase() == email.trim().toLowerCase(),
    );
    updateScreen();
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

  /// [groupId] is passed while inviting into a group; leave it null for
  /// consultation search.
  getConsultationSearch({String? groupId}) async {
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

      final result = await _getConsultationSearchUsecase.execute(
        GetConsultationSearchUsecaseInput(
          searchContent: searchController.text,
          groupId: groupId,
        ),
      );
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
    final stagedInvites = List<PendingExternalInvite>.from(
      pendingExternalInvites,
    );

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

    await result.fold<Future<void>>(
      (l) async {
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
      (r) async {
        doctorsChecked.clear();
        pendingExternalInvites.clear();

        var successMessage = r.message?.toString().isNotEmpty == true
            ? r.message!
            : AppStrings.invitationSentSuccessfully;

        final consultationId = r.resolvedConsultationId;
        if (stagedInvites.isNotEmpty) {
          if (consultationId == null || consultationId.isEmpty) {
            successMessage = AppStrings.emailInvitesCouldNotAutoSend;
          } else {
            await _flushPendingExternalInvites(
              consultationId: consultationId,
              invites: stagedInvites,
            );
          }
        }

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => SendConsultationState.loaded(
              value.isSearching,
              value.isSearched,
              successMessage,
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

  Future<void> _flushPendingExternalInvites({
    required String consultationId,
    required List<PendingExternalInvite> invites,
  }) async {
    for (final invite in invites) {
      final result = await _inviteExternalConsultationUsecase.execute(
        InviteExternalConsultationUsecaseInput(
          consultationId: consultationId,
          email: invite.email,
          inviteMessage: invite.inviteMessage,
        ),
      );

      await result.fold<Future<void>>(
        (l) async {
          final existingUserId = _existingUserIdFromFailure(l);
          if (l.code == 409 && existingUserId != null) {
            await _addDoctorsForConsultationUsecase.execute(
              AddDoctorsForConsultationUsecaseInput(
                consultationId: consultationId,
                message: consultMessage,
                doctorsIDS: [existingUserId.toString()],
              ),
            );
          }
        },
        (_) async {},
      );
    }
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
    final stagedInvites = List<PendingExternalInvite>.from(
      pendingExternalInvites,
    );

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

    if (doctorsIDS.isNotEmpty) {
      final result = await _addDoctorsForConsultationUsecase.execute(
        AddDoctorsForConsultationUsecaseInput(
          consultationId: consultationId,
          message: consultMessage,
          doctorsIDS: doctorsIDS,
        ),
      );

      final failed = await result.fold<Future<bool>>(
        (l) async {
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
          return true;
        },
        (_) async => false,
      );
      if (failed) return;
    }

    doctorsChecked.clear();
    pendingExternalInvites.clear();

    if (stagedInvites.isNotEmpty) {
      await _flushPendingExternalInvites(
        consultationId: consultationId,
        invites: stagedInvites,
      );
    }

    // Refresh the members list to show the updated consultation members
    getMembersForConsultation(consultationId);
  }

  /// Invite a doctor by email. On 409 with `existing_user_id`, falls back to
  /// [addDoctorsForConsultation] so registered doctors join normally.
  Future<void> inviteExternalDoctor({
    required String consultationId,
    required String email,
    String? inviteMessage,
  }) async {
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

    final result = await _inviteExternalConsultationUsecase.execute(
      InviteExternalConsultationUsecaseInput(
        consultationId: consultationId,
        email: email,
        inviteMessage: inviteMessage,
      ),
    );

    await result.fold<Future<void>>(
      (l) async {
        final existingUserId = _existingUserIdFromFailure(l);
        if (l.code == 409 && existingUserId != null) {
          await addDoctorsForConsultation(
            consultationId,
            [existingUserId.toString()],
          );
          return;
        }

        final friendly = _friendlyInviteError(l);
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => SendConsultationState.loaded(
            value.isSearching,
            value.isSearched,
            friendly,
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
      (r) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => SendConsultationState.loaded(
            value.isSearching,
            value.isSearched,
            r.message?.toString().isNotEmpty == true
                ? r.message!
                : AppStrings.invitationSentSuccessfully,
            value.response,
            value.counterChanges,
            false,
            true,
            value.membersForConsultation,
            false,
            false,
          ),
        ));
      },
    );
  }

  int? _existingUserIdFromFailure(Failure failure) {
    final data = failure.data;
    if (data == null) return null;
    final nested = data['data'];
    if (nested is Map) {
      final id = nested['existing_user_id'];
      if (id is int) return id;
      return int.tryParse(id?.toString() ?? '');
    }
    final id = data['existing_user_id'];
    if (id is int) return id;
    return int.tryParse(id?.toString() ?? '');
  }

  String _friendlyInviteError(Failure failure) {
    final key = failure.message;
    switch (key) {
      case 'cannot_invite_closed_consultation':
        return AppStrings.cannotInviteClosedConsultation;
      case 'invite_daily_limit_reached':
        return AppStrings.inviteDailyLimitReached;
      case 'invite_email_failed':
        return AppStrings.inviteEmailFailed;
      case 'invite_already_accepted':
        return AppStrings.inviteAlreadyAccepted;
      default:
        return key.isNotEmpty ? key : AppStrings.defaultError;
    }
  }
}
