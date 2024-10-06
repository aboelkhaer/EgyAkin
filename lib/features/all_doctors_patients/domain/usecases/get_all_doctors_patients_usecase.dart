import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetAllDoctorsPatientsUsecase
    implements BaseUseCase<int, GetAllDoctorsPatientsModelResponse> {
  final AllDoctorsPatientsRepository repository;

  GetAllDoctorsPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllDoctorsPatientsModelResponse>> execute(
      int page) async {
    return await repository.getAllDoctorsPatients(page);
  }
}
