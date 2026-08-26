import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetConsultationSearchUsecase
    implements
        BaseUseCase<GetConsultationSearchUsecaseInput,
            GetConsultationSearchModelResponse> {
  final SendConsultationRepository repository;

  GetConsultationSearchUsecase(this.repository);

  @override
  Future<Either<Failure, GetConsultationSearchModelResponse>> execute(
      GetConsultationSearchUsecaseInput input) async {
    return await repository.consultationDoctorSearch(
      searchContent: input.searchContent,
      groupId: input.groupId,
    );
  }
}

class GetConsultationSearchUsecaseInput {
  final String searchContent;

  /// Set while inviting into a group, so doctors already in it — or already
  /// invited — are left out of the results.
  final String? groupId;

  GetConsultationSearchUsecaseInput(
      {required this.searchContent, this.groupId});
}
