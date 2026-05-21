import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:egy_akin/app/constants/app_strings.dart';
import 'package:egy_akin/app/shared/functions/select_question_has_displayable_answer.dart';
import 'package:egy_akin/app/services/localization_service.dart';
import 'package:egy_akin/app/utilities/custom_snack_bar.dart';
import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:egy_akin/features/patient_section_details/data/models/patient_recommendation_model.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_recommendations_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/search_for_dose_model_response.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/create_new_medicine_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/create_recommendations_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/delete_patient_recommendation_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/get_patient_section_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/get_recommendations_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/search_for_dose_in_medication_section_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/update_patient_recommendation_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/update_patient_section_details_usecase.dart';
import 'package:egy_akin/features/patient_section_details/presentation/cubit/patient_section_details_state.dart';
import 'package:egy_akin/features/patient_section_details/presentation/models/repeatable_reading_entry.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;

class PatientSectionDetailsCubit extends Cubit<PatientSectionDetailsState> {
  PatientSectionDetailsCubit(
      this._getPatientSectionDetailsUsecase,
      this._updatePatientSectionDetailsUsecase,
      this._getRecommendationsUsecase,
      this._createRecommendationsUsecase,
      this._searchForDoseInMedicationSectionUsecase,
      this._deletePatientRecommendationUsecase, this._updateRecommendationUsecase, this._createNewMedicineUsecase)
      : super(const PatientSectionDetailsState.initial());
  final GetPatientSectionDetailsUsecase _getPatientSectionDetailsUsecase;
  final UpdatePatientSectionDetailsUsecase _updatePatientSectionDetailsUsecase;
  final GetRecommendationsUsecase _getRecommendationsUsecase;
  final SearchForDoseInMedicationSectionUsecase
      _searchForDoseInMedicationSectionUsecase;
  final DeletePatientRecommendationUsecase _deletePatientRecommendationUsecase;
  final CreateRecommendationsUsecase _createRecommendationsUsecase;
  final UpdatePatientRecommendationUsecase _updateRecommendationUsecase;
  final CreateNewMedicineUsecase _createNewMedicineUsecase;
  static PatientSectionDetailsCubit get(context) => BlocProvider.of(context);

  ScrollController patientSectionDetailsScrollController = ScrollController();
  List<QuestionModel> questionModelList = [];
  Map<String, dynamic> formData = {};
  GlobalKey<FormState> sectionDetailsKeyForm = GlobalKey<FormState>();
  int snackbarErrorCounter = 0;
  String removeFilesId = '';
  int counterChanges = 0;
  String? sectionAiMode;
  /// HTML guidance from API (`ai_hint`) for voice recording.
  String? sectionAiHint;

  /// Max voice recording length from API (`ai_voice_time`), in seconds.
  int? sectionAiVoiceTime;

  /// Question ids whose current value was last applied from voice/AI (cleared on manual edit).
  final Set<String> aiFilledQuestionIds = {};

  // Pagination variables for search
  bool isLastPageInSearch = false;
  bool isLoadingMoreForScrollInSearch = false;


  String deletePatientRecommendationId = '';
  deletePatientRecommendation(String patientId) async {
    // Set loading to true at the start
    emit(state.maybeMap(
      orElse: () => state,
      medicationSectionLoaded: (value) =>
          PatientSectionDetailsState.medicationSectionLoaded(
        value.response,
        value.changesCounter,
        '',
        '',
        value.isSubmitLoading,
        value.isSubmitLoaded,
        false,
        value.searchForDoseInMedicationSectionResponse,
        true,false,
      ),
    ));
    final result = await _deletePatientRecommendationUsecase.execute(
        DeletePatientRecommendationUsecaseInput(
            patientId: patientId,
            ids: [int.parse(deletePatientRecommendationId)]));

    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) =>
              PatientSectionDetailsState.medicationSectionLoaded(
            value.response,
            value.changesCounter,
            l.message,
            '',
            value.isSubmitLoading,
            value.isSubmitLoaded,
            false,
            value.searchForDoseInMedicationSectionResponse,
            false,false,
          ),
        ));
      },
      (deleteResponse) {
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) =>
              PatientSectionDetailsState.medicationSectionLoaded(
            value.response.copyWith(
                data: value.response.data
                    ?.where((element) =>
                        element.id != int.parse(deletePatientRecommendationId))
                    .toList()),
            value.changesCounter,
            deleteResponse.message ?? '',
            '',
            value.isSubmitLoading,
            value.isSubmitLoaded,
            false,
            value.searchForDoseInMedicationSectionResponse,
            false,false,
          ),
        ));
      },
    );

    deletePatientRecommendationId = '';
  }

  searchForDoseInMedicationSection(String dose) async {
    // Reset pagination for new search
    currentPageInSearch = 1;
    isLastPageInSearch = false;
    isLoadingMoreForScrollInSearch = false;
    

    
    emit(state.maybeMap(
      orElse: () => state,
      medicationSectionLoaded: (value) =>
          PatientSectionDetailsState.medicationSectionLoaded(
        value.response,
        value.changesCounter,
        '',
        '',
        value.isSubmitLoading,
        value.isSubmitLoaded,
        true,
        value.searchForDoseInMedicationSectionResponse,
        value.isDeletePatientRecommendationLoading,
        false,
      ),
    ));
    final result = await _searchForDoseInMedicationSectionUsecase.execute(
        SearchForDoseInMedicationSectionUsecaseInput(dose: dose, page: currentPageInSearch));
    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) =>
              PatientSectionDetailsState.medicationSectionLoaded(
            value.response,
            value.changesCounter,
            l.message,
            '',
            value.isSubmitLoading,
            value.isSubmitLoaded,
            false,
            value.searchForDoseInMedicationSectionResponse,
            value.isDeletePatientRecommendationLoading, false,
          ),
        ));
      },
      (medicationResponse) {
        // Check if this is the last page based on the initial response
        // If the response is empty or has very few items, it's likely the last page
        if (medicationResponse.data?.data == null || 
            medicationResponse.data!.data!.isEmpty) {
          isLastPageInSearch = true;
        }
        
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) =>
              PatientSectionDetailsState.medicationSectionLoaded(
            value.response,
            value.changesCounter,
            '',
            '',
            value.isSubmitLoading,
            value.isSubmitLoaded,
            false,
            medicationResponse,
            value.isDeletePatientRecommendationLoading,
            false,
          ),
        ));
      },
    );
  }
  int currentPageInSearch = 1;
   loadMoreSearchForDoseInMedicationSection(String dose) async {
    // Don't load more if we're already at the last page or currently loading
    if (isLoadingMoreForScrollInSearch || isLastPageInSearch) return;

    currentPageInSearch++;
    isLoadingMoreForScrollInSearch = true;
    
    emit(state.maybeMap(
      orElse: () => state,
      medicationSectionLoaded: (value) =>
          PatientSectionDetailsState.medicationSectionLoaded(
        value.response,
        value.changesCounter,
        '',
        '',
        value.isSubmitLoading,
        value.isSubmitLoaded,
        false, // Keep existing search results visible
        value.searchForDoseInMedicationSectionResponse,
        value.isDeletePatientRecommendationLoading,
        true, // Show loading more indicator
      ),
    ));
    final result = await _searchForDoseInMedicationSectionUsecase.execute(
        SearchForDoseInMedicationSectionUsecaseInput(dose: dose, page: currentPageInSearch));
    result.fold(
      (l) {
        currentPageInSearch--; // Roll back the page increment if the API call fails
        isLoadingMoreForScrollInSearch = false;
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) =>
              PatientSectionDetailsState.medicationSectionLoaded(
            value.response,
            value.changesCounter,
            l.message,
            '',
            value.isSubmitLoading,
            value.isSubmitLoaded,
            false,
            value.searchForDoseInMedicationSectionResponse,
            value.isDeletePatientRecommendationLoading,
            false,
          ),
        ));
      },
      (medicationResponse) {
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) {
            // Get existing search results
            final existingSearchResponse = value.searchForDoseInMedicationSectionResponse;
            
            // If we have existing results, append new data to it
            if (existingSearchResponse != null && 
                existingSearchResponse.data != null && 
                medicationResponse.data != null &&
                medicationResponse.data!.data != null) {
              
              // Get existing dose list
              final existingDoses = List<DoseModelInSearch>.from(existingSearchResponse.data!.data ?? []);
              // Get new dose list
              final newDoses = List<DoseModelInSearch>.from(medicationResponse.data!.data ?? []);
              
              // Combine the lists
              existingDoses.addAll(newDoses);
              
              // Create updated data model with combined doses
              final updatedDataModel = SearchForDoseInMedicationSectionDataModelResponse(
                data: existingDoses,
              );
              
              // Create updated response with combined data
              final updatedResponse = medicationResponse.copyWith(data: updatedDataModel);
              
              // Check if this is the last page based on response data
              // If the new response is empty, it's definitely the last page
              if (newDoses.isEmpty) {
                isLastPageInSearch = true;
              }
              
              isLoadingMoreForScrollInSearch = false;
              
              return PatientSectionDetailsState.medicationSectionLoaded(
                value.response,
                value.changesCounter,
                '',
                '',
                value.isSubmitLoading,
                value.isSubmitLoaded,
                false,
                updatedResponse,
                value.isDeletePatientRecommendationLoading,
                false,
              );
            } else {
              // If no existing results, just use the new response
              isLoadingMoreForScrollInSearch = false;
              
              return PatientSectionDetailsState.medicationSectionLoaded(
                value.response,
                value.changesCounter,
                '',
                '',
                value.isSubmitLoading,
                value.isSubmitLoaded,
                false,
                medicationResponse,
                value.isDeletePatientRecommendationLoading,
                false,
              );
            }
          },
        ));
      },
    );
  }



  void updateQuestionAnswer(String questionId, dynamic newAnswer) {
    // Create a new list from the existing list
    final updatedQuestionModelList =
        List<QuestionModel>.from(questionModelList);

    final questionIndex = updatedQuestionModelList
        .indexWhere((question) => question.id.toString() == questionId);
    if (questionIndex != -1) {
      updatedQuestionModelList[questionIndex] =
          updatedQuestionModelList[questionIndex].copyWith(answer: newAnswer);
      questionModelList =
          updatedQuestionModelList; // Replace the old list with the new list
      emit(PatientSectionDetailsState.loaded(
        updatedQuestionModelList,
        false,
        false,
        '',
        snackbarErrorCounter,
        false,
        false,
        0.0,
        false,
        false,
        false,
        counterChanges,
        false,
        false,
        '',
      ));
    }
  }

  getPatientSectionDetails(String sectionId, String patientId) async {
    sectionAiMode = null;
    sectionAiHint = null;
    sectionAiVoiceTime = null;
    formData.clear();
    emit(const PatientSectionDetailsState.loading());
    final result = await _getPatientSectionDetailsUsecase.execute(
        GetPatientSectionDetailsUsecaseInput(
            patientId: patientId, sectionId: sectionId));

    result.fold(
      (l) {
        sectionAiHint = null;
        sectionAiVoiceTime = null;
        emit(PatientSectionDetailsState.error(l.message));
      },
      (response) async {
        questionModelList =
            _hydrateRepeatableAnswersFromApi(response.data ?? []);
        sectionAiMode = response.aiMode?.trim().toLowerCase();
        sectionAiHint = response.aiHint;
        sectionAiVoiceTime = response.aiVoiceTime;
        aiFilledQuestionIds.clear();
        emit(PatientSectionDetailsState.loaded(
          questionModelList,
          false,
          false,
          '',
          0,
          false,
          false,
          0.0,
          false,
          false,
          false,
          counterChanges,
          false,
          false,
          '',
        ));
      },
    );
  }

  List<QuestionModel> _hydrateRepeatableAnswersFromApi(
      List<QuestionModel> questions) {
    return questions.map((question) {
      if (question.type?.trim() != AppStrings.questionTypeRepeatable) {
        return question;
      }

      final entries = RepeatableReadingEntry.listFromAnswer(question.answer);
      if (entries.isEmpty) return question;

      final payload = RepeatableReadingEntry.toApiPayload(entries);
      final id = question.id?.toString();
      if (id != null) {
        formData[id] = payload;
      }
      return question.copyWith(answer: payload);
    }).toList();
  }

  getMedicationSection(String patientId) async {
    emit(const PatientSectionDetailsState.loading());
    final result = await _getRecommendationsUsecase.execute(patientId);

    result.fold(
      (l) {
        emit(PatientSectionDetailsState.error(l.message));
      },
      (response) async {
        sectionAiMode = null;
        sectionAiHint = null;
        sectionAiVoiceTime = null;
        emit(PatientSectionDetailsState.medicationSectionLoaded(
          response,
          counterChanges,
          '',
          '',
          false,
          false,
          false,
          null,
          false,
          false,
        ));
      },
    );
  }

  updateScreen() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionDetailsState.loaded(
        value.questions,
        false,
        false,
        '',
        snackbarErrorCounter += 1,
        false,
        false,
        0.0,
        false,
        false,
        false,
        counterChanges,
        false,
        false,
        '',
      ),
    ));
  }

  updatePatientSectionDetails(String sectionId, String patientId) async {
    if (formData.isNotEmpty) {
      bool isValid = true;
      log(questionModelList.toString());

      for (var question in questionModelList) {
        // if (question.question == 'Hospital') {
        //   log(question.toString());
        // }
        if (question.mandatory == true) {
          if (question.type == 'multiple') {
            Map myMap = question.answer;

            // Check if "answers" key is either null or an empty list
            if (myMap.containsKey('answers')) {
              dynamic answersValue = myMap['answers'];

              if (answersValue == null ||
                  (answersValue is List && answersValue.isEmpty)) {
                debugPrint('"answers" key is either null or an empty list.');

                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    '${LocalizationService.instance.translate(AppStrings.youMustSelectAtLeastOneChoice)} \n{${question.question}}',
                    snackbarErrorCounter += 1,
                    false,
                    false,
                    0.0,
                    false,
                    false,
                    false,
                    counterChanges,
                    false,
                    false,
                    '',
                  ),
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
                loaded: (value) => PatientSectionDetailsState.loaded(
                  value.questions,
                  false,
                  false,
                  AppStrings.somethingWentWrong,
                  snackbarErrorCounter += 1,
                  false,
                  false,
                  0.0,
                  false,
                  false,
                  false,
                  counterChanges,
                  false,
                  false,
                  '',
                ),
              ));
              isValid = false;
              break;
            }

            if ((myMap['other_field'] == null ||
                    myMap['other_field'].toString().isEmpty) &&
                (myMap['answers'] as List).contains('Others')) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                  value.questions,
                  false,
                  false,
                  '${LocalizationService.instance.translate(AppStrings.youMustAddOthersFieldIn)} \n{${question.question}}',
                  snackbarErrorCounter += 1,
                  false,
                  false,
                  0.0,
                  false,
                  false,
                  false,
                  counterChanges,
                  false,
                  false,
                  '',
                ),
              ));

              isValid = false;
              break;
            }
          }

          if (question.type == AppStrings.selectType) {
            Map myMap = formData[question.id.toString()] ??= {
              AppStrings.answers: AppStrings.empty,
              AppStrings.otherField: AppStrings.empty,
            };

            if (myMap.containsKey(AppStrings.answers)) {
              dynamic answersValue = myMap[AppStrings.answers];
              if (answersValue == null || answersValue.toString().isEmpty) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    '${LocalizationService.instance.translate(AppStrings.youMustSelectAtLeastOneChoice)} \n{${question.question}}',
                    snackbarErrorCounter += 1,
                    false,
                    false,
                    0.0,
                    false,
                    false,
                    false,
                    counterChanges,
                    false,
                    false,
                    '',
                  ),
                ));

                isValid = false;
                break;
              }
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
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    LocalizationService.instance.translate(AppStrings.nameShouldContainOnlyEnglishLetters),
                    snackbarErrorCounter += 1,
                    false,
                    false,
                    0.0,
                    false,
                    false,
                    false,
                    counterChanges,
                    false,
                    false,
                    '',
                  ),
                ));

                isValid = false;
                break;
              }
            }
          }
          if (question.type == AppStrings.questionTypeString) {
            if (question.question == 'National ID') {
              String nationalID = question.answer;
              if (nationalID.length != 14) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    LocalizationService.instance.translate(AppStrings.nationalIDShouldHave14Digits),
                    snackbarErrorCounter += 1,
                    false,
                    false,
                    0.0,
                    false,
                    false,
                    false,
                    counterChanges,
                    false,
                    false,
                    '',
                  ),
                ));

                isValid = false;
                break;
              }
              if (int.tryParse(nationalID) == null) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    LocalizationService.instance.translate(AppStrings.nationalIDShouldHave14Digits),
                    snackbarErrorCounter += 1,
                    false,
                    false,
                    0.0,
                    false,
                    false,
                    false,
                    counterChanges,
                    false,
                    false,
                    '',
                  ),
                ));

                isValid = false;
                break;
              }
            }

            if (question.question == 'Age') {
              String age = question.answer;

              if (int.tryParse(age) == null ||
                  (int.parse(age) > 119 || int.parse(age) <= 0)) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    LocalizationService.instance.translate(AppStrings.ageShouldBeLessThan120),
                    snackbarErrorCounter += 1,
                    false,
                    false,
                    0.0,
                    false,
                    false,
                    false,
                    counterChanges,
                    false,
                    false,
                    '',
                  ),
                ));

                isValid = false;
                break;
              }
            }

            if (question.question == 'Phone') {
              String phoneNumber = question.answer;

              if (phoneNumber.length != 11) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    LocalizationService.instance.translate(AppStrings.phoneShouldHave11Digits),
                    snackbarErrorCounter += 1,
                    false,
                    false,
                    0.0,
                    false,
                    false,
                    false,
                    counterChanges,
                    false,
                    false,
                    '',
                  ),
                ));
                isValid = false;
                break;
              }

              if (int.tryParse(phoneNumber) == null) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    LocalizationService.instance.translate(AppStrings.phoneShouldHave11Digits),
                    snackbarErrorCounter += 1,
                    false,
                    false,
                    0.0,
                    false,
                    false,
                    false,
                    counterChanges,
                    false,
                    false,
                    '',
                  ),
                ));
                isValid = false;
                break;
              }
            }
          }
          if (question.type == AppStrings.questionTypeRepeatable) {
            final answer = question.answer;
            final isEmpty = answer == null ||
                (answer is List && answer.isEmpty);
            if (isEmpty) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                  value.questions,
                  false,
                  false,
                  '${LocalizationService.instance.translate(AppStrings.thisQuestionIsRequired)} \n{${question.question}}',
                  snackbarErrorCounter += 1,
                  false,
                  false,
                  0.0,
                  false,
                  false,
                  false,
                  counterChanges,
                  false,
                  false,
                  '',
                ),
              ));
              isValid = false;
              break;
            }
            continue;
          }

          if (question.answer == null || question.answer == '') {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => PatientSectionDetailsState.loaded(
                value.questions,
                false,
                false,
                '${LocalizationService.instance.translate(AppStrings.thisQuestionIsRequired)} \n{${question.question}}',
                snackbarErrorCounter += 1,
                false,
                false,
                0.0,
                false,
                false,
                false,
                counterChanges,
                false,
                false,
                '',
              ),
            ));

            isValid = false;
            break;
          }
        }
      }

      if (isValid == true) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionDetailsState.loaded(
            value.questions,
            true,
            false,
            '',
            snackbarErrorCounter += 1,
            false,
            false,
            0.0,
            false,
            false,
            false,
            counterChanges,
            false,
            false,
            '',
          ),
        ));

        final result = await _updatePatientSectionDetailsUsecase.execute(
            UpdatePatientSectionDetailsUsecaseInput(
                patientId: patientId, sectionId: sectionId, map: formData));

        result.fold(
          (l) {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => PatientSectionDetailsState.loaded(
                value.questions,
                false,
                false,
                l.message,
                snackbarErrorCounter += 1,
                false,
                false,
                0.0,
                false,
                false,
                false,
                counterChanges,
                false,
                false,
                '',
              ),
            ));
          },
          (response) async {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => PatientSectionDetailsState.loaded(
                value.questions,
                false,
                true,
                response.message.toString(),
                snackbarErrorCounter += 1,
                false,
                false,
                0.0,
                false,
                false,
                false,
                counterChanges,
                false,
                false,
                '',
              ),
            ));
          },
        );
      } else {}
    } else {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => PatientSectionDetailsState.loaded(
          value.questions,
          false,
          false,
          LocalizationService.instance.translate(AppStrings.youShouldUpdateAnyDataToSubmit),
          snackbarErrorCounter += 1,
          false,
          false,
          0.0,
          false,
          false,
          false,
          counterChanges,
          false,
          false,
          '',
        ),
      ));
    }
  }

  removeAllFilesInFilesQuestion({
    required String patientId,
    required String sectionId,
    required String questionId,
  }) async {
    // Emit loading state to update UI immediately
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionDetailsState.loaded(
        value.questions,
        value.isSubmitLoading,
        value.isSubmitted,
        '',
        snackbarErrorCounter += 1,
        value.isChooseFilesLoading,
        value.isChooseFilesLoaded,
        0.0,
        false,
        false,
        false,
        counterChanges,
        false,
        false,
        '',
      ),
    ));

    // Remove the files from formData
    formData.remove(questionId);

    // Update questionModelList by assigning the result of map back to the list
    questionModelList = questionModelList.map((question) {
      if (question.id.toString() == questionId) {
        // Clear the answer list for the matched question
        return question.copyWith(answer: []);
      }
      return question;
    }).toList();

    // Emit the updated state with the modified questionModelList
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionDetailsState.loaded(
        questionModelList, // Pass the updated list
        value.isSubmitLoading,
        value.isSubmitted,
        '',
        snackbarErrorCounter += 1,
        value.isChooseFilesLoading,
        value.isChooseFilesLoaded,
        0.0, false,
        false,
        false,
        counterChanges,
        false,
        false,
        '',
      ),
    ));

    // Optional API call to update the backend
    final getResponse = await _updatePatientSectionDetailsUsecase.execute(
      UpdatePatientSectionDetailsUsecaseInput(
        patientId: patientId,
        sectionId: sectionId,
        map: {questionId: []},
      ),
    );

    getResponse.fold(
      (l) {
        // Handle failure if needed
      },
      (r) {
        // Handle success if needed
      },
    );
  }

  String questionIndexWhichDoctorClicked = '';
  pickFilesForQuestions(
      int questionIndex, String patientId, String sectionId, context) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionDetailsState.loaded(
        value.questions,
        value.isSubmitLoading,
        value.isSubmitted,
        '',
        snackbarErrorCounter += 1,
        true,
        false,
        0.0,
        false,
        false,
        false,
        counterChanges,
        false,
        false,
        '',
      ),
    ));

    // Pick multiple files
    FilePickerResult? result;
    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      List<Map<String, String>> filesList = [];
      int totalSizeInBytes = 0;

      // Validate each file
      for (var pickedFile in result.files) {
        File file = File(pickedFile.path!);
        int fileSize = await file.length(); // Size in bytes
        double fileSizeInMB = fileSize / (1024 * 1024); // Convert to MB

        // Check if individual file exceeds 1MB
        if (fileSizeInMB > 2) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionDetailsState.loaded(
              value.questions,
              value.isSubmitLoading,
              value.isSubmitted,
              '${LocalizationService.instance.translate(AppStrings.file)} ${pickedFile.name} ${LocalizationService.instance.translate(AppStrings.exceedsThe2MBLimit)}',
              snackbarErrorCounter += 1,
              false,
              false,
              0.0,
              false,
              false,
              false,
              counterChanges,
              false,
              false,
              '',
            ),
          ));
          return;
        }

        // Add file size to the total
        totalSizeInBytes += fileSize;
      }

      // Check if total size exceeds 5MB
      double totalSizeInMB =
          totalSizeInBytes / (1024 * 1024); // Convert total to MB
      if (totalSizeInMB > 10) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionDetailsState.loaded(
            value.questions,
            value.isSubmitLoading,
            value.isSubmitted,
            LocalizationService.instance.translate(AppStrings.totalSizeOfSelectedFilesExceeds10MB),
            snackbarErrorCounter += 1,
            false,
            false,
            0.0,
            false,
            false,
            false,
            counterChanges,
            false,
            false,
            '',
          ),
        ));
        return;
      }

      // Process valid files
      for (var pickedFile in result.files) {
        File file = File(pickedFile.path!);
        String fileName = pickedFile.name;

        // Check if the file is an image by verifying the extension
        if (fileName.endsWith('.jpg') ||
            fileName.endsWith('.jpeg') ||
            fileName.endsWith('.png') ||
            fileName.endsWith('.gif') ||
            fileName.endsWith('.bmp') ||
            fileName.endsWith('.tiff') ||
            fileName.endsWith('.webp')) {
          // Read the image from the file
          img.Image? image = img.decodeImage(file.readAsBytesSync());

          if (image != null) {
            // Compress the image by reducing its quality to 50%
            List<int> compressedImageBytes = img.encodeJpg(image, quality: 40);

            // Base64 encode the compressed image
            String fileData = base64Encode(compressedImageBytes);

            filesList.add({"file_name": fileName, "file_data": fileData});
          }
        } else {
          // For non-image files, just read them as normal
          String fileData = base64Encode(await file.readAsBytes());
          filesList.add({"file_name": fileName, "file_data": fileData});
        }
      }

      // Store files in formData
      formData[questionModelList[questionIndex].id.toString()] = filesList;

      log(formData[questionModelList[questionIndex].id.toString()].toString());
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => PatientSectionDetailsState.loaded(
          value.questions,
          value.isSubmitLoading,
          value.isSubmitted,
          '',
          snackbarErrorCounter += 1,
          false,
          true,
          0.0,
          false,
          false,
          false,
          counterChanges,
          false,
          false,
          '',
        ),
      ));

      // Show dialog with no dismiss while uploading
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing the dialog
        builder: (BuildContext context) {
          return  Dialog(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text(LocalizationService.instance.translate(AppStrings.uploadingFiles)),
                ],
              ),
            ),
          );
        },
      );

      // API call to upload files
      final getResponse = await _updatePatientSectionDetailsUsecase.execute(
          UpdatePatientSectionDetailsUsecaseInput(
              patientId: patientId, sectionId: sectionId, map: formData));
      getResponse.fold(
        (l) {
          Navigator.pop(context);
          customSnackBar(context: context, message: l.message);
        },
        (response) async {
          Navigator.pop(context);
          customSnackBar(
              context: context, message: response.message.toString());
        },
      );
    }

    // Reset state after processing
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionDetailsState.loaded(
        value.questions,
        value.isSubmitLoading,
        value.isSubmitted,
        '',
        snackbarErrorCounter += 1,
        false,
        false,
        0.0,
        false,
        false,
        false,
        counterChanges,
        false,
        false,
        '',
      ),
    ));
  }

// Add these methods to your cubit:
  String getCurrentWholeValue(int index) {
    final current = questionModelList[index].answer ?? 0.0;
    if (current is double) return current.toString().split('.')[0];
    if (current is String)
      return double.tryParse(current)?.toString().split('.')[0] ?? '0';
    return '0';
  }

  String getCurrentDecimalValue(int index) {
    final current = questionModelList[index].answer ?? 0.0;
    if (current is double) {
      final parts = current.toString().split('.');
      return parts.length > 1
          ? parts[1].padRight(2, '0').substring(0, 2)
          : '00';
    }
    if (current is String) {
      final parsed = double.tryParse(current);
      if (parsed != null) {
        final parts = parsed.toString().split('.');
        return parts.length > 1
            ? parts[1].padRight(2, '0').substring(0, 2)
            : '00';
      }
    }
    return '00';
  }

  void addPatientRecommendation(
      PatientRecommendationModel medication, String patientId) async {
    // Show loading state
    emit(state.maybeMap(
      orElse: () => state,
      medicationSectionLoaded: (value) =>
          PatientSectionDetailsState.medicationSectionLoaded(
        value.response,
        value.changesCounter,
        '',
        '',
        true, // Set loading to true
        value.isSubmitLoaded,
        value.isSearchMedicationLoading,
        value.searchForDoseInMedicationSectionResponse,
        value.isDeletePatientRecommendationLoading,
        false,
      ),
    ));

    // Prepare the request body
    final Map<String, dynamic> body = {
      'recommendations': [
        {
          'dose_name': medication.doseName,
          'dose': medication.dose,
          'route': medication.route,
          'frequency': medication.frequency,
          'duration': medication.duration,
          'type': medication.type,
          'content': medication.content,
        }
      ],
    };

    // Call the API
    final result = await _createRecommendationsUsecase.execute(
      CreateRecommendationsUsecaseInput(
        patientId: patientId,
        body: body,
      ),
    );

    result.fold(
      (failure) {
        // Handle failure
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) =>
              PatientSectionDetailsState.medicationSectionLoaded(
            value.response,
            value.changesCounter,
            failure.message,
            '',
            false,
            value.isSubmitLoaded,
            value.isSearchMedicationLoading,
            value.searchForDoseInMedicationSectionResponse,
            value.isDeletePatientRecommendationLoading, 
            false,
          ),
        ));
      },
      (response) {
        // Handle success
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) {
            final updatedData = List<GetRecommendationsDataModelResponse>.from(
                value.response.data ?? []);
            
            // Use the actual data from the API response if available
            if (response.data != null && response.data!.isNotEmpty) {
              // Add the newly created recommendation with the actual ID from the API
              updatedData.insertAll(0, response.data!);
            } else {
              // Fallback to creating a new recommendation with the temporary ID
              final newMedication = GetRecommendationsDataModelResponse(
                id: int.tryParse(medication.id),
                doseName: medication.doseName,
                dose: medication.dose,
                route: medication.route,
                frequency: medication.frequency,
                duration: medication.duration,
                type: medication.type,
                content: medication.content,
              );
              updatedData.insert(0, newMedication);
            }
            
            return PatientSectionDetailsState.medicationSectionLoaded(
              value.response.copyWith(data: updatedData),
              value.changesCounter + 1,
              response.message ?? '',
              '',
              false,
              value.isSubmitLoaded,
              value.isSearchMedicationLoading,
              value.searchForDoseInMedicationSectionResponse,
              value.isDeletePatientRecommendationLoading,
              false,
            );
          },
        ));
      },
    );
  }

  void updatePatientRecommendation(
    PatientRecommendationModel medication,
    String patientId,
  ) async {
    // Show loading state
    emit(state.maybeMap(
      orElse: () => state,
      medicationSectionLoaded: (value) =>
          PatientSectionDetailsState.medicationSectionLoaded(
        value.response,
        value.changesCounter,
        '',
        '',
        true, // Set loading to true
        value.isSubmitLoaded,
        value.isSearchMedicationLoading,
        value.searchForDoseInMedicationSectionResponse,
        value.isDeletePatientRecommendationLoading,
        false,
      ),
    ));

    // Prepare the request body
    final Map<String, dynamic> body = {
      'recommendations': [
        {
          'id': int.parse(medication.id),
          'dose_name': medication.doseName,
          'dose': medication.dose,
          'route': medication.route,
          'frequency': medication.frequency,
          'duration': medication.duration,
          'type': medication.type,
          'content': medication.content,
        }
      ],
    };

    // Call the API
    final result = await _updateRecommendationUsecase.execute(
      UpdatePatientRecommendationUsecaseInput(
        patientId: patientId,
        body: body,
      ),
    );

    result.fold(
      (failure) {
        // Handle failure
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) =>
              PatientSectionDetailsState.medicationSectionLoaded(
            value.response,
            value.changesCounter,
            failure.message,
            '',
            false,
            value.isSubmitLoaded,
            value.isSearchMedicationLoading,
            value.searchForDoseInMedicationSectionResponse,
            value.isDeletePatientRecommendationLoading,
            false,
          ),
        ));
      },
      (response) {
        // Handle success
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) {
            // Update the existing medication in the list
            final updatedData = List<GetRecommendationsDataModelResponse>.from(
                value.response.data ?? []);
            final index = updatedData.indexWhere(
                (element) => element.id == int.parse(medication.id));
            
            if (index != -1) {
              updatedData[index] = GetRecommendationsDataModelResponse(
                id: int.parse(medication.id),
                doseName: medication.doseName,
                dose: medication.dose,
                route: medication.route,
                frequency: medication.frequency,
                duration: medication.duration,
                type: medication.type,
                content: medication.content,
              );
            }

            return PatientSectionDetailsState.medicationSectionLoaded(
              value.response.copyWith(data: updatedData),
              value.changesCounter + 1,
              response.message ?? '',
              '',
              false,
              value.isSubmitLoaded,
              value.isSearchMedicationLoading,
              value.searchForDoseInMedicationSectionResponse,
              value.isDeletePatientRecommendationLoading,
              false,
            );
          },
        ));
      },
    );
  }

  Future<bool> createNewMedicine(
    String title,
    String description,
    String dose,
  ) async {
    // Show loading state
    emit(state.maybeMap(
      orElse: () => state,
      medicationSectionLoaded: (value) =>
          PatientSectionDetailsState.medicationSectionLoaded(
        value.response,
        value.changesCounter,
        '',
        '',
        true, // Set loading to true
        value.isSubmitLoaded,
        value.isSearchMedicationLoading,
        value.searchForDoseInMedicationSectionResponse,
        value.isDeletePatientRecommendationLoading,
        false,
      ),
    ));

    // Call the API
    final result = await _createNewMedicineUsecase.execute(
      CreateNewMedicineUsecaseInput(
        title: title,
        description: description,
        dose: dose,
      ),
    );

    return result.fold(
      (failure) {
        // Handle failure
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) =>
              PatientSectionDetailsState.medicationSectionLoaded(
            value.response,
            value.changesCounter,
            failure.message,
            '',
            false,
            value.isSubmitLoaded,
            value.isSearchMedicationLoading,
            value.searchForDoseInMedicationSectionResponse,
            value.isDeletePatientRecommendationLoading,
            false,
          ),
        ));
        return false; // Return false for failure
      },
      (response) {
        // Handle success
        emit(state.maybeMap(
          orElse: () => state,
          medicationSectionLoaded: (value) {
          
            return PatientSectionDetailsState.medicationSectionLoaded(
              value.response,
              value.changesCounter + 1,
              response.message ?? '',
              '',
              false,
              value.isSubmitLoaded,
              value.isSearchMedicationLoading,
              value.searchForDoseInMedicationSectionResponse,
              value.isDeletePatientRecommendationLoading,
              false,
            );
          },
        ));
        return true; // Return true for success
      },
    );
  }

  dynamic _normalizeVoiceAnswer(QuestionModel question, dynamic value) {
    if (question.type == AppStrings.multipleType) {
      if (value is Map<String, dynamic>) return value;
      if (value is List) {
        return {
          AppStrings.answers: value,
          AppStrings.otherField: AppStrings.empty,
        };
      }
      if (value is String && value.trim().isNotEmpty) {
        return {
          AppStrings.answers: value.split(',').map((e) => e.trim()).toList(),
          AppStrings.otherField: AppStrings.empty,
        };
      }
    }

    if (question.type == AppStrings.questionTypeSelect) {
      if (value is Map<String, dynamic>) return value;
      return {
        AppStrings.answers: value,
        AppStrings.otherField: AppStrings.empty,
      };
    }

    return value;
  }

  bool _hasDisplayableAiAnswer(QuestionModel question, dynamic value) {
    if (value == null) return false;

    if (question.type == AppStrings.questionTypeSelect) {
      return selectQuestionHasDisplayableAnswer(
        optionValues: question.values,
        storedAnswer: value,
      );
    }

    if (question.type == AppStrings.questionTypeMultiple) {
      if (value is Map) {
        final answers = value[AppStrings.answers];
        if (answers is List) return answers.isNotEmpty;
        if (answers is String) return answers.trim().isNotEmpty;
        return answers != null;
      }
      if (value is List) return value.isNotEmpty;
      if (value is String) return value.trim().isNotEmpty;
      return false;
    }

    if (value is String) return value.trim().isNotEmpty;
    if (value is Map) return value.isNotEmpty;
    if (value is List) return value.isNotEmpty;
    return true;
  }

  void applyVoiceAnswers(Map<String, dynamic> answersMap) {
    if (questionModelList.isEmpty) return;
    final updatedQuestionModelList = List<QuestionModel>.from(questionModelList);

    for (var i = 0; i < updatedQuestionModelList.length; i++) {
      final question = updatedQuestionModelList[i];
      final idKey = question.id.toString();
      final textKey = (question.question ?? '').trim().toLowerCase();
      dynamic value = answersMap[idKey];
      value ??= answersMap[textKey];
      if (value == null) continue;

      final normalizedValue = _normalizeVoiceAnswer(question, value);
      formData[idKey] = normalizedValue;
      updatedQuestionModelList[i] = question.copyWith(answer: normalizedValue);
      if (_hasDisplayableAiAnswer(question, normalizedValue)) {
        aiFilledQuestionIds.add(idKey);
      } else {
        aiFilledQuestionIds.remove(idKey);
      }
    }
    questionModelList = updatedQuestionModelList;

    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionDetailsState.loaded(
        updatedQuestionModelList,
        value.isSubmitLoading,
        value.isSubmitted,
        value.message,
        snackbarErrorCounter + 1,
        value.isChooseFilesLoading,
        value.isChooseFilesLoaded,
        value.uploadFilesProgress,
        value.isGetMedicationsLoading,
        value.isGetMedicationsLoaded,
        value.isSearchMedicationLoading,
        counterChanges + 1,
        value.isCreateMedicationLoading,
        value.isCreateMedicationLoaded,
        value.dialogMessage,
      ),
    ));
  }

  void clearAiFilledMark(String questionId) {
    if (!aiFilledQuestionIds.remove(questionId)) return;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionDetailsState.loaded(
        value.questions,
        value.isSubmitLoading,
        value.isSubmitted,
        value.message,
        value.snackbarErrorCounter + 1,
        value.isChooseFilesLoading,
        value.isChooseFilesLoaded,
        value.uploadFilesProgress,
        value.isGetMedicationsLoading,
        value.isGetMedicationsLoaded,
        value.isSearchMedicationLoading,
        counterChanges,
        value.isCreateMedicationLoading,
        value.isCreateMedicationLoaded,
        value.dialogMessage,
      ),
    ));
  }
}
