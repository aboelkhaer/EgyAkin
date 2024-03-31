import 'package:egy_akin/features/post_details/presentation/cubit/post_details_state.dart';

import '../../../../exports.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit() : super(const PostDetailsState.initial());
  static PostDetailsCubit get(context) => BlocProvider.of(context);
}
