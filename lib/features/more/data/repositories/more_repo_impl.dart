import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/more/data/datasource/more_datasource.dart';
import 'package:egy_akin/features/more/data/models/change_language_model_response.dart';
import 'package:egy_akin/features/more/domain/repositories/more_repo.dart';

import '../../../../exports.dart';

class MoreRepositoryImpl extends MoreRepository {
  final MoreDataSource moreDataSource;
  final NetworkInfo networkInfo;

  MoreRepositoryImpl(this.moreDataSource, this.networkInfo);



  @override
  Future<Either<Failure, ChangeLanguageModelResponse>> changeLanguage(String local) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await moreDataSource.changeLanguage(local);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }


}
