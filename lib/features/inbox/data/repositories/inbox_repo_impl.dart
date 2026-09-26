import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/inbox/data/datasources/inbox_datasource.dart';
import 'package:egy_akin/features/inbox/data/models/get_inbox_model_response.dart';
import 'package:egy_akin/features/inbox/domain/repositories/inbox_repo.dart';

import '../../../../exports.dart';

class InboxRepositoryImpl extends InboxRepository {
  final InboxDataSource inboxDataSource;
  final NetworkInfo networkInfo;

  InboxRepositoryImpl(this.inboxDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetInboxModelResponse>> getInbox({
    required String filter,
    required int page,
    int perPage = 20,
    int? archived,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await inboxDataSource.getInbox(
          filter: filter,
          page: page,
          perPage: perPage,
          archived: archived,
        );
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
