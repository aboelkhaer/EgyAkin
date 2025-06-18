import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:egy_akin/app/constants/app_strings.dart';
import 'package:egy_akin/app/utilities/custom_snack_bar.dart';
import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:egy_akin/features/patient_section_details/data/models/patient_recommendation_model.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_recommendations_model_response.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/create_new_medicine_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/create_recommendations_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/delete_patient_recommendation_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/get_patient_section_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/get_recommendations_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/search_for_dose_in_medication_section_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/update_patient_recommendation_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/update_patient_section_details_usecase.dart';
import 'package:egy_akin/features/patient_section_details/presentation/cubit/patient_section_details_state.dart';
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



  String deletePatientRecommendationId = '';
  deletePatientRecommendation(String patientId) async {
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
        value.isSearchMedicationLoading,
        value.searchForDoseInMedicationSectionResponse,
        true,
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
            false,
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
            false,
          ),
        ));
      },
    );

    deletePatientRecommendationId = '';
  }

  searchForDoseInMedicationSection(String dose) async {
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
      ),
    ));
    final result = await _searchForDoseInMedicationSectionUsecase.execute(
        SearchForDoseInMedicationSectionUsecaseInput(dose: dose, page: 1));
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
            value.isDeletePatientRecommendationLoading,
          ),
        ));
      },
      (medicationResponse) {
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
          ),
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
    emit(const PatientSectionDetailsState.loading());
    final result = await _getPatientSectionDetailsUsecase.execute(
        GetPatientSectionDetailsUsecaseInput(
            patientId: patientId, sectionId: sectionId));

    result.fold(
      (l) {
        emit(PatientSectionDetailsState.error(l.message));
      },
      (response) async {
        questionModelList = response.data!;
        emit(PatientSectionDetailsState.loaded(
          response.data!,
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

  getMedicationSection(String patientId) async {
    emit(const PatientSectionDetailsState.loading());
    final result = await _getRecommendationsUsecase.execute(patientId);

    result.fold(
      (l) {
        emit(PatientSectionDetailsState.error(l.message));
      },
      (response) async {
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
                    'You must select at least one choice. \n{${question.question}}',
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
                  'You must add "Others" field in \n{${question.question}}',
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
            if (question.answer['answers'] == null ||
                question.answer['answers'] == '') {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                  value.questions,
                  false,
                  false,
                  'This question is required \n{${question.question}}',
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
                    'Name should contain only English letters',
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
              log('moatz123 $nationalID');
              if (nationalID.length != 14) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    'National ID should have 14 digits',
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
                    'National ID should have 14 digits',
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
                    'Age should be less than 120',
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
                    'Phone should have 11 digits',
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
                    'Phone should have 11 digits',
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
          if (question.answer == null || question.answer == '') {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => PatientSectionDetailsState.loaded(
                value.questions,
                false,
                false,
                'This question is required \n{${question.question}}',
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
          'You should update any data to submit.',
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
              'File ${pickedFile.name} exceeds the 2MB limit.',
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
            'Total size of selected files exceeds 10MB.',
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
          return const Dialog(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text("Uploading files..."),
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
            final newMedication = GetRecommendationsDataModelResponse(
              id: int.tryParse(medication.id),
              doseName: medication.doseName,
              dose: medication.dose,
              route: medication.route,
              frequency: medication.frequency,
              duration: medication.duration,
            );
            updatedData.insert(0, newMedication);
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
            );
          },
        ));
      },
    );
  }

  void createNewMedicine(
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
          ),
        ));
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
            );
          },
        ));
      },
    );
  }
}
