import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class ChangeSyndicateCardStatusUsecase
    implements
        BaseUseCase<ChangeSyndicateCardStatusUsecaseInput,
            SyndicateCardVerifyModelResponse> {
  final DoctorInfoViewRepository repository;

  ChangeSyndicateCardStatusUsecase(this.repository);

  @override
  Future<Either<Failure, SyndicateCardVerifyModelResponse>> execute(
      ChangeSyndicateCardStatusUsecaseInput input) async {
    return await repository.changeSyndicateCardStatus(
        status: input.status, doctorId: input.doctorId);
  }
}

class ChangeSyndicateCardStatusUsecaseInput {
  final String status;
  final String doctorId;

  ChangeSyndicateCardStatusUsecaseInput(
      {required this.status, required this.doctorId});
}
