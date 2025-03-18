import 'package:egy_akin/features/all_doctor_posts/data/models/get_all_doctor_posts_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AllDoctorPostsRepository {
  Future<Either<Failure, GetAllDoctorPostsModelResponse>> getAllDoctorPosts(
    String doctorId,
    int page,
  );
}
