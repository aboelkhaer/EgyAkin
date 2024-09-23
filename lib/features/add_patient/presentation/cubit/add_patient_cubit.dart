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
  int snackbarErrorCounter = 0;
  GlobalKey<FormState> addPatientKeyForm = GlobalKey<FormState>();
  List<QuestionModel>? questionModelList = [];
  Map<String, dynamic> formData = {};

  getPatientHistoryForAddPatient() async {
    emit(const AddPatientState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _getPatientHistoryForAddPatientUsecase.execute('1');
    result.fold(
      (l) {
        emit(AddPatientState.error(l.message));
      },
      (response) async {
        questionModelList = response.data;
        emit(AddPatientState.loaded(
            response.data ?? [], false, 0, false, '', snackbarErrorCounter));
      },
    );
  }

  addPatientForFirstTime() async {
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

              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => AddPatientState.loaded(
                    value.questions,
                    false,
                    0,
                    false,
                    'You must select at least one choice. \n{${question.question}}',
                    snackbarErrorCounter += 1),
              ));

              isValid = false;
              break;
            } else {
              debugPrint(
                  '"answers" key is present and has a non-empty list value: $answersValue');
            }
          } else {
            debugPrint('"answers" key is not present in the map.');

            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => AddPatientState.loaded(
                  value.questions,
                  false,
                  0,
                  false,
                  AppStrings.somethingWentWrong,
                  snackbarErrorCounter += 1),
            ));
            isValid = false;
            break;
          }

          if ((myMap['other_field'] == null ||
                  myMap['other_field'].toString().isEmpty) &&
              (myMap['answers'] as List).contains('Others')) {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => AddPatientState.loaded(
                  value.questions,
                  false,
                  0,
                  false,
                  'You must add "Others" field in \n{${question.question}}',
                  snackbarErrorCounter += 1),
            ));

            isValid = false;
            break;
          }
        }
        if (question.question == 'Name') {
          if (formData.containsKey(question.id.toString())) {
            String name = formData[question.id.toString()];

            // Regular expression for checking only English alphabetic characters
            RegExp englishCharRegex = RegExp(r'^[a-zA-Z\s]+$');

            if (!englishCharRegex.hasMatch(name)) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => AddPatientState.loaded(
                    value.questions,
                    false,
                    0,
                    false,
                    'Name should contain only English letters',
                    snackbarErrorCounter += 1),
              ));

              isValid = false;
              break;
            }
          }
        }
        if (question.question == 'National ID') {
          if (formData.containsKey(question.id.toString())) {
            String nationalID = formData[question.id.toString()];
            if (nationalID.length != 14) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => AddPatientState.loaded(
                    value.questions,
                    false,
                    0,
                    false,
                    'National ID should have 14 digits',
                    snackbarErrorCounter += 1),
              ));

              isValid = false;
              break;
            }
            if (int.tryParse(nationalID) == null) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => AddPatientState.loaded(
                    value.questions,
                    false,
                    0,
                    false,
                    'National ID should have 14 digits',
                    snackbarErrorCounter += 1),
              ));
              isValid = false;
              break;
            }
          }
        }
        if (question.question == 'Phone' &&
            (question.answer != null ||
                question.answer.toString().trim() != '')) {
          String phoneNumber = formData[question.id.toString()];

          if (phoneNumber.length != 11) {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => AddPatientState.loaded(
                  value.questions,
                  false,
                  0,
                  false,
                  'This question is required \n{${question.question}}',
                  snackbarErrorCounter += 1),
            ));
            isValid = false;
            break;
          }
          if (int.tryParse(phoneNumber) == null) {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => AddPatientState.loaded(
                  value.questions,
                  false,
                  0,
                  false,
                  'This question is required \n{${question.question}}',
                  snackbarErrorCounter += 1),
            ));
            isValid = false;
            break;
          }
        }
        if (question.question == 'Age' &&
            (question.answer != null ||
                question.answer.toString().trim() != '')) {
          if (formData.containsKey(question.id.toString())) {
            String age = formData[question.id.toString()];
            if (int.tryParse(age) == null ||
                int.parse(age) > 119 ||
                int.parse(age) <= 0) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => AddPatientState.loaded(
                    value.questions,
                    false,
                    0,
                    false,
                    'Age should be less than 120',
                    snackbarErrorCounter += 1),
              ));

              isValid = false;
              break;
            }
          }
        }
        if (formData[question.id.toString()] == null ||
            formData[question.id.toString()] == '') {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => AddPatientState.loaded(
                value.questions,
                false,
                0,
                false,
                'This question is required \n{${question.question}}',
                snackbarErrorCounter += 1),
          ));

          isValid = false;
          break;
        }
      }
    }

    if (isValid == true) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => AddPatientState.loaded(
            value.questions, false, 0, true, '', snackbarErrorCounter),
      ));

      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
      final result = await _addPatientForFirstTimetUsecase.execute(formData);
      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => AddPatientState.loaded(value.questions, false, 0,
                false, l.message, snackbarErrorCounter),
          ));
        },
        (response) async {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => AddPatientState.loaded(value.questions, true,
                response.id!, false, '', snackbarErrorCounter),
          ));
        },
      );
    }
  }
}
