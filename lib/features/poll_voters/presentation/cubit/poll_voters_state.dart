import 'package:egy_akin/features/community/data/models/get_poll_voters_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'poll_voters_state.freezed.dart';

@freezed
abstract class PollVotersState with _$PollVotersState {
  const factory PollVotersState.initial() = _Initial;
  const factory PollVotersState.loading() = _Loading;
  const factory PollVotersState.loaded(
    GetPollVotersModelResponse response,
    String snackBarMessage,
    String dialogMessage,
    bool isSeeMore,
    int changeCounter,
  ) = _Loaded;

  const factory PollVotersState.error(String message) = _Error;
}
