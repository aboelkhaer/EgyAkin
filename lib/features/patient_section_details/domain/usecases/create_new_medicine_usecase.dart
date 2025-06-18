import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/create_new_medicine_model_response.dart';
import '../../../../exports.dart';

class CreateNewMedicineUsecase
    implements
        BaseUseCase<CreateNewMedicineUsecaseInput,
            CreateNewMedicineModelResponse> {
  final PatientSectionDetailsRepository repository;

  CreateNewMedicineUsecase(this.repository);

  @override
  Future<Either<Failure, CreateNewMedicineModelResponse>> execute(
      CreateNewMedicineUsecaseInput input) async {
    return await repository.createNewMedicine(input.title, input.description, input.dose);
  }
}

class CreateNewMedicineUsecaseInput {

  final String title;
  final String? description;
  final String dose;
 
  CreateNewMedicineUsecaseInput({required this.title, required this.description, required this.dose});
 

 
}
