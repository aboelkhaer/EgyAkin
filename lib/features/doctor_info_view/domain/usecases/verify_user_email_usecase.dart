import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class VerifyUserEmailUsecase
    implements
        BaseUseCase<VerifyUserEmailUsecaseInput, VerifyUserEmailModelResponse> {
  final DoctorInfoViewRepository repository;

  VerifyUserEmailUsecase(this.repository);

  @override
  Future<Either<Failure, VerifyUserEmailModelResponse>> execute(
      VerifyUserEmailUsecaseInput input) async {
    return await repository.verifyDoctorEmail(
        doctorId: input.doctorId, timestamp: input.timestamp);
  }
}

class VerifyUserEmailUsecaseInput {
  final String doctorId;
  final String? timestamp;

  VerifyUserEmailUsecaseInput(
      {required this.doctorId, required this.timestamp});
}
