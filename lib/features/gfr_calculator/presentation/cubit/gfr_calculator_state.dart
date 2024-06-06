import 'package:freezed_annotation/freezed_annotation.dart';
part 'gfr_calculator_state.freezed.dart';

@freezed
abstract class GfrCalculatorState with _$GfrCalculatorState {
  const factory GfrCalculatorState.initial() = _Initial;
  const factory GfrCalculatorState.loading() = _Loading;
  const factory GfrCalculatorState.loaded() = _Loaded;
  const factory GfrCalculatorState.error(String message) = _Error;
}
