import 'package:egy_akin/features/create_group_in_community/presentation/cubit/create_group_in_community_state.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class CreateGroupInCommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final bool isCreateNewGroup;
  final GroupModel? groupModel;
  const CreateGroupInCommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.isCreateNewGroup,
    this.groupModel,
  });

  @override
  State<CreateGroupInCommunityScreen> createState() =>
      _CreateGroupInCommunityScreenState();
}

class _CreateGroupInCommunityScreenState
    extends State<CreateGroupInCommunityScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    if (widget.isCreateNewGroup == false) {
      context
          .read<CreateGroupInCommunityCubit>()
          .addEditableGroupModel(widget.groupModel!);
      _parseGroupPrivacy(widget.groupModel!.privacy, context);
    }
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 680),
    );
    _fade = CurvedAnimation(
      parent: _intro,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _intro,
        curve: const Interval(0.12, 0.85, curve: Curves.easeOutCubic),
      ),
    );
    _intro.forward();
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  void _submit(CreateGroupInCommunityCubit cubit) {
    if (cubit.editableGroupModel == null) {
      cubit.createGroup();
      return;
    }
    final groupId = cubit.editableGroupModel!.id.toString();
    if (cubit.imagePickedForGroupHeader == null &&
        cubit.imagePickedForGroupImage == null) {
      cubit.updateGroupTexts(groupId);
      return;
    }
    if (cubit.imagePickedForGroupHeader != null &&
        cubit.imagePickedForGroupImage == null) {
      cubit.updateGroupHeaderImage(groupId);
      return;
    }
    if (cubit.imagePickedForGroupHeader == null &&
        cubit.imagePickedForGroupImage != null) {
      cubit.updateGroupImage(groupId);
      return;
    }
    cubit.updateGroupHeaderImageAndGroupImage(groupId);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = CreateGroupInCommunityCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final top = MediaQuery.paddingOf(context).top;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: scaffold,
            body: BlocConsumer<CreateGroupInCommunityCubit,
                CreateGroupInCommunityState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (
                    snackBarMessage,
                    dialogMessage,
                    isPickGroupHeaderLoading,
                    isPickGroupImageLoading,
                    counterChanges,
                    isCreateGroupLoading,
                    isCreateGroupLoaded,
                  ) {
                    if (snackBarMessage.isNotEmpty) {
                      customSnackBar(
                        context: context,
                        message: snackBarMessage,
                      );
                    }
                    if (isCreateGroupLoaded) {
                      navigatorKey.currentState?.pushReplacementNamed(
                        AppRoutes.home,
                        arguments: 0,
                      );
                      Future.delayed(Duration.zero, () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.community,
                          arguments: AppRoutesArgs.communityRouteArgs(
                            homeDataModel: widget.homeDataModel,
                            currentDoctorModel: widget.currentDoctorModel,
                            initialTab: 2,
                          ),
                        );
                      });
                      Future.delayed(Duration.zero, () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.allGroupsInCommunity,
                          arguments:
                              AppRoutesArgs.allGroupsInCommunityRouteArgs(
                            currentDoctorModel: widget.currentDoctorModel,
                            homeDataModel: widget.homeDataModel,
                          ),
                        );
                      });
                    }
                  },
                );
              },
              builder: (context, state) {
                final loaded = state.maybeWhen(
                  orElse: () => null,
                  loaded: (
                    snackBarMessage,
                    dialogMessage,
                    isPickGroupHeaderLoading,
                    isPickGroupImageLoading,
                    counterChanges,
                    isCreateGroupLoading,
                    isCreateGroupLoaded,
                  ) =>
                      (
                    headerLoading: isPickGroupHeaderLoading,
                    imageLoading: isPickGroupImageLoading,
                    submitting: isCreateGroupLoading,
                  ),
                );
                final headerLoading = loaded?.headerLoading ?? false;
                final imageLoading = loaded?.imageLoading ?? false;
                final submitting = loaded?.submitting ?? false;
                final coverH = top + 96.h;
                final avatar = 92.r;
                final overlap = avatar / 2;
                final existingCoverUrl =
                    widget.groupModel?.headerPicture?.toString().trim() ?? '';
                final hasCoverImage = cubit.imagePickedForGroupHeader != null ||
                    (!widget.isCreateNewGroup && existingCoverUrl.isNotEmpty);
                final useLightCoverChrome = !isDark && !hasCoverImage;
                final coverFg = useLightCoverChrome
                    ? const Color(0xFF1F2937)
                    : Colors.white;

                return PopScope(
                  canPop: !submitting,
                  child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: submitting,
                            child: Opacity(
                              opacity: submitting ? 0.55 : 1,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FadeTransition(
                                      opacity: _fade,
                                      child: SizedBox(
                                        height: coverH + overlap,
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              height: coverH,
                                              child: GestureDetector(
                                                onTap: cubit.pickGroupHeaderImage,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    _CoverPreview(
                                                      cubit: cubit,
                                                      isCreateNewGroup:
                                                          widget.isCreateNewGroup,
                                                      existingUrl: widget
                                                          .groupModel?.headerPicture
                                                          ?.toString(),
                                                      isDark: isDark,
                                                      primary: primary,
                                                    ),
                                                    DecoratedBox(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: useLightCoverChrome
                                                      ? [
                                                          primary
                                                              .withOpacity(0.20),
                                                          primary
                                                              .withOpacity(0.06),
                                                          Colors.black
                                                              .withOpacity(0.03),
                                                        ]
                                                      : [
                                                          Colors.black
                                                              .withOpacity(0.45),
                                                          Colors.black
                                                              .withOpacity(0.05),
                                                          Colors.black
                                                              .withOpacity(0.18),
                                                        ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: top + 6.h,
                                              left: 8.w,
                                              right: 12.w,
                                              child: Row(
                                                children: [
                                                  Material(
                                                    color: useLightCoverChrome
                                                        ? Colors.white
                                                        : Colors.black
                                                            .withOpacity(0.28),
                                                    shape: const CircleBorder(),
                                                    child: InkWell(
                                                      customBorder:
                                                          const CircleBorder(),
                                                      onTap: () =>
                                                          Navigator.pop(context),
                                                      child: Container(
                                                        width: 36.w,
                                                        height: 36.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color:
                                                                useLightCoverChrome
                                                                    ? const Color(
                                                                        0xFFE6E2F0)
                                                                    : Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.22),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .arrow_back_ios_new_rounded,
                                                          size: 16.sp,
                                                          color: coverFg,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Expanded(
                                                    child: Text(
                                                      widget.isCreateNewGroup
                                                          ? context.tr(
                                                              AppStrings
                                                                  .createGroup,
                                                            )
                                                          : context.tr(
                                                              AppStrings
                                                                  .updateGroup,
                                                            ),
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: coverFg,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              top: top + 48.h,
                                              bottom: 18.h,
                                              child: Center(
                                                child: headerLoading
                                                    ? SizedBox(
                                                        width: 26.r,
                                                        height: 26.r,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2.2,
                                                          color: useLightCoverChrome
                                                              ? primary
                                                              : Colors.white,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 48.r,
                                                        height: 48.r,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: useLightCoverChrome
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.92)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.42),
                                                          shape:
                                                              BoxShape.circle,
                                                          border: useLightCoverChrome
                                                              ? Border.all(
                                                                  color: const Color(
                                                                      0xFFE6E2F0),
                                                                )
                                                              : null,
                                                          boxShadow:
                                                              useLightCoverChrome
                                                                  ? [
                                                                      BoxShadow(
                                                                        color: primary
                                                                            .withOpacity(
                                                                                0.18),
                                                                        blurRadius:
                                                                            12,
                                                                        offset:
                                                                            const Offset(
                                                                                0,
                                                                                4),
                                                                      ),
                                                                    ]
                                                                  : null,
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          size: 22.sp,
                                                          color:
                                                              useLightCoverChrome
                                                                  ? primary
                                                                  : Colors
                                                                      .white,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 16.w,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: cubit.pickGroupImage,
                                        child: SizedBox(
                                          width: avatar,
                                          height: avatar,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: avatar,
                                                height: avatar,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: scaffold,
                                                  border: Border.all(
                                                    color: scaffold,
                                                    width: 3.r,
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child: _AvatarPreview(
                                                    cubit: cubit,
                                                    isCreateNewGroup: widget
                                                        .isCreateNewGroup,
                                                    existingUrl: widget
                                                        .groupModel?.groupImage
                                                        ?.toString(),
                                                    isDark: isDark,
                                                    primary: primary,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  width: 30.r,
                                                  height: 30.r,
                                                  decoration: BoxDecoration(
                                                    color: primary,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: scaffold,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: imageLoading
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.r),
                                                          child:
                                                              const CircularProgressIndicator(
                                                            strokeWidth: 1.8,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          size: 14.sp,
                                                          color: Colors.white,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SlideTransition(
                              position: _slide,
                              child: FadeTransition(
                                opacity: _fade,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.w, 14.h, 16.w, 20.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FadeInUp(
                                        from: 10,
                                        duration:
                                            const Duration(milliseconds: 420),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.fromLTRB(
                                              12.w, 12.h, 12.w, 8.h),
                                          decoration:
                                              HomeDashboardDecor.card(isDark),
                                          child: CustomTextFormField(
                                            title:
                                                context.tr(AppStrings.title),
                                            textInputType: TextInputType.text,
                                            fillColor: HomeDashboardColors
                                                .surfaceBg(isDark),
                                            initialValue:
                                                widget.isCreateNewGroup
                                                    ? null
                                                    : widget.groupModel!.name,
                                            validator: (_) => null,
                                            onChanged: (value) {
                                              cubit.groupHeaderText = value;
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      FadeInUp(
                                        from: 10,
                                        duration:
                                            const Duration(milliseconds: 420),
                                        delay: const Duration(
                                            milliseconds: 60),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.fromLTRB(
                                              12.w, 12.h, 12.w, 8.h),
                                          decoration:
                                              HomeDashboardDecor.card(isDark),
                                          child: CustomTextFormField(
                                            title: context
                                                .tr(AppStrings.description),
                                            textInputType:
                                                TextInputType.multiline,
                                            minLines: 6,
                                            maxLines: 8,
                                            maxLength: 500,
                                            showCounter: true,
                                            fillColor: HomeDashboardColors
                                                .surfaceBg(isDark),
                                            initialValue:
                                                widget.isCreateNewGroup
                                                    ? null
                                                    : widget.groupModel!
                                                        .description,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: HomeDashboardColors.title(
                                                  isDark),
                                            ),
                                            validator: (_) => null,
                                            onChanged: (value) {
                                              cubit.groupDescriptionText =
                                                  value;
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      FadeInUp(
                                        from: 10,
                                        duration:
                                            const Duration(milliseconds: 420),
                                        delay: const Duration(
                                            milliseconds: 110),
                                        child: Text(
                                          context.tr(AppStrings.privacy),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                            color: HomeDashboardColors.title(
                                                isDark),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      FadeInUp(
                                        from: 10,
                                        duration:
                                            const Duration(milliseconds: 420),
                                        delay: const Duration(
                                            milliseconds: 140),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: _PrivacyCard(
                                                isDark: isDark,
                                                primary: primary,
                                                selected: cubit.privacy ==
                                                    GroupPrivacy.public,
                                                icon: Icons.public_rounded,
                                                title: context
                                                    .tr(AppStrings.public),
                                                subtitle: context.tr(
                                                    AppStrings.anyoneCanFindAndJoin),
                                                onTap: () => cubit.setPrivacy(
                                                  GroupPrivacy.public,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: _PrivacyCard(
                                                isDark: isDark,
                                                primary: primary,
                                                selected: cubit.privacy ==
                                                    GroupPrivacy.private,
                                                icon: Icons.lock_rounded,
                                                title: context
                                                    .tr(AppStrings.private),
                                                subtitle: context.tr(
                                                    AppStrings.membersJoinByInvite),
                                                onTap: () => cubit.setPrivacy(
                                                  GroupPrivacy.private,
                                                ),
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
                          ],
                        ),
                      ),
                    ),
                          ),
                        ),
                    FadeInUp(
                      from: 8,
                      duration: const Duration(milliseconds: 420),
                      delay: const Duration(milliseconds: 180),
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                          child: SizedBox(
                            width: double.infinity,
                            height: 38.h,
                            child: ElevatedButton(
                              onPressed:
                                  submitting ? null : () => _submit(cubit),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                disabledBackgroundColor:
                                    primary.withOpacity(0.7),
                                foregroundColor: Colors.white,
                                disabledForegroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              child: submitting
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 16.r,
                                          height: 16.r,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          widget.isCreateNewGroup
                                              ? context.tr(
                                                  AppStrings.creatingEllipsis)
                                              : context.tr(
                                                  AppStrings.updatingEllipsis),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      widget.isCreateNewGroup
                                          ? context.tr(AppStrings.create)
                                          : context.tr(AppStrings.update),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                      ],
                    ),
                    if (submitting)
                      _GroupSubmitOverlay(
                        isDark: isDark,
                        primary: primary,
                        isCreate: widget.isCreateNewGroup,
                      ),
                  ],
                ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _parseGroupPrivacy(String? privacy, BuildContext context) {
    if (privacy == 'public') {
      context.read<CreateGroupInCommunityCubit>().privacySetValue =
          GroupPrivacy.public;
      return;
    } else if (privacy == 'private') {
      context.read<CreateGroupInCommunityCubit>().privacySetValue =
          GroupPrivacy.private;
      return;
    }
  }
}

class _GroupSubmitOverlay extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool isCreate;

  const _GroupSubmitOverlay({
    required this.isDark,
    required this.primary,
    required this.isCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AbsorbPointer(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          builder: (context, t, child) {
            return Opacity(
              opacity: t,
              child: child,
            );
          },
          child: ColoredBox(
            color: Colors.black.withOpacity(isDark ? 0.55 : 0.35),
            child: Center(
              child: Container(
                width: 260.w,
                padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 22.h),
                decoration: BoxDecoration(
                  color: HomeDashboardColors.cardBg(isDark),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: HomeDashboardColors.border(isDark).withOpacity(0.8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 52.r,
                      height: 52.r,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 52.r,
                            height: 52.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: primary,
                              backgroundColor: primary.withOpacity(0.15),
                            ),
                          ),
                          Icon(
                            Icons.cloud_upload_rounded,
                            size: 22.sp,
                            color: primary,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      isCreate
                          ? context.tr(AppStrings.creatingYourGroup)
                          : context.tr(AppStrings.updatingYourGroup),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      context.tr(AppStrings.uploadingImagesAndSavingDetails),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CoverPreview extends StatelessWidget {
  final CreateGroupInCommunityCubit cubit;
  final bool isCreateNewGroup;
  final String? existingUrl;
  final bool isDark;
  final Color primary;

  const _CoverPreview({
    required this.cubit,
    required this.isCreateNewGroup,
    required this.existingUrl,
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    if (!isCreateNewGroup && cubit.imagePickedForGroupHeader == null) {
      return CustomCachedNetworkImage(
        imageUrl: existingUrl.toString(),
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    if (cubit.imagePickedForGroupHeader != null) {
      return Image.file(
        cubit.imagePickedForGroupHeader!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [
                  Color(0xFF4A2F7A),
                  Color(0xFF2B1A52),
                  Color(0xFF1A1428),
                ]
              : const [
                  Color(0xFFF3EEFF),
                  Color(0xFFEDE7FF),
                  Color(0xFFE0D7FF),
                ],
        ),
      ),
    );
  }
}

class _AvatarPreview extends StatelessWidget {
  final CreateGroupInCommunityCubit cubit;
  final bool isCreateNewGroup;
  final String? existingUrl;
  final bool isDark;
  final Color primary;

  const _AvatarPreview({
    required this.cubit,
    required this.isCreateNewGroup,
    required this.existingUrl,
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    if (!isCreateNewGroup && cubit.imagePickedForGroupImage == null) {
      return CustomCachedNetworkImage(
        imageUrl: existingUrl.toString(),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    if (cubit.imagePickedForGroupImage != null) {
      return Image.file(
        cubit.imagePickedForGroupImage!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return ColoredBox(
      color: primary.withOpacity(isDark ? 0.22 : 0.16),
      child: Icon(
        Icons.groups_rounded,
        color: primary,
                                        size: 32.sp,
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool selected;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PrivacyCard({
    required this.isDark,
    required this.primary,
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        decoration: BoxDecoration(
          color: selected
              ? primary.withOpacity(isDark ? 0.22 : 0.1)
              : HomeDashboardColors.cardBg(isDark),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected
                ? primary
                : HomeDashboardColors.border(isDark).withOpacity(0.8),
            width: selected ? 1.6 : 1,
          ),
          boxShadow: isDark || selected
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.035),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: selected
                  ? primary
                  : HomeDashboardColors.subtitle(isDark),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.sp,
                height: 1.3,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
