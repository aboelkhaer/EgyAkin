import 'package:freezed_annotation/freezed_annotation.dart';
part 'contact_us_state.freezed.dart';

@freezed
abstract class ContactUsState with _$ContactUsState {
  const factory ContactUsState.initial() = _Initial;
  const factory ContactUsState.loading() = _Loading;

  const factory ContactUsState.loaded(String message) = _Loaded;
  const factory ContactUsState.error(String message) = _Error;
}
