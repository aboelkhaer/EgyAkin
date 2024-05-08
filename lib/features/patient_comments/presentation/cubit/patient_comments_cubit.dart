import 'package:egy_akin/app/shared/functions/animate_to_bottom_of_screen.dart';
import 'package:egy_akin/features/patient_comments/domain/usecases/add_patient_comment_usecase.dart';
import 'package:egy_akin/features/patient_comments/domain/usecases/delete_patient_comment_usecase.dart';

import '../../../../exports.dart';

class PatientCommentsCubit extends Cubit<PatientCommentsState> {
  PatientCommentsCubit(this._getPatientCommentsUsecase,
      this._addPatientCommentsUsecase, this._deletePatientCommentsUsecase)
      : super(const PatientCommentsState.initial());
  final GetPatientCommentsUsecase _getPatientCommentsUsecase;
  final AddPatientCommentsUsecase _addPatientCommentsUsecase;
  final DeletePatientCommentsUsecase _deletePatientCommentsUsecase;
  static PatientCommentsCubit get(context) => BlocProvider.of(context);
  String newComment = '';
  ScrollController scrollController = ScrollController();

  getPatientComments(String patientId) async {
    emit(const PatientCommentsState.loading());
    final result = await _getPatientCommentsUsecase.excute(patientId);

    result.fold(
      (l) {
        emit(PatientCommentsState.error(l.message));
      },
      (response) async {
        emit(PatientCommentsState.loaded(response.data!, ''));
      },
    );
  }

  addPatientComments({required String patientId}) async {
    emit(const PatientCommentsState.loading());
    final result = await _addPatientCommentsUsecase.excute(
        AddCommentUseCaseInput(patientId: patientId, content: newComment));

    result.fold(
      (l) {
        emit(PatientCommentsState.error(l.message));
      },
      (result) async {
        newComment = '';
        final getCommentsResult =
            await _getPatientCommentsUsecase.excute(patientId);
        getCommentsResult.fold(
          (l) {
            emit(PatientCommentsState.error(l.message));
          },
          (r) async {
            emit(PatientCommentsState.loaded(r.data!, ''));
            animateToBottomOfScreen(scrollController);
          },
        );
      },
    );
  }

  newCommentValueChanged(String newCommentValue) {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) =>
            PatientCommentsState.loaded(value.comments, newCommentValue),
      ),
    );
  }

  void deletePatientComment(String commentId) async {
    final result = await _deletePatientCommentsUsecase.excute(commentId);

    result.fold(
      (l) {
        emit(PatientCommentsState.error(l.message));
      },
      (result) async {
        state.maybeMap(
          loaded: (value) {
            final updatedComments = value.comments
                .where((comment) => comment.id.toString() != commentId)
                .toList();
            emit(PatientCommentsState.loaded(updatedComments, ''));
          },
          orElse: () => state,
        );
      },
    );
  }
}
