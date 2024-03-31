import 'package:egy_akin/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = ProfileCubit.get(context);
    return const Center(
      child: Text('Profile'),
    );
  }
}
