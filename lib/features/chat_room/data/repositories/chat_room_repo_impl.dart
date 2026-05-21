import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/chat_room/data/datasources/chat_room_datasource.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import '../../../../exports.dart';

class ChatRoomRepositoryImpl extends ChatRoomRepository {
  final ChatRoomDataSource chatRoomRemoteDataSource;
  final NetworkInfo networkInfo;

  ChatRoomRepositoryImpl(this.chatRoomRemoteDataSource, this.networkInfo);
}
