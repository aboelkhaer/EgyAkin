import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/more/data/models/change_language_model_response.dart';

import '../../../../exports.dart';

abstract class MoreRepository {
  Future<Either<Failure, ChangeLanguageModelResponse>> changeLanguage(String local);
  
}
