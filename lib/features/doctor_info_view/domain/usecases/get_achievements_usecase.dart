import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetAchievementsUsecase
    implements BaseUseCase<String, List<GetAchievementsModelResponse>> {
  final DoctorInfoViewRepository repository;

  GetAchievementsUsecase(this.repository);

  @override
  Future<Either<Failure, List<GetAchievementsModelResponse>>> execute(
      String doctorId) async {
    return await repository.getAchievements(doctorId);
  }
}
