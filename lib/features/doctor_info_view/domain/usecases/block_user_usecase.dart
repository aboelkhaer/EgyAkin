import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/block_user_model_response.dart';
import '../../../../exports.dart';

class BlockUserUsecase
    implements BaseUseCase<BlockUserUsecaseInput, BlockUserModelResponse> {
  final DoctorInfoViewRepository repository;

  BlockUserUsecase(this.repository);

  @override
  Future<Either<Failure, BlockUserModelResponse>> execute(
      BlockUserUsecaseInput input) async {
    return await repository.blockUser(
        doctorId: input.doctorId, status: input.status);
  }
}

class BlockUserUsecaseInput {
  final String doctorId;
  final bool status;

  BlockUserUsecaseInput({required this.doctorId, required this.status});
}
