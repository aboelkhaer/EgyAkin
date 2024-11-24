import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ContactUsRepository {
  Future<Either<Failure, ContactUsModelResponseModelResponse>> addContactUs(
      String message);
}
