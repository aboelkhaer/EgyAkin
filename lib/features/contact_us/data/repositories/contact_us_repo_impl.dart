import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class ContactUsRepositoryImpl extends ContactUsRepository {
  final ContactUsDataSource contactUsDataSource;
  final NetworkInfo networkInfo;

  ContactUsRepositoryImpl(this.contactUsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ContactUsModelResponseModelResponse>> addContactUs(
      String message) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await contactUsDataSource.addContactUs(message);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
