import 'package:egy_akin/exports.dart';

class ProfileNameAndJob extends StatefulWidget {
  final ProfileCubit cubit;
  final String isSyndicateCardRequired;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final bool isDarkMode;

  const ProfileNameAndJob({
    super.key,
    required this.cubit,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.isDarkMode,
  });

  @override
  State<ProfileNameAndJob> createState() => _ProfileNameAndJobState();
}

class _ProfileNameAndJobState extends State<ProfileNameAndJob> {
  String? _preservedMarkedPatientsCount;
  DoctorModel? _preservedDoctorModel;

  // Helper method to check if buttons should be shown
  bool _shouldShowButtons(HomeModelResponse homeDataModel) {
    return isVerifiedUser(homeDataModel.isSyndicateCardRequired) ||
        homeDataModel.userType == 'medical_statistics';
  }

  @override
  void initState() {
    super.initState();
    // Preserve the original marked patients count
    _preservedMarkedPatientsCount = widget.homeDataModel.markedPatientsCount;
    // Preserve the original doctor model
    _preservedDoctorModel = widget.currentDoctorModel;
  }

  @override
  void didUpdateWidget(ProfileNameAndJob oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update preserved count if the new value is not null/empty and not '0'
    if (widget.homeDataModel.markedPatientsCount != null &&
        widget.homeDataModel.markedPatientsCount!.isNotEmpty &&
        widget.homeDataModel.markedPatientsCount != '0') {
      _preservedMarkedPatientsCount = widget.homeDataModel.markedPatientsCount;
    }
    // Preserve doctor model if it has valid data
    if (widget.currentDoctorModel.firstName != null &&
        widget.currentDoctorModel.lastName != null) {
      _preservedDoctorModel = widget.currentDoctorModel;
    }
  }

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
        // Create a modified homeDataModel with preserved count during sign out
        final effectiveHomeDataModel = state.maybeWhen(
          signOutLoading: () => widget.homeDataModel.copyWith(
            markedPatientsCount: _preservedMarkedPatientsCount ??
                widget.homeDataModel.markedPatientsCount,
          ),
          orElse: () => widget.homeDataModel,
        );

        return state.maybeWhen(
          signOutLoading: () {
            // Show the same content during sign out to prevent hiding
            // Use widget.currentDoctorModel instead of widget.cubit.currentDoctor
            // to avoid issues when cubit data is reset during sign out
            // if (widget.currentDoctorModel.firstName == null ||
            //     widget.currentDoctorModel.lastName == null) {
            //   return const SizedBox.shrink();
            // }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        doctorName(
                          firstName: widget.currentDoctorModel.firstName ?? '',
                          lastName: widget.currentDoctorModel.lastName ?? '',
                          role: effectiveHomeDataModel.isSyndicateCardRequired
                              .toString(),
                        ),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: widget.isDarkMode
                              ? AppColors.darkTitle
                              : Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isVerifiedUser(widget.isSyndicateCardRequired))
                      const SizedBox(width: 4),
                    if (isVerifiedUser(widget.isSyndicateCardRequired))
                      const VerificationIcon(
                        duration: 300,
                      ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  capitalizeFirstText(
                      widget.currentDoctorModel.specialty ?? AppStrings.empty)!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: widget.isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                    height: (isVerifiedUser(effectiveHomeDataModel
                                .isSyndicateCardRequired) ||
                            effectiveHomeDataModel.userType ==
                                'medical_statistics')
                        ? 3.h
                        : 0),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    // Use preserved count during sign out loading
                    final effectiveHomeDataModel = state.maybeWhen(
                      signOutLoading: () => widget.homeDataModel.copyWith(
                        markedPatientsCount: _preservedMarkedPatientsCount ??
                            widget.homeDataModel.markedPatientsCount,
                      ),
                      orElse: () => widget.homeDataModel,
                    );

                    return Column(
                      children: [
                        // First Row with conditional items

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Show patient count if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel)) ...[
                              _buildStatItem(
                                context: context,
                                icon: Icons.people,
                                value: context
                                    .read<HomeCubit>()
                                    .doctorPatientCount
                                    .toString(),
                                label: context.tr(AppStrings.patient),
                                onTap: () {},
                              ),
                              _buildDivider(context),
                            ],
                            // Show score if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel)) ...[
                              _buildStatItem(
                                context: context,
                                icon: Icons.star,
                                value: context
                                    .read<HomeCubit>()
                                    .doctorScore
                                    .toString(),
                                label: context.tr(AppStrings.score),
                                onTap: () {},
                              ),
                              _buildDivider(context),
                            ],
                            // Show saved posts in first row if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel))
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel.savedPosts
                                    .toString(),
                                label: context.tr(AppStrings.savedPosts),
                                onTap: () {},
                              ),
                          ],
                        ),

                        SizedBox(height: 5.h), // Space between rows

                        // Second Row - conditional layout based on verification or medical statistics
                        if (_shouldShowButtons(effectiveHomeDataModel))
                          // Verified users: Marked Patients and All Posts in second row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel
                                        .markedPatientsCount ??
                                    _preservedMarkedPatientsCount ??
                                    '0',
                                label: 'Marked Patients',
                                onTap: () {
                                  final preservedDoctor =
                                      _preservedDoctorModel ??
                                          widget.currentDoctorModel;
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.markedPatients,
                                    arguments:
                                        AppRoutesArgs.markedPatientsRouteArgs(
                                      currentDoctorModel: preservedDoctor,
                                      homeDataModel: effectiveHomeDataModel,
                                    ),
                                  );
                                },
                              ),
                              _buildDivider(context),
                              _buildStatItem(
                                context: context,
                                icon: Icons.post_add,
                                value: effectiveHomeDataModel.postsCount
                                    .toString(),
                                label: context.tr(AppStrings.allPosts),
                                onTap: () {},
                              ),
                            ],
                          )
                        else
                          // Non-verified users: Saved Posts and All Posts in same row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel.savedPosts
                                    .toString(),
                                label: context.tr(AppStrings.savedPosts),
                                onTap: () {},
                              ),
                              _buildDivider(context),
                              _buildStatItem(
                                context: context,
                                icon: Icons.post_add,
                                value: effectiveHomeDataModel.postsCount
                                    .toString(),
                                label: context.tr(AppStrings.allPosts),
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
          orElse: () {
            // Use preserved doctor model to ensure data is available
            final preservedDoctor =
                _preservedDoctorModel ?? widget.currentDoctorModel;
            if (preservedDoctor.firstName == null ||
                preservedDoctor.lastName == null) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        doctorName(
                          firstName: preservedDoctor.firstName ?? '',
                          lastName: preservedDoctor.lastName ?? '',
                          role: effectiveHomeDataModel.isSyndicateCardRequired
                              .toString(),
                        ),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: widget.isDarkMode
                              ? AppColors.darkTitle
                              : Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isVerifiedUser(widget.isSyndicateCardRequired))
                      const SizedBox(width: 4),
                    if (isVerifiedUser(widget.isSyndicateCardRequired))
                      const VerificationIcon(
                        duration: 300,
                      ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  capitalizeFirstText(
                      preservedDoctor.specialty ?? AppStrings.empty)!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: widget.isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                    height: (isVerifiedUser(effectiveHomeDataModel
                                .isSyndicateCardRequired) ||
                            effectiveHomeDataModel.userType ==
                                'medical_statistics')
                        ? 3.h
                        : 0),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    // Use preserved count during sign out loading
                    final effectiveHomeDataModel = state.maybeWhen(
                      signOutLoading: () => widget.homeDataModel.copyWith(
                        markedPatientsCount: _preservedMarkedPatientsCount ??
                            widget.homeDataModel.markedPatientsCount,
                      ),
                      orElse: () => widget.homeDataModel,
                    );

                    return Column(
                      children: [
                        // First Row with conditional items

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Show patient count if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel)) ...[
                              _buildStatItem(
                                context: context,
                                icon: Icons.people,
                                value: context
                                    .read<HomeCubit>()
                                    .doctorPatientCount
                                    .toString(),
                                label: context.tr(AppStrings.patient),
                                onTap: () {},
                              ),
                              _buildDivider(context),
                            ],
                            // Show score if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel)) ...[
                              _buildStatItem(
                                context: context,
                                icon: Icons.star,
                                value: context
                                    .read<HomeCubit>()
                                    .doctorScore
                                    .toString(),
                                label: context.tr(AppStrings.score),
                                onTap: () {},
                              ),
                              _buildDivider(context),
                            ],
                            // Show saved posts in first row if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel))
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel.savedPosts
                                    .toString(),
                                label: context.tr(AppStrings.savedPosts),
                                onTap: () {},
                              ),
                          ],
                        ),

                        SizedBox(height: 5.h), // Space between rows

                        // Second Row - conditional layout based on verification or medical statistics
                        if (_shouldShowButtons(effectiveHomeDataModel))
                          // Verified users: Marked Patients and All Posts in second row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel
                                        .markedPatientsCount ??
                                    _preservedMarkedPatientsCount ??
                                    '0',
                                label: 'Marked Patients',
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.markedPatients,
                                    arguments:
                                        AppRoutesArgs.markedPatientsRouteArgs(
                                      currentDoctorModel:
                                          widget.cubit.currentDoctor,
                                      homeDataModel: effectiveHomeDataModel,
                                    ),
                                  );
                                },
                              ),
                              _buildDivider(context),
                              _buildStatItem(
                                context: context,
                                icon: Icons.post_add,
                                value: effectiveHomeDataModel.postsCount
                                    .toString(),
                                label: context.tr(AppStrings.allPosts),
                                onTap: () {},
                              ),
                            ],
                          )
                        else
                          // Non-verified users: Saved Posts and All Posts in same row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel.savedPosts
                                    .toString(),
                                label: context.tr(AppStrings.savedPosts),
                                onTap: () {},
                              ),
                              _buildDivider(context),
                              _buildStatItem(
                                context: context,
                                icon: Icons.post_add,
                                value: effectiveHomeDataModel.postsCount
                                    .toString(),
                                label: context.tr(AppStrings.allPosts),
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
            // Create a modified homeDataModel with preserved count during sign out
            final effectiveHomeDataModel = state.maybeWhen(
              signOutLoading: () => widget.homeDataModel.copyWith(
                markedPatientsCount: _preservedMarkedPatientsCount ??
                    widget.homeDataModel.markedPatientsCount,
              ),
              orElse: () => widget.homeDataModel,
            );

            // Use preserved doctor model as fallback to ensure data is always available
            final effectiveDoctor = _preservedDoctorModel ?? doctorModel;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        doctorName(
                          firstName: effectiveDoctor.firstName ?? '',
                          lastName: effectiveDoctor.lastName ?? '',
                          role: effectiveHomeDataModel.isSyndicateCardRequired
                              .toString(),
                        ),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: widget.isDarkMode
                              ? AppColors.darkTitle
                              : Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isVerifiedUser(widget.isSyndicateCardRequired))
                      const SizedBox(width: 4),
                    if (isVerifiedUser(widget.isSyndicateCardRequired))
                      const VerificationIcon(
                        duration: 300,
                      ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  capitalizeFirstText(
                      effectiveDoctor.specialty ?? AppStrings.empty)!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: widget.isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                    height: (isVerifiedUser(effectiveHomeDataModel
                                .isSyndicateCardRequired) ||
                            effectiveHomeDataModel.userType ==
                                'medical_statistics')
                        ? 3.h
                        : 0),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    // Use preserved count during sign out loading
                    final effectiveHomeDataModel = state.maybeWhen(
                      signOutLoading: () => widget.homeDataModel.copyWith(
                        markedPatientsCount: _preservedMarkedPatientsCount ??
                            widget.homeDataModel.markedPatientsCount,
                      ),
                      orElse: () => widget.homeDataModel,
                    );

                    return Column(
                      children: [
                        // First Row with conditional items
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Show patient count if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel)) ...[
                              _buildStatItem(
                                context: context,
                                icon: Icons.people,
                                value: context
                                    .read<HomeCubit>()
                                    .doctorPatientCount
                                    .toString(),
                                label: context.tr(AppStrings.patient),
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.profilePatients,
                                    arguments:
                                        AppRoutesArgs.profilePatientsRouteArgs(
                                      doctorId: widget.cubit.currentDoctor.id
                                          .toString(),
                                      currentDoctorModel:
                                          widget.cubit.currentDoctor,
                                      accountVerification:
                                          widget.accountVerification,
                                      currentDoctorPoints:
                                          widget.currentDoctorPoints,
                                      isSyndicateCardRequired:
                                          widget.isSyndicateCardRequired,
                                      doctorFirstName: widget
                                          .cubit.currentDoctor.firstName
                                          .toString(),
                                      currentDoctorRole:
                                          widget.currentDoctorRole,
                                      homeDataModel: effectiveHomeDataModel,
                                    ),
                                  );
                                },
                              ),
                              _buildDivider(context),
                            ],
                            // Show score if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel)) ...[
                              _buildStatItem(
                                context: context,
                                icon: Icons.star,
                                value: context
                                    .read<HomeCubit>()
                                    .doctorScore
                                    .toString(),
                                label: context.tr(AppStrings.score),
                                onTap: () {
                                  showCustomBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) =>
                                            ScoreHistoryCubit(sl()),
                                        child: ScoreHistoryScreen(
                                          doctorId: widget
                                              .cubit.currentDoctor.id
                                              .toString(),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              _buildDivider(context),
                            ],
                            // Show saved posts in first row if verified or medical statistics
                            if (_shouldShowButtons(effectiveHomeDataModel))
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel.savedPosts
                                    .toString(),
                                label: context.tr(AppStrings.savedPosts),
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.savedPosts,
                                    arguments:
                                        AppRoutesArgs.savedPostsRouteArgs(
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      homeDataModel: effectiveHomeDataModel,
                                      doctorId: widget.currentDoctorModel.id
                                          .toString(),
                                      doctorName: doctorName(
                                        firstName: widget
                                            .currentDoctorModel.firstName
                                            .toString(),
                                        lastName: widget
                                            .currentDoctorModel.lastName
                                            .toString(),
                                        role: effectiveHomeDataModel
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

                        // Second Row - conditional layout based on verification or medical statistics
                        if (_shouldShowButtons(effectiveHomeDataModel))
                          // Verified users: Marked Patients and All Posts in second row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel
                                        .markedPatientsCount ??
                                    _preservedMarkedPatientsCount ??
                                    '0',
                                label: 'Marked Patients',
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.markedPatients,
                                    arguments:
                                        AppRoutesArgs.markedPatientsRouteArgs(
                                      currentDoctorModel:
                                          widget.cubit.currentDoctor,
                                      homeDataModel: effectiveHomeDataModel,
                                    ),
                                  );
                                },
                              ),
                              _buildDivider(context),
                              _buildStatItem(
                                context: context,
                                icon: Icons.post_add,
                                value: effectiveHomeDataModel.postsCount
                                    .toString(),
                                label: context.tr(AppStrings.allPosts),
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.allDoctorPosts,
                                    arguments:
                                        AppRoutesArgs.allDoctorPostsRouteArgs(
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      homeDataModel: effectiveHomeDataModel,
                                      doctorId: widget.currentDoctorModel.id
                                          .toString(),
                                      doctorName: doctorName(
                                        firstName:
                                            widget.currentDoctorModel.firstName,
                                        lastName:
                                            widget.currentDoctorModel.lastName,
                                        role: effectiveHomeDataModel
                                            .isSyndicateCardRequired
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        else
                          // Non-verified users: Saved Posts and All Posts in same row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildStatItem(
                                context: context,
                                icon: Icons.bookmark,
                                value: effectiveHomeDataModel.savedPosts
                                    .toString(),
                                label: context.tr(AppStrings.savedPosts),
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.savedPosts,
                                    arguments:
                                        AppRoutesArgs.savedPostsRouteArgs(
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      homeDataModel: effectiveHomeDataModel,
                                      doctorId: widget.currentDoctorModel.id
                                          .toString(),
                                      doctorName: doctorName(
                                        firstName: widget
                                            .currentDoctorModel.firstName
                                            .toString(),
                                        lastName: widget
                                            .currentDoctorModel.lastName
                                            .toString(),
                                        role: effectiveHomeDataModel
                                            .isSyndicateCardRequired
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              _buildDivider(context),
                              _buildStatItem(
                                context: context,
                                icon: Icons.post_add,
                                value: effectiveHomeDataModel.postsCount
                                    .toString(),
                                label: context.tr(AppStrings.allPosts),
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.allDoctorPosts,
                                    arguments:
                                        AppRoutesArgs.allDoctorPostsRouteArgs(
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      homeDataModel: effectiveHomeDataModel,
                                      doctorId: widget.currentDoctorModel.id
                                          .toString(),
                                      doctorName: doctorName(
                                        firstName:
                                            widget.currentDoctorModel.firstName,
                                        lastName:
                                            widget.currentDoctorModel.lastName,
                                        role: effectiveHomeDataModel
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.isDarkMode
                  ? [
                      AppColors.darkCardBG.withOpacity(0.7),
                      AppColors.darkCardBG.withOpacity(0.5),
                    ]
                  : [
                      Colors.white,
                      Colors.grey.shade50,
                    ],
            ),
            border: Border.all(
              color: widget.isDarkMode
                  ? AppColors.darkPrimary.withOpacity(0.15)
                  : AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isDarkMode
                    ? Colors.black.withOpacity(0.1)
                    : Colors.grey.shade300.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isDarkMode
                      ? AppColors.darkPrimary.withOpacity(0.2)
                      : AppColors.primary.withOpacity(0.1),
                ),
                child: Icon(
                  icon,
                  size: 15.sp,
                  color: widget.isDarkMode
                      ? AppColors.darkPrimary
                      : AppColors.primary,
                ),
              ),
              SizedBox(width: 7.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.isDarkMode
                          ? AppColors.darkTitle
                          : AppColors.title,
                      fontSize: 12.sp,
                      height: 1.2,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: widget.isDarkMode
                          ? AppColors.darkDescription
                          : Colors.grey.shade700,
                      fontSize: 10.sp,
                      height: 1.0,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 28.h,
      width: 1,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.5),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            widget.isDarkMode
                ? AppColors.darkPrimary.withOpacity(0.2)
                : AppColors.primary.withOpacity(0.3),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
