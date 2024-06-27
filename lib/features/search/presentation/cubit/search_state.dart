import 'package:egy_akin/features/home/data/models/home_model_response.dart';
import 'package:egy_akin/features/search/data/models/get_search_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_state.freezed.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded(List<PatientHomeDataModel>? patients,
      List<SearchDataForDosesModelResponse>? doses) = _Loaded;

  const factory SearchState.error(String message) = _Error;
}
