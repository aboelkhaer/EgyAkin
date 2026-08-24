import 'package:egy_akin/app/shared/functions/blocked_dialog.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../../exports.dart';

class PatientsHeader extends StatelessWidget {
  const PatientsHeader({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Row(
          children: [
            Expanded(
              child: Text(
                context.tr(AppStrings.patients),
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: HomeDashboardColors.title(isDark),
                ),
              ),
            ),
            _PatientsAddButton(cubit: cubit, isDark: isDark),
          ],
        );
      },
    );
  }
}

class _PatientsAddButton extends StatelessWidget {
  final HomeCubit cubit;
  final bool isDark;

  const _PatientsAddButton({
    required this.cubit,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => _circleButton(onTap: null),
          loaded: (
            homeData,
            currentDoctorModel,
            dotsPosition,
            homeIndex,
            isUploadingSyndicateCard,
            isUploadedSyndicateCard,
            message,
            checkUpdateMessageCounter,
            isUserBlocked,
            changesCounter,
          ) {
            return _circleButton(
              onTap: () => _handleAdd(
                context: context,
                homeData: homeData,
                currentDoctorModel: currentDoctorModel,
              ),
            );
          },
        );
      },
    );
  }

  Widget _circleButton({required VoidCallback? onTap}) {
    final fill = isDark ? const Color(0xFF3B2A6E) : const Color(0xFF5B3FC4);
    final border = isDark ? const Color(0xFF8B6FE8) : const Color(0xFF9B82F0);
    final iconColor =
        isDark ? const Color(0xFFC4B5FD) : const Color(0xFFE9E0FF);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: fill,
          border: Border.all(color: border, width: 1.2),
        ),
        child: Icon(Icons.add_rounded, color: iconColor, size: 22.sp),
      ),
    );
  }

  void _handleAdd({
    required BuildContext context,
    required HomeModelResponse homeData,
    required DoctorModel currentDoctorModel,
  }) {
    final syndicateVerified =
        isVerifiedUser(homeData.isSyndicateCardRequired);

    if (syndicateVerified) {
      if (!PermissionHelper.canPermission(AppPermissions.addPatientInHome)) {
        return;
      }

      if (homeData.isUserBlocked == true) {
        showBlockedDialog(
          context: context,
          onDismissed: () {
            cubit.signOut();
            navigatorKey.currentState?.pushReplacementNamed(AppRoutes.signIn);
          },
        );
        return;
      }

      if (homeData.verified != true) {
        showCustomDialog(
          context: context,
          title: context.tr(AppStrings.emailVerification),
          description: context.tr(
            AppStrings.youMustVerifyYourEmailAddressToEnjoyAllFeatures,
          ),
          noColoredButtonOnTap: () => Navigator.of(context).pop(),
          coloredButtonText: context.tr(AppStrings.verify),
          noColoredButtonText: context.tr(AppStrings.cancel),
          coloredButtonOnTap: () {
            Navigator.of(context).pop();
            navigatorKey.currentState?.pushNamed(
              AppRoutes.emailVerification,
              arguments: AppRoutesArgs.emailVerificationRouteArgs(
                currentDoctorModel: currentDoctorModel,
              ),
            );
          },
        );
        return;
      }

      navigatorKey.currentState?.pushNamed(
        AppRoutes.addPatient,
        arguments: AppRoutesArgs.addPatientRouteArgs(
          currentDoctorModel: cubit.currentDoctorModel,
          currentDoctorRole: homeData.role.toString(),
          currentDoctorPoints: int.parse(homeData.scoreValue!),
          homeDataModel: homeData,
        ),
      );
      return;
    }

    if (PermissionHelper.canPermission(AppPermissions.addPostInHome)) {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.createPostInCommunity,
        arguments: AppRoutesArgs.createPostInCommunityRouteArgs(
          currentDoctorModel: currentDoctorModel,
          homeDataModel: homeData,
        ),
      );
    }
  }
}
