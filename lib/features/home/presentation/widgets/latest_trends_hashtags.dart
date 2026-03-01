import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/exports.dart';
import '../../../../app/services/theme_bloc.dart';

class LatestTrendsHashtags extends StatefulWidget {
  const LatestTrendsHashtags({super.key});

  @override
  State<LatestTrendsHashtags> createState() => _LatestTrendsHashtagsState();
}

class _LatestTrendsHashtagsState extends State<LatestTrendsHashtags> {
  @override
  void initState() {
    super.initState();
    PermissionHelper.refreshPermissions().then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _recheckPermission() async {
    await PermissionHelper.refreshPermissions();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (_, __, ___, ____, _____, ______, _______, ________,
              _________, __________) {
            _recheckPermission();
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode =
              themeState is ThemeLoaded && themeState.isDarkMode;

          // Check if user has viewTrendHashtagsInHome permission
          if (!PermissionHelper.canPermission(
              AppPermissions.viewTrendHashtagsInHome)) {
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
                if (isVerifiedUser(homeData.isSyndicateCardRequired)) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        context.read<TrendingCubit>().callTrendsTabTimes = 0;
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.community,
                          arguments: AppRoutesArgs.communityRouteArgs(
                            homeDataModel: homeData,
                            currentDoctorModel: currentDoctorModel,
                            initialTab: 1,
                          ),
                        );
                      },
                      child: Card(
                        color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                        elevation: 0.8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 100.h,
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/trend.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.grey.shade200,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    Expanded(
                                      // Add Expanded here to constrain the Column's width
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...homeData.data!.trendsHashtags!
                                              .take(6)
                                              .toList()
                                              .asMap()
                                              .entries
                                              .map(
                                                (entry) => Flexible(
                                                  // Or use Expanded
                                                  child: Text(
                                                    '${entry.key + 1}. #${entry.value.tag}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.blue,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                );
              },
            );
          },
        );
      },
    ),
    );
  }
}
