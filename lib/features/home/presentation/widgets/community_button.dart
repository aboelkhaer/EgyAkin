import 'package:egy_akin/app/services/theme_bloc.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import '../../../../exports.dart';

class CommunityButton extends StatefulWidget {
  const CommunityButton({super.key});

  @override
  State<CommunityButton> createState() => _CommunityButtonState();
}

class _CommunityButtonState extends State<CommunityButton> {
  bool _hasPermission = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePermission();
  }

  Future<void> _initializePermission() async {
    // Initialize permissions to ensure they're loaded
    await PermissionHelper.refreshPermissions();
    final hasPermission = await PermissionHelper.hasPermission(
        AppPermissions.viewExploreCommunityButton);
    if (mounted) {
      setState(() {
        _hasPermission = hasPermission;
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        // Wait for permissions to initialize, then check
        if (!_isInitialized || !_hasPermission) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox.shrink();
              },
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
                return Column(
                  children: [
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.community,
                          arguments: AppRoutesArgs.communityRouteArgs(
                            homeDataModel: homeData,
                            currentDoctorModel: currentDoctorModel,
                            initialTab: 0,
                          ),
                        );
                      },
                      child: TweenAnimationBuilder(
                        tween: Tween(begin: 1.0, end: 1.05),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: isDarkMode
                                          ? [
                                              AppColors.darkPrimary,
                                              Colors.black54
                                            ]
                                          : [AppColors.primary, Colors.white54],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: isDarkMode
                                            ? AppColors.darkPrimary
                                                .withOpacity(0.2)
                                            : AppColors.primary
                                                .withOpacity(0.4),
                                        blurRadius: 10,
                                        spreadRadius: 2)
                                  ]),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.rocket_launch,
                                      color: isDarkMode
                                          ? Colors.white54
                                          : Colors.white),
                                  SizedBox(width: 8.w),
                                  Text(
                                    context.tr(AppStrings.exploreCommunity),
                                    style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white54
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
