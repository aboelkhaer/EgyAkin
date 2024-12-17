import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_state.dart';

import '../../../../exports.dart';

class CreatePostInCommunityCubit extends Cubit<CreatePostInCommunityState> {
  CreatePostInCommunityCubit()
      : super(const CreatePostInCommunityState.loaded(0));
  static CreatePostInCommunityCubit get(context) => BlocProvider.of(context);

  String postContent = '';

  changePostLength(int postLengthValue) {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(postLengthValue),
      ),
    );
  }
}
