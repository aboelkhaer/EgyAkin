import 'package:egy_akin/features/profile/data/models/profile_screens.dart';

import '../../../../exports.dart';

class ProfileFeatures extends StatelessWidget {
  final ProfileCubit cubit;
  final HomeModelResponse homeDataModel;
  final bool isDarkMode;
  const ProfileFeatures(
      {super.key,
      required this.cubit,
      required this.homeDataModel,
      required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          _profileScreensData(context).length,
          (index) => BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (doctorModel, isLoadedImage) async {
                  if (isLoadedImage) {
                    context.read<HomeCubit>().getDoctorDataFromLocal();
                  }
                },
                signOutLoaded: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed(AppRoutes.signIn);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return GestureDetector(
                    onTap: _profileScreensData(context)[index].onTap,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.darkCardBG : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDarkMode
                                    ? AppColors.darkBorder
                                    : Colors.grey.shade200,
                              ),
                            ),
                            child: Icon(
                              _profileScreensData(context)[index].icon,
                              color: isDarkMode
                                  ? AppColors.darkTitle
                                  : Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment:
                                _profileScreensData(context)[index]
                                        .isHaveDescription
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                            children: [
                              Text(
                                _profileScreensData(context)[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: isDarkMode
                                      ? AppColors.darkTitle
                                      : Colors.black,
                                ),
                              ),
                              _profileScreensData(context)[index]
                                      .isHaveDescription
                                  ? Text(
                                      _profileScreensData(context)[index]
                                          .description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp,
                                          color: isDarkMode
                                              ? AppColors.darkDescription
                                              : Colors.grey.shade700),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                signOutLoading: () {
                  return GestureDetector(
                    onTap: _profileScreensData(context)[index].title ==
                            LocalizationService.instance
                                .translate(AppStrings.signOut)
                        ? () {}
                        : _profileScreensData(context)[index].onTap,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.darkCardBG : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: _profileScreensData(context)[index].title ==
                              LocalizationService.instance
                                  .translate(AppStrings.signOut)
                          ? Container(
                              padding: const EdgeInsets.all(3),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(),
                                  )
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  child: Icon(
                                    _profileScreensData(context)[index].icon,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment:
                                      _profileScreensData(context)[index]
                                              .isHaveDescription
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      _profileScreensData(context)[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    _profileScreensData(context)[index]
                                            .isHaveDescription
                                        ? Text(
                                            _profileScreensData(context)[index]
                                                .description,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                                color: Colors.grey.shade700),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                )
                              ],
                            ),
                    ),
                  );
                },
                loaded: (doctorModel, isLoadedImage) {
                  return GestureDetector(
                    onTap: _profileScreensData(context)[index].onTap,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.darkCardBG : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Icon(
                              _profileScreensData(context)[index].icon,
                              color: Colors.grey.shade800,
                              size: 20.r,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment:
                                _profileScreensData(context)[index]
                                        .isHaveDescription
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                            children: [
                              Text(
                                _profileScreensData(context)[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: isDarkMode
                                      ? AppColors.darkTitle
                                      : Colors.black,
                                ),
                              ),
                              _profileScreensData(context)[index]
                                      .isHaveDescription
                                  ? Text(
                                      _profileScreensData(context)[index]
                                          .description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp,
                                          color: isDarkMode
                                              ? AppColors.darkDescription
                                              : Colors.grey.shade700),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<ProfileScreens> _profileScreensData(context) {
    final List<ProfileScreens?> screens = [
      ProfileScreens(
        icon: Icons.person_outline,
        title: LocalizationService.instance.translate(AppStrings.account),
        description: LocalizationService.instance
            .translate(AppStrings.manageYourPersonalInfo),
        onTap: () {
          navigatorKey.currentState?.pushNamed(AppRoutes.doctorProfile);
        },
      ),
      isVerifiedUser(homeDataModel.isSyndicateCardRequired)
          ? ProfileScreens(
              icon: Icons.chat_bubble_outline,
              title: LocalizationService.instance
                  .translate(AppStrings.consultation),
              description: LocalizationService.instance
                  .translate(AppStrings.initateOrViewConsultations),
              onTap: () {
                navigatorKey.currentState?.pushNamed(
                  AppRoutes.consultation,
                  arguments: AppRoutesArgs.consultationRouteArgs(
                    homeDataModel: homeDataModel,
                    currentDoctorModel: cubit.currentDoctor,
                    initialTab: 0,
                  ),
                );
              },
            )
          : null,
      ProfileScreens(
        icon: Icons.emoji_events_outlined,
        title: LocalizationService.instance.translate(AppStrings.achievements),
        description: LocalizationService.instance
            .translate(AppStrings.exploreYourAccomplishments),
        onTap: () {
          showCustomBottomSheet(
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) =>
                    DoctorInfoViewCubit(sl(), sl(), sl(), sl(), sl(), sl()),
                child: AchievementsTab(
                  isProfileFeature: true,
                  currentDoctorId: cubit.currentDoctor.id.toString(),
                ),
              );
            },
          );
        },
      ),
      ProfileScreens(
          icon: Icons.exit_to_app_outlined,
          title: LocalizationService.instance.translate(AppStrings.signOut),
          description: '',
          isHaveDescription: false,
          onTap: () {
            cubit.signOut();
          }),
    ];

    // Filter out null values to hide consultation for non-verified users
    return screens
        .where((screen) => screen != null)
        .cast<ProfileScreens>()
        .toList();
  }
}
