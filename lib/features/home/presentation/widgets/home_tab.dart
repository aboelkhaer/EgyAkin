import 'package:flutter/scheduler.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';

import '../../../../exports.dart';

class HomeTab extends StatefulWidget {
  final HomeCubit cubit;
  const HomeTab({
    super.key,
    required this.cubit,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeCubit homeCubit; // Store a reference to the cubit

  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>(); // Initialize cubit reference
    homeCubit.homeTabScrollController = ScrollController();
  }

  @override
  void dispose() {
    if (!homeCubit.isClosed && homeCubit.homeTabScrollController.hasClients) {
      homeCubit.homeTabScrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return RefreshIndicator(
          color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
          onRefresh: () {
            animateToTopOfScreen(widget.cubit.homeTabScrollController);

            if (widget.cubit.isUnreadNotification) {
              context.read<NotificationCubit>().getAllNotifications();
            }

            return widget.cubit.getHome();
          },
          child: Container(
            color: isDarkMode ? AppColors.darkScaffoldBG : Colors.grey.shade100,
            child: Column(
              children: [
                BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
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
                      ) {},
                      error: (message) {
                        customSnackBar(message: message, context: context);

                        if (message == 'Unauthenticated.') {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            context
                                .read<HomeCubit>()
                                .signOutForUnUnauthenticated();
                            navigatorKey.currentState
                                ?.pushReplacementNamed(AppRoutes.signIn);
                          });
                        }
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
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
                        return CheckIfVerified(
                          verified: homeData.verified!,
                          isSyndicateCardRequired:
                              homeData.isSyndicateCardRequired!,
                          isExitVerification:
                              homeCubit.isExistVerificationBanner ?? false,
                          isDarkMode: isDarkMode,
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: widget.cubit.homeTabScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20) +
                          const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocBuilder<HomeCubit, HomeState>(
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
                                  return HomeSearchBotton(
                                    currentDoctorModel: currentDoctorModel,
                                    verified: homeData.verified!,
                                    isSyndicateCardRequired:
                                        homeData.isSyndicateCardRequired!,
                                    currentDoctorPoints:
                                        int.parse(homeData.scoreValue!),
                                    currentDoctorRole: homeData.role.toString(),
                                    homeDataModel: homeData,
                                  );
                                },
                              );
                            },
                          ),
                          PostsSliderAndDots(
                              cubit: widget.cubit, isDarkMode: isDarkMode),
                          const CommunityButton(),
                          const LatestTrendsHashtags(),
                          const GroupsHomeView(),
                          const DoctorsActivation(),
                          TopDoctors(cubit: widget.cubit),
                          const YourPatientSection(),
                          const AllPatientSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
