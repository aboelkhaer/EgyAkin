import 'package:egy_akin/features/profile/presentation/widgets/profile_features.dart';
import '../../../../exports.dart';

class ProfileScreen extends StatelessWidget {
  final String isSyndicateCardRequired;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;

  const ProfileScreen(
      {super.key,
      required this.isSyndicateCardRequired,
      required this.accountVerification,
      required this.currentDoctorRole,
      required this.currentDoctorPoints,
      required this.currentDoctorModel,
      required this.homeDataModel});

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
            currentDoctorRole: currentDoctorRole,
            currentDoctorPoints: currentDoctorPoints,
            homeDataModel: homeDataModel,
            currentDoctorModel: currentDoctorModel,
          ),
          SizedBox(height: 20.h),
          ProfileFeatures(
            cubit: cubit,
            homeDataModel: homeDataModel,
          ),
        ],
      ),
    );
  }
}
