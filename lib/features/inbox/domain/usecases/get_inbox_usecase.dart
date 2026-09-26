import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/inbox/data/models/get_inbox_model_response.dart';
import 'package:egy_akin/features/inbox/domain/repositories/inbox_repo.dart';

import '../../../../exports.dart';

class GetInboxUsecase
    implements BaseUseCase<GetInboxParams, GetInboxModelResponse> {
  final InboxRepository repository;

  GetInboxUsecase(this.repository);

  @override
  Future<Either<Failure, GetInboxModelResponse>> execute(
      GetInboxParams input) {
    return repository.getInbox(
      filter: input.filter,
      page: input.page,
      perPage: input.perPage,
      archived: input.archived,
    );
  }
}

class GetInboxParams {
  final String filter;
  final int page;
  final int perPage;
  final int? archived;

  const GetInboxParams({
    required this.filter,
    required this.page,
    this.perPage = 20,
    this.archived,
  });
}
