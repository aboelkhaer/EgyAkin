import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/marked_patients/data/models/get_marked_patients_model_response.dart';
import 'package:egy_akin/features/marked_patients/domain/repositories/marked_patients_repo.dart';
import '../../../../exports.dart';

class GetMarkedPatientsUsecase
    implements BaseUseCase<int, GetMarkedPatientsModelResponse> {
  final MarkedPatientsRepository repository;

  GetMarkedPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, GetMarkedPatientsModelResponse>> execute(
      int page) async {
    return await repository.getMarkedPatients(page);
  }
}
