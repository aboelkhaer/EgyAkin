import 'package:egy_akin/features/contact_us/data/models/contact_us_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ContactUsRepository {
  Future<Either<Failure, ContactUsModelResponseModelResponse>> addContactUs(
      String message);
}
