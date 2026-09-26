import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/inbox/data/models/get_inbox_model_response.dart';

import '../../../../exports.dart';

abstract class InboxRepository {
  Future<Either<Failure, GetInboxModelResponse>> getInbox({
    required String filter,
    required int page,
    int perPage = 20,
    int? archived,
  });
}
