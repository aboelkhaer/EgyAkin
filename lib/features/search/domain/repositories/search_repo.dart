import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, GetSearchModelResponse>> getSearchHome({
    required String searchContent,
  });
}
