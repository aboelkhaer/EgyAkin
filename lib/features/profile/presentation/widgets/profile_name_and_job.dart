import 'package:egy_akin/exports.dart';

class ProfileNameAndJob extends StatelessWidget {
  final ProfileCubit cubit;
  final String isSyndicateCardRequired;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const ProfileNameAndJob({
    super.key,
    required this.cubit,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.currentDoctorModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            customSnackBar(message: message, context: context);
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            if (cubit.currentDoctor.firstName == null ||
                cubit.currentDoctor.lastName == null) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      doctorName(
                        firstName: cubit.currentDoctor.firstName ?? '',
                        lastName: cubit.currentDoctor.lastName ?? '',
                        role: homeDataModel.isSyndicateCardRequired.toString(),
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isSyndicateCardRequired == 'Verified'
                        ? const VerificationIcon(
                            duration: 300,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  capitalizeFirstText(
                      cubit.currentDoctor.specialty ?? AppStrings.empty)!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 3.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        // First Row with three items
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStatItem(
                              context: context,
                              icon: Icons.people,
                              value: context
                                  .read<HomeCubit>()
                                  .doctorPatientCount
                                  .toString(),
                              label: 'Patient',
                              onTap: () {},
                            ),
                            _buildDivider(),
                            _buildStatItem(
                              context: context,
                              icon: Icons.star,
                              value: context
                                  .read<HomeCubit>()
                                  .doctorScore
                                  .toString(),
                              label: 'Score',
                              onTap: () {},
                            ),
                            _buildDivider(),
                            _buildStatItem(
                              context: context,
                              icon: Icons.bookmark,
                              value: homeDataModel.savedPosts.toString(),
                              label: 'Saved Posts',
                              onTap: () {},
                            ),
                          ],
                        ),

                        SizedBox(height: 5.h), // Space between rows

                        // Second Row with "All Posts"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStatItem(
                              context: context,
                              icon: Icons.post_add,
                              value: homeDataModel.postsCount.toString(),
                              label: 'All Posts',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
          loaded: (doctorModel, isLoadedImage) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      doctorName(
                        firstName: cubit.currentDoctor.firstName ?? '',
                        lastName: cubit.currentDoctor.lastName ?? '',
                        role: homeDataModel.isSyndicateCardRequired.toString(),
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isSyndicateCardRequired == 'Verified'
                        ? const VerificationIcon(
                            duration: 300,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  capitalizeFirstText(
                      doctorModel.specialty ?? AppStrings.empty)!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 3.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        // First Row with three items
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStatItem(
                              context: context,
                              icon: Icons.people,
                              value: context
                                  .read<HomeCubit>()
                                  .doctorPatientCount
                                  .toString(),
                              label: 'Patient',
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.profilePatients,
                                  arguments:
                                      AppRoutesArgs.profilePatientsRouteArgs(
                                    doctorId: cubit.currentDoctor.id.toString(),
                                    currentDoctorModel: cubit.currentDoctor,
                                    accountVerification: accountVerification,
                                    currentDoctorPoints: currentDoctorPoints,
                                    isSyndicateCardRequired:
                                        isSyndicateCardRequired,
                                    doctorFirstName: cubit
                                        .currentDoctor.firstName
                                        .toString(),
                                    currentDoctorRole: currentDoctorRole,
                                    homeDataModel: homeDataModel,
                                  ),
                                );
                              },
                            ),
                            _buildDivider(),
                            _buildStatItem(
                              context: context,
                              icon: Icons.star,
                              value: context
                                  .read<HomeCubit>()
                                  .doctorScore
                                  .toString(),
                              label: 'Score',
                              onTap: () {
                                showCustomBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BlocProvider(
                                      create: (context) =>
                                          ScoreHistoryCubit(sl()),
                                      child: ScoreHistoryScreen(
                                        doctorId:
                                            cubit.currentDoctor.id.toString(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            _buildDivider(),
                            _buildStatItem(
                              context: context,
                              icon: Icons.bookmark,
                              value: homeDataModel.savedPosts.toString(),
                              label: 'Saved Posts',
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.savedPosts,
                                  arguments: AppRoutesArgs.savedPostsRouteArgs(
                                    currentDoctorModel: currentDoctorModel,
                                    homeDataModel: homeDataModel,
                                    doctorId: currentDoctorModel.id.toString(),
                                    doctorName: doctorName(
                                      firstName: currentDoctorModel.firstName
                                          .toString(),
                                      lastName: currentDoctorModel.lastName
                                          .toString(),
                                      role: homeDataModel
                                          .isSyndicateCardRequired
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 5.h), // Space between rows

                        // Second Row with "All Posts"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStatItem(
                              context: context,
                              icon: Icons.post_add,
                              value: homeDataModel.postsCount.toString(),
                              label: 'All Posts',
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.allDoctorPosts,
                                  arguments:
                                      AppRoutesArgs.allDoctorPostsRouteArgs(
                                    currentDoctorModel: currentDoctorModel,
                                    homeDataModel: homeDataModel,
                                    doctorId: currentDoctorModel.id.toString(),
                                    doctorName: doctorName(
                                      firstName: currentDoctorModel.firstName,
                                      lastName: currentDoctorModel.lastName,
                                      role: homeDataModel
                                          .isSyndicateCardRequired
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: AppColors.primary.withOpacity(0.5),
          ),
          SizedBox(width: 4.w),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 20.h,
      width: 1.w,
      color: Colors.grey.shade400,
      margin: EdgeInsets.only(right: 5.w),
    );
  }
}
