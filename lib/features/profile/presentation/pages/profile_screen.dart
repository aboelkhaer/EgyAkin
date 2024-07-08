import 'package:egy_akin/features/profile/presentation/widgets/profile_features.dart';
import '../../../../exports.dart';

class ProfileScreen extends StatelessWidget {
  final String isSyndicateCardRequired;
  final bool accountVerification;
  const ProfileScreen(
      {super.key,
      required this.isSyndicateCardRequired,
      required this.accountVerification});

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
            accountVerification: accountVerification,
          ),
          SizedBox(height: 20.h),
          ProfileFeatures(cubit: cubit),
        ],
      ),
    );
  }
}
