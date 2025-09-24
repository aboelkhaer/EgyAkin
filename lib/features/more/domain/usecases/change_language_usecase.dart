import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/more/data/models/change_language_model_response.dart';
import 'package:egy_akin/features/more/domain/repositories/more_repo.dart';
import '../../../../exports.dart';

class ChangeLanguageUsecase
    implements BaseUseCase<String, ChangeLanguageModelResponse> {
  final MoreRepository repository;

  ChangeLanguageUsecase(this.repository);

  @override
  Future<Either<Failure, ChangeLanguageModelResponse>> execute(
      String locale) async {
    return await repository.changeLanguage(locale);
  }
}
