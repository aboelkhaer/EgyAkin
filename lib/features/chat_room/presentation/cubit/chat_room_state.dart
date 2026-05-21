import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat_room_state.freezed.dart';

@freezed
abstract class ChatRoomState with _$ChatRoomState {
  const factory ChatRoomState.initial() = _Initial;
  const factory ChatRoomState.loading() = _Loading;

  const factory ChatRoomState.loaded() = _Loaded;
  const factory ChatRoomState.error(String message) = _Error;
}
