import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctor_posts/data/datasources/all_doctor_posts_datasource.dart';
import 'package:egy_akin/features/all_doctor_posts/data/models/get_all_doctor_posts_model_response.dart';
import 'package:egy_akin/features/all_doctor_posts/domain/repositories/all_doctor_posts_repo.dart';
import '../../../../exports.dart';

class AllDoctorPostsRepositoryImpl extends AllDoctorPostsRepository {
  final AllDoctorPostsDatasource allDoctorPostsDatasource;
  final NetworkInfo networkInfo;

  AllDoctorPostsRepositoryImpl(this.allDoctorPostsDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetAllDoctorPostsModelResponse>> getAllDoctorPosts(
      String doctorId, int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await allDoctorPostsDatasource.getAllDoctorPosts(doctorId, page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
