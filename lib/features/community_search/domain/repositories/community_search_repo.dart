import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

abstract class CommunitySearchRepository {
  Future<Either<Failure, GetResponseOfSearchModel>> getCommunitySearchResponse(
    int page,
    String searchContent,
  );
}
