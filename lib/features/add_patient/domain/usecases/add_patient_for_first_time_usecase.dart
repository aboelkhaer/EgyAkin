import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class AddPatientForFirstTimetUsecase
    implements
        BaseUseCase<Map<String, dynamic>, AddPatientForFirstTimeModelResponse> {
  final AddPatientRepository repository;

  AddPatientForFirstTimetUsecase(this.repository);

  @override
  Future<Either<Failure, AddPatientForFirstTimeModelResponse>> excute(
    Map<String, dynamic> map,
  ) async {
    return await repository.addPatientForFirstTime(map: map);
  }
}
