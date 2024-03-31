import 'package:egy_akin/features/post_details/presentation/cubit/post_details_cubit.dart';

import '../../../../exports.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PostDetailsCubit cubit = PostDetailsCubit.get(context);
    return const Scaffold();
  }
}
