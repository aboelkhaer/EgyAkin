import 'package:egy_akin/features/profile/presentation/widgets/profile_features.dart';
import '../../../../exports.dart';

class ProfileScreen extends StatelessWidget {
  final String isSyndicateCardRequired;
  const ProfileScreen({super.key, required this.isSyndicateCardRequired});

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
            isSyndicateCardRequired: isSyndicateCardRequired,
          ),
          SizedBox(height: 20.h),
          ProfileFeatures(cubit: cubit),
        ],
      ),
    );
  }
}
