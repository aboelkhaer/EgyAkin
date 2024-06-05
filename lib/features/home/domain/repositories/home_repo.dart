import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModelResponse>> getHome();
}
