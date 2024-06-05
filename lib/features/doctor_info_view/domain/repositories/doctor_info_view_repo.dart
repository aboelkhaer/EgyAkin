import 'package:egy_akin/features/doctor_info_view/data/models/doctor_info_view_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorInfoViewRepository {
  Future<Either<Failure, DoctorInfoViewModelResponse>> getDoctorInfo(
      String doctorId);
}
