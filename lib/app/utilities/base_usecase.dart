import 'package:dartz/dartz.dart';
import '../../exports.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> excute(In input);
}

class NoParams {}
