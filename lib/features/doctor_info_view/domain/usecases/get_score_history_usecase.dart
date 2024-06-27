import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/get_doctor_profile_score_history_model_response.dart';
import '../../../../exports.dart';

class GetScoreHistoryUsecase
    implements
        BaseUseCase<GetScoreHistoryUsecaseInput,
            GetDoctorProfileScoreModelResponse> {
  final DoctorInfoViewRepository repository;

  GetScoreHistoryUsecase(this.repository);

  @override
  Future<Either<Failure, GetDoctorProfileScoreModelResponse>> excute(
      GetScoreHistoryUsecaseInput input) async {
    return await repository.getScoreHistory(
        page: input.page, doctorId: input.doctorId);
  }
}

class GetScoreHistoryUsecaseInput {
  final int page;
  final String doctorId;

  GetScoreHistoryUsecaseInput({required this.page, required this.doctorId});
}
