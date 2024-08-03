import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetSearchHomeUsecase
    implements BaseUseCase<GetSearchHomeUsecaseInput, GetSearchModelResponse> {
  final SearchRepository repository;

  GetSearchHomeUsecase(this.repository);

  @override
  Future<Either<Failure, GetSearchModelResponse>> execute(
      GetSearchHomeUsecaseInput input) async {
    return await repository.getSearchHome(
        patient: input.patient, dose: input.dose);
  }
}

class GetSearchHomeUsecaseInput {
  final String patient;
  final String dose;

  GetSearchHomeUsecaseInput({required this.patient, required this.dose});
}
