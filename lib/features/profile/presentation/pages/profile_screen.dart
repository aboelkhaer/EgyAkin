import 'package:egy_akin/features/profile/presentation/widgets/profile_features.dart';
import '../../../../exports.dart';

class ProfileScreen extends StatefulWidget {
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
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().getDoctorDataFromLocal();
    super.initState();
  }

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
            isSyndicateCardRequired: widget.isSyndicateCardRequired,
            accountVerification: widget.accountVerification,
            currentDoctorRole: widget.currentDoctorRole,
            currentDoctorPoints: widget.currentDoctorPoints,
            homeDataModel: widget.homeDataModel,
            currentDoctorModel: widget.currentDoctorModel,
          ),
          SizedBox(height: 20.h),
          ProfileFeatures(
            cubit: cubit,
            homeDataModel: widget.homeDataModel,
          ),
        ],
      ),
    );
  }
}
