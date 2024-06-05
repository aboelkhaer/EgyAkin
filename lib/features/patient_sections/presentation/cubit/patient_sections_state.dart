import 'package:egy_akin/app/app_models/responses/get_patient_data_model.dart';
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'patient_sections_state.freezed.dart';

@freezed
abstract class PatientSectionsState with _$PatientSectionsState {
  const factory PatientSectionsState.initial() = _Initial;
  const factory PatientSectionsState.loading() = _Loading;
  const factory PatientSectionsState.loaded(
      GetPatientSectionsModelResponse response,
      bool isDelete,
      bool isFinalSubmit,
      String message,
      bool isLoading) = _Loaded;

  const factory PatientSectionsState.error(String message) = _Error;
}
