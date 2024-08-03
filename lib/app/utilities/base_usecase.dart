import 'package:dartz/dartz.dart';
import '../../exports.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}

class NoParams {}
