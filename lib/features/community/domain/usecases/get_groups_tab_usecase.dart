import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import '../../../../exports.dart';

class GetGroupsTabUsecase
    implements BaseUseCase<int, GetGroupsTabModelResponse> {
  final CommunityRepository repository;

  GetGroupsTabUsecase(this.repository);

  @override
  Future<Either<Failure, GetGroupsTabModelResponse>> execute(int page) async {
    return await repository.getGroupsTab(page);
  }
}
