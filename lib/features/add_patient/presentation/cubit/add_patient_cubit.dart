import 'dart:developer';
import '../../../../exports.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit(
    this._getPatientHistoryForAddPatientUsecase,
    this._addPatientForFirstTimetUsecase,
  ) : super(const AddPatientState.initial());
  static AddPatientCubit get(context) => BlocProvider.of(context);
  final GetPatientHistoryForAddPatientUsecase
      _getPatientHistoryForAddPatientUsecase;
  final AddPatientForFirstTimetUsecase _addPatientForFirstTimetUsecase;

  GlobalKey<FormState> addPatientKeyForm = GlobalKey<FormState>();
  List<QuestionModel>? questionModelList = [];
  Map<String, dynamic> formData = {};

  getPatientHistoryForAddPatient() async {
    emit(const AddPatientState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _getPatientHistoryForAddPatientUsecase.excute('1');
    result.fold(
      (l) {
        emit(AddPatientState.error(l.message));
      },
      (response) async {
        questionModelList = response.data;
        emit(AddPatientState.loaded(response.data ?? [], false, 0));
      },
    );
  }

  addPatientForFirstTime() async {
    emit(const AddPatientState.loading());
    submitBotton();
  }

  submitBotton() async {
    bool isValid = true;

    for (var question in questionModelList!) {
      if (question.mandatory == true) {
        if (question.type == 'multiple') {
          Map myMap = formData[question.id.toString()] ??= {
            "answers": [],
            "other_field": ''
          };

          // Check if "answers" key is either null or an empty list
          if (myMap.containsKey('answers')) {
            dynamic answersValue = myMap['answers'];

            if (answersValue == null ||
                (answersValue is List && answersValue.isEmpty)) {
              debugPrint('"answers" key is either null or an empty list.');

              emit(AddPatientState.error(
                  'You must select at least one choice. \n{${question.question}}'));

              isValid = false;
              break;
            } else {
              debugPrint(
                  '"answers" key is present and has a non-empty list value: $answersValue');
            }
          } else {
            debugPrint('"answers" key is not present in the map.');

            emit(const AddPatientState.error(AppStrings.somethingWentWrong));
            isValid = false;
            break;
          }

          if ((myMap['other_field'] == null ||
                  myMap['other_field'].toString().isEmpty) &&
              (myMap['answers'] as List).contains('Others')) {
            emit(AddPatientState.error(
                'You must add "Others" field in \n{${question.question}}'));

            isValid = false;
            break;
          }
        }
        if (question.question == 'National ID') {
          if (formData.containsKey(question.id.toString())) {
            String nationalID = formData[question.id.toString()];
            if (nationalID.length != 14) {
              emit(const AddPatientState.error(
                  'National ID should have 14 digits'));

              isValid = false;
              break;
            }
            if (int.tryParse(nationalID) == null) {
              emit(const AddPatientState.error(
                  'National ID should have 14 digits'));
              getPatientHistoryForAddPatient();
              isValid = false;
              break;
            }
          }
        }
        if (question.question == 'Age') {
          if (formData.containsKey(question.id.toString())) {
            String age = formData[question.id.toString()];
            if (int.tryParse(age) == null || int.parse(age) > 99) {
              emit(const AddPatientState.error('Age should be less than 99'));

              isValid = false;
              break;
            }
          }
        }
        if (formData[question.id.toString()] == null ||
            formData[question.id.toString()] == '') {
          emit(AddPatientState.error(
              'This question is required \n{${question.question}}'));

          isValid = false;
          break;
        }

        if (question.question == 'Phone') {
          String phoneNumber = formData[question.id.toString()];

          if (phoneNumber.length != 11) {
            emit(const AddPatientState.error('Phone should have 11 digits'));
            isValid = false;
            break;
          }
          if (int.tryParse(phoneNumber) == null) {
            emit(const AddPatientState.error('Phone should have 11 digits'));
            isValid = false;
            break;
          }
        }
      }
    }

    if (isValid == true) {
      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
      final result = await _addPatientForFirstTimetUsecase.excute(formData);
      result.fold(
        (l) {
          emit(AddPatientState.error(l.message));
          getPatientHistoryForAddPatient();
        },
        (response) async {
          emit(AddPatientState.loaded([], true, response.id!));
        },
      );
    } else {
      getPatientHistoryForAddPatient();
    }
  }
}
