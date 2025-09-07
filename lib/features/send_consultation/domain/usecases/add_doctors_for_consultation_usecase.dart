import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/send_consultation/data/models/add_doctors_for_consultation_model_response.dart';
import '../../../../exports.dart';

class AddDoctorsForConsultationUsecase
    implements
        BaseUseCase<AddDoctorsForConsultationUsecaseInput,
            AddDoctorsForConsultationModelResponse> {
  final SendConsultationRepository repository;

  AddDoctorsForConsultationUsecase(this.repository);

  @override
  Future<Either<Failure, AddDoctorsForConsultationModelResponse>> execute(
      AddDoctorsForConsultationUsecaseInput input) async {
    return await repository.addDoctorsForConsultation(
      consultationId: input.consultationId,
      message: input.message,
      doctorsIDS: input.doctorsIDS,
    );
  }
}

class AddDoctorsForConsultationUsecaseInput {
  final String consultationId;
  final String message;
  final List<String> doctorsIDS;

  AddDoctorsForConsultationUsecaseInput({
    required this.consultationId,
    required this.message,
    required this.doctorsIDS,
  });
}
