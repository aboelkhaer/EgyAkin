import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/contact_us/data/models/contact_us_model_response.dart';
import 'package:egy_akin/features/contact_us/domain/repositories/contact_us_repo.dart';
import '../../../../exports.dart';

class AddContactUsUsecase
    implements BaseUseCase<String, ContactUsModelResponseModelResponse> {
  final ContactUsRepository repository;

  AddContactUsUsecase(this.repository);

  @override
  Future<Either<Failure, ContactUsModelResponseModelResponse>> excute(
      String message) async {
    return await repository.addContactUs(message);
  }
}
