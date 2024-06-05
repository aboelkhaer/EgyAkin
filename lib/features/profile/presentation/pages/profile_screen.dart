import 'package:egy_akin/features/profile/presentation/widgets/profile_features.dart';
import '../../../../exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = ProfileCubit.get(context);
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileCover(
            cubit: cubit,
          ),
          SizedBox(height: 20.h),
          ProfileFeatures(cubit: cubit),
        ],
      ),
    );
  }
}
