import 'package:egy_akin/app/services/theme_bloc.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/profile/presentation/widgets/profile_tab_content.dart';

import '../../../../exports.dart';

class ProfileScreen extends StatefulWidget {
  final String isSyndicateCardRequired;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;

  const ProfileScreen({
    super.key,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

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
    final cubit = ProfileCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            systemStatusBarContrastEnforced: false,
          ),
          child: Scaffold(
            backgroundColor: HomeDashboardColors.scaffold(isDark),
            body: ProfileTabContent(
              cubit: cubit,
              isSyndicateCardRequired: widget.isSyndicateCardRequired,
              accountVerification: widget.accountVerification,
              currentDoctorRole: widget.currentDoctorRole,
              currentDoctorPoints: widget.currentDoctorPoints,
              homeDataModel: widget.homeDataModel,
              currentDoctorModel: widget.currentDoctorModel,
              isDark: isDark,
            ),
          ),
        );
      },
    );
  }
}
