import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AddPatientRepository {
  Future<Either<Failure, GetPatientHistoryForAddPatientModelResponse>>
      getPatientHistoryForAddPatient({
    required String sectionId,
  });
  Future<Either<Failure, AddPatientForFirstTimeModelResponse>>
      addPatientForFirstTime({
    required Map<String, dynamic> map,
  });
}
