import 'package:egy_akin/features/chat_room/presentation/cubit/chat_room_state.dart';

import '../../../../exports.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(const ChatRoomState.initial());
}
