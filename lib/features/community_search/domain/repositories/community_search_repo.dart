import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:egy_akin/features/community_search/data/models/get_response_of_search_model.dart';

import '../../../../exports.dart';

abstract class CommunitySearchRepository {
  Future<Either<Failure, GetResponseOfSearchModel>> getCommunitySearchResponse(
    String searchContent,
  );
}
