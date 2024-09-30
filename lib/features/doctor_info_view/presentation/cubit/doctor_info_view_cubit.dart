import 'package:egy_akin/features/doctor_info_view/domain/usecases/block_user_usecase.dart';
import 'package:egy_akin/features/doctor_info_view/domain/usecases/change_syndicate_card_status_usecase.dart';
import 'package:egy_akin/features/doctor_info_view/domain/usecases/verify_user_email_usecase.dart';

import '../../../../exports.dart';

class DoctorInfoViewCubit extends Cubit<DoctorInfoViewState> {
  DoctorInfoViewCubit(
    this._getDoctorInfoViewUsecase,
    this._getAchievementsUsecase,
    this._changeSyndicateCardStatusUsecase,
    this._blockUserUsecase,
    this._verifyUserEmailUsecase,
    this._homeCubit,
  ) : super(const DoctorInfoViewState.initial());
  final GetDoctorInfoViewUsecase _getDoctorInfoViewUsecase;
  final GetAchievementsUsecase _getAchievementsUsecase;
  final ChangeSyndicateCardStatusUsecase _changeSyndicateCardStatusUsecase;
  final BlockUserUsecase _blockUserUsecase;
  final VerifyUserEmailUsecase _verifyUserEmailUsecase;
  final HomeCubit _homeCubit;
  static DoctorInfoViewCubit get(context) => BlocProvider.of(context);
  int changesCounter = 0;
  bool isSyndicateCardVerified = false;
  bool doctorBlocked = false;
  bool doctorVerifiedEmail = false;
  ScrollController doctorInfoViewScrollController = ScrollController();

  DoctorInfoViewModelResponse updatedDoctor =
      const DoctorInfoViewModelResponse();

  verifyDoctorEmail(String doctorId) async {
    changesCounter++;
    doctorVerifiedEmail = !doctorVerifiedEmail;

    // Update doctorInfo using the copyWith method
    final updatedDoctorModel = updatedDoctor.data!.copyWith(
      emailVerifiedAt:
          doctorVerifiedEmail ? DateTime.now().toIso8601String() : null,
    );
    final updatedDoctorInfo = updatedDoctor.copyWith(
      data: updatedDoctorModel,
    );

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => DoctorInfoViewState.loaded(
          updatedDoctorInfo, // Pass the updated doctorInfo here
          value.isLoadingAchievements,
          value.isLoadedAchievements,
          '',
          value.achievements,
          changesCounter,
        ),
      ),
    );

    final result = await _verifyUserEmailUsecase.execute(
        VerifyUserEmailUsecaseInput(
            doctorId: doctorId,
            timestamp:
                doctorVerifiedEmail ? DateTime.now().toIso8601String() : null));
    // .execute(syndicateCardChangedValue);
    result.fold((l) {
      debugPrint(l.message);
    }, (response) async {
      debugPrint(response.message);
    });
  }

  changeBlockUserStatus(String doctorId) async {
    changesCounter++;
    doctorBlocked = !doctorBlocked;

    // Update doctorInfo using the copyWith method
    final updatedDoctorModel = updatedDoctor.data!.copyWith(
      blocked: doctorBlocked,
    );
    final updatedDoctorInfo = updatedDoctor.copyWith(
      data: updatedDoctorModel,
    );

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => DoctorInfoViewState.loaded(
          updatedDoctorInfo, // Pass the updated doctorInfo here
          value.isLoadingAchievements,
          value.isLoadedAchievements,
          '',
          value.achievements,
          changesCounter,
        ),
      ),
    );

    final result = await _blockUserUsecase.execute(
        BlockUserUsecaseInput(status: doctorBlocked, doctorId: doctorId));
    // .execute(syndicateCardChangedValue);
    result.fold((l) {
      debugPrint(l.message);
    }, (response) async {
      debugPrint(response.message);
    });
  }

  Future<void> rejectSyndicateCard(String doctorId) async {
    changesCounter++;

    // Update doctorInfo and emit the state in DoctorInfoViewCubit
    final updatedDoctorModel = updatedDoctor.data!.copyWith(
      isSyndicateCardRequired: 'Required',
      syndicateCard: null,
    );
    final updatedDoctorInfo = updatedDoctor.copyWith(data: updatedDoctorModel);

    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => DoctorInfoViewState.loaded(
        updatedDoctorInfo,
        value.isLoadingAchievements,
        value.isLoadedAchievements,
        '',
        value.achievements,
        changesCounter,
      ),
    ));

    // Execute your use case to change syndicate card status
    final result = await _changeSyndicateCardStatusUsecase.execute(
      ChangeSyndicateCardStatusUsecaseInput(
          status: 'Required', doctorId: doctorId),
    );

    result.fold((l) {
      debugPrint(l.message);
    }, (response) async {
      // Remove the doctor from HomeCubit's data
      await _homeCubit.removeDoctorInDoctorsActivation(doctorId);

      debugPrint(response.message);
    });
  }

  changeSyndicateCardStatus(String doctorId) async {
    changesCounter++;
    isSyndicateCardVerified = !isSyndicateCardVerified;

    // Update doctorInfo using the copyWith method
    final updatedDoctorModel = updatedDoctor.data!.copyWith(
      isSyndicateCardRequired:
          isSyndicateCardVerified ? 'Verified' : 'Required',
    );
    final updatedDoctorInfo = updatedDoctor.copyWith(
      data: updatedDoctorModel,
    );

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => DoctorInfoViewState.loaded(
          updatedDoctorInfo, // Pass the updated doctorInfo here
          value.isLoadingAchievements,
          value.isLoadedAchievements,
          '',
          value.achievements,
          changesCounter,
        ),
      ),
    );

    String syndicateCardChangedValue =
        isSyndicateCardVerified ? 'Verified' : 'Required';

    final result = await _changeSyndicateCardStatusUsecase.execute(
        ChangeSyndicateCardStatusUsecaseInput(
            status: syndicateCardChangedValue, doctorId: doctorId));
    // .execute(syndicateCardChangedValue);
    result.fold((l) {
      debugPrint(l.message);
    }, (response) async {
      debugPrint(response.message);
    });
  }

  getDoctorInfo(String doctorId) async {
    emit(const DoctorInfoViewState.loading());

    final result = await _getDoctorInfoViewUsecase.execute(doctorId);
    result.fold(
      (l) {
        emit(DoctorInfoViewState.error(l.message));
      },
      (doctorInfo) async {
        if (doctorInfo.data!.isSyndicateCardRequired == 'Verified') {
          isSyndicateCardVerified = true;
        } else {
          isSyndicateCardVerified = false;
        }
        if (doctorInfo.data!.blocked == true) {
          doctorBlocked = true;
        } else {
          doctorBlocked = false;
        }
        if (doctorInfo.data!.emailVerifiedAt != null) {
          doctorVerifiedEmail = true;
        } else {
          doctorVerifiedEmail = false;
        }
        updatedDoctor = doctorInfo;
        emit(DoctorInfoViewState.loaded(
          updatedDoctor,
          false,
          false,
          '',
          null,
          changesCounter,
        ));
      },
    );
    getAchievementsV1(doctorId);
  }

  getAchievementsV2(String doctorId) async {
    emit(DoctorInfoViewState.loaded(
        null, true, false, '', null, changesCounter));

    final result = await _getAchievementsUsecase.execute(doctorId);
    result.fold(
      (l) {
        emit(DoctorInfoViewState.error(l.message));
      },
      (achievements) async {
        emit(DoctorInfoViewState.loaded(
            null, false, true, '', achievements, changesCounter));
      },
    );
  }

  getAchievementsV1(String doctorId) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => DoctorInfoViewState.loaded(
          value.doctorInfo,
          true,
          false,
          '',
          null,
          changesCounter,
        ),
      ),
    );

    final result = await _getAchievementsUsecase.execute(doctorId);
    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => DoctorInfoViewState.loaded(
              value.doctorInfo,
              false,
              false,
              l.message,
              null,
              changesCounter,
            ),
          ),
        );
      },
      (achievements) async {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => DoctorInfoViewState.loaded(
              value.doctorInfo,
              false,
              true,
              '',
              achievements,
              changesCounter,
            ),
          ),
        );
      },
    );
  }
}
