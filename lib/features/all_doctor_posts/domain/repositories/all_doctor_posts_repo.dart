
import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AllDoctorPostsRepository {
  Future<Either<Failure, GetAllDoctorPostsModelResponse>> getAllDoctorPosts(
    String doctorId,
    int page,
  );
}
