import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inbox_member_search_state.freezed.dart';

@freezed
class InboxMemberSearchState with _$InboxMemberSearchState {
  const factory InboxMemberSearchState.initial() = _Initial;
  const factory InboxMemberSearchState.hint() = _Hint;
  const factory InboxMemberSearchState.loading() = _Loading;
  const factory InboxMemberSearchState.loaded({
    required List<ChatUserModel> users,
  }) = _Loaded;
  const factory InboxMemberSearchState.empty() = _Empty;
  const factory InboxMemberSearchState.error(String message) = _Error;
}
