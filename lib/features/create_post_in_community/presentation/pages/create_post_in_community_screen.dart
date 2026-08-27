import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_state.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/pages/create_poll_screen.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/widgets/build_setting_item.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../exports.dart';

class CreatePostInCommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final PostCommunityModel? feed;
  final String? groupId;
  final String? groupName;
  final VoidCallback? onPostUploaded;

  const CreatePostInCommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.feed,
    this.groupId,
    this.groupName,
    this.onPostUploaded,
  });

  @override
  State<CreatePostInCommunityScreen> createState() =>
      _CreatePostInCommunityScreenState();
}

class _CreatePostInCommunityScreenState
    extends State<CreatePostInCommunityScreen>
    with SingleTickerProviderStateMixin {
  PollModel? _poll;
  late final ValueNotifier<TextDirection> _textDirectionNotifier;
  late final AnimationController _enterCtrl;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    if (widget.feed != null) {
      context
          .read<CreatePostInCommunityCubit>()
          .emitLoadedStateForEditPost(widget.feed!);
    }
    _textDirectionNotifier = ValueNotifier(_initialTextDirection());
    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _fadeIn = CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutCubic);
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutCubic));
    _enterCtrl.forward();
  }

  @override
  void dispose() {
    _textDirectionNotifier.dispose();
    _enterCtrl.dispose();
    super.dispose();
  }

  TextDirection _initialTextDirection() {
    final cubit = context.read<CreatePostInCommunityCubit>();
    final content = cubit.editableFeed?.content ?? '';
    if (content.trim().isNotEmpty) {
      final firstChar = content.trim()[0];
      final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(firstChar);
      return hasArabic ? TextDirection.rtl : TextDirection.ltr;
    }
    return context.isRTL ? TextDirection.rtl : TextDirection.ltr;
  }

  Future<void> _createPoll() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePollScreen(
          onPollCreated: (poll) {
            setState(() => _poll = poll);
          },
          initialOptionCount: 2,
          existingPoll: _poll,
        ),
      ),
    );
  }

  void _deletePoll() {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkCardBG : AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            context.tr(AppStrings.deletePoll),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTitle : AppColors.title,
            ),
          ),
          content: Text(
            context.tr(AppStrings.areYouSureYouWantToDeleteThisPoll),
            style: TextStyle(
              fontSize: 12.sp,
              color: isDark ? AppColors.darkDescription : AppColors.description,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                context.tr(AppStrings.cancel),
                style: TextStyle(
                  color: isDark
                      ? AppColors.darkDescription
                      : AppColors.description,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() => _poll = null);
                Navigator.pop(context);
              },
              child: Text(
                context.tr(AppStrings.delete),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onTextChanged(CreatePostInCommunityCubit cubit, String value) {
    if (cubit.editableFeed == null) {
      cubit.postContent = value;
    } else {
      cubit.editFeedContentForEditableFeed(value);
    }

    if (value.trim().isNotEmpty) {
      final firstChar = value.trim()[0];
      final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(firstChar);
      _textDirectionNotifier.value =
          hasArabic ? TextDirection.rtl : TextDirection.ltr;
    } else {
      _textDirectionNotifier.value =
          context.isRTL ? TextDirection.rtl : TextDirection.ltr;
    }

    cubit.changePostLength(value.length);
  }

  void _handleUploadSuccess() {
    final cubit = CreatePostInCommunityCubit.get(context);
    final hasHashtags = RegExp(
      r'#[a-zA-Z0-9_\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+',
    ).hasMatch(cubit.postContent);

    // Only refresh trends when a new post includes hashtags.
    if (widget.feed == null && hasHashtags) {
      sl<TrendingCubit>().refreshTrends();
    }

    navigatorKey.currentState?.pop();

    if (widget.groupId != null) {
      widget.onPostUploaded?.call();
      return;
    }

    // Refresh feeds once — avoid pushReplacement(home) + push(community),
    // which created two CommunityScreens and called getAllFeeds twice.
    sl<CommunityCubit>().getAllFeeds();

    final homeCubit = sl<HomeCubit>();
    if (!homeCubit.isClosed) {
      homeCubit.jumpToCommunityTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = CreatePostInCommunityCubit.get(context);
    final isEdit = widget.feed != null;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final palette = _StudioPalette(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent)
              : SystemUiOverlayStyle.dark
                  .copyWith(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: palette.canvas,
            body: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                final fullHeight = MediaQuery.sizeOf(context).height;
                return Stack(
                  children: [
                    // Atmosphere pinned to full screen height so
                    // keyboard insets don't shift the glow blobs.
                    Positioned.fill(
                      child: IgnorePointer(
                        child: OverflowBox(
                          maxHeight: fullHeight,
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: fullHeight,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -80.h,
                                  right: -60.w,
                                  child: Container(
                                    width: 260.w,
                                    height: 260.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          palette.glow.withOpacity(
                                            isDark ? 0.35 : 0.22,
                                          ),
                                          palette.glow.withOpacity(0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: fullHeight * 0.48,
                                  left: -90.w,
                                  child: Container(
                                    width: 220.w,
                                    height: 220.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          palette.glowAlt.withOpacity(
                                            isDark ? 0.22 : 0.12,
                                          ),
                                          palette.glowAlt.withOpacity(0),
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
                    Column(
                      children: [
                        _StudioTopBar(
                          palette: palette,
                          isEdit: isEdit,
                          onBack: () => Navigator.of(context).maybePop(),
                        ),
                        Expanded(
                          child: FadeTransition(
                            opacity: _fadeIn,
                            child: SlideTransition(
                              position: _slideIn,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                padding:
                                    EdgeInsets.fromLTRB(18.w, 4.h, 18.w, 16.h),
                                children: [
                                  _IdentityPill(
                                    palette: palette,
                                    imageUrl: cubit.editableFeed != null
                                        ? cubit.editableFeed!.doctor!.image
                                            .toString()
                                        : widget.currentDoctorModel.image
                                            .toString(),
                                    name: cubit.editableFeed != null
                                        ? doctorName(
                                            firstName: cubit.editableFeed!
                                                .doctor!.firstName,
                                            lastName: cubit
                                                .editableFeed!.doctor!.lastName,
                                            role: cubit.editableFeed!.doctor!
                                                .isSyndicateCardRequired
                                                .toString(),
                                          )
                                        : doctorName(
                                            firstName: widget
                                                .currentDoctorModel.firstName,
                                            lastName: widget
                                                .currentDoctorModel.lastName,
                                            role: widget.homeDataModel
                                                .isSyndicateCardRequired
                                                .toString(),
                                          ),
                                    showVerified: cubit.editableFeed != null
                                        ? true
                                        : widget.currentDoctorModel
                                                .isSyndicateCardRequired ==
                                            'Verified',
                                    destinationLabel: () {
                                      final name = widget.groupName?.trim();
                                      if (name != null && name.isNotEmpty) {
                                        return name;
                                      }
                                      if (widget.groupId != null) {
                                        return context.tr(AppStrings.groupFeed);
                                      }
                                      return context.tr(AppStrings.community);
                                    }(),
                                    postingInGroup: widget.groupId != null,
                                  ),
                                  SizedBox(height: 16.h),
                                  _WritingSheet(
                                    palette: palette,
                                    textDirectionNotifier:
                                        _textDirectionNotifier,
                                    initialValue: cubit.editableFeed?.content,
                                    hint:
                                        context.tr(AppStrings.whatsOnYourMind),
                                    onChanged: (value) =>
                                        _onTextChanged(cubit, value),
                                  ),
                                  SizedBox(height: 10.h),
                                  BlocBuilder<CreatePostInCommunityCubit,
                                      CreatePostInCommunityState>(
                                    builder: (context, state) {
                                      final length = state.maybeWhen(
                                        orElse: () => 0,
                                        loaded: (postLength, _, __, ___, ____,
                                                _____) =>
                                            postLength,
                                      );
                                      return _CharacterMeter(
                                        palette: palette,
                                        length: length,
                                        max: 3000,
                                      );
                                    },
                                  ),
                                  if (_poll != null) ...[
                                    SizedBox(height: 16.h),
                                    _BallotCard(
                                      palette: palette,
                                      poll: _poll!,
                                      onEdit: _createPoll,
                                      onDelete: _deletePoll,
                                    ),
                                  ],
                                  BlocBuilder<CreatePostInCommunityCubit,
                                      CreatePostInCommunityState>(
                                    builder: (context, state) {
                                      final c = CreatePostInCommunityCubit.get(
                                          context);
                                      final hasLocal =
                                          c.imagesPicked.isNotEmpty;
                                      final hasRemote =
                                          c.editableFeed?.mediaPath != null &&
                                              c.editableFeed!.mediaPath!
                                                  .isNotEmpty;
                                      if (!hasLocal && !hasRemote) {
                                        return SizedBox(height: 12.h);
                                      }
                                      return Padding(
                                        padding: EdgeInsets.only(top: 16.h),
                                        child: Column(
                                          children: [
                                            _MediaFilmstrip(
                                              palette: palette,
                                              localCount: c.imagesPicked.length,
                                              localBuilder: (i) => Image.file(
                                                c.imagesPicked[i],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                              onRemoveLocal: c.removeImage,
                                              remoteCount: hasRemote
                                                  ? c.editableFeed!.mediaPath!
                                                      .length
                                                  : 0,
                                              remoteBuilder: (i) => FadeIn(
                                                child: CachedNetworkImage(
                                                  imageUrl: c.editableFeed!
                                                      .mediaPath![i],
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                              ),
                                              onRemoveRemote: c
                                                  .removeMediaPathInEditableFeed,
                                            ),
                                            if (hasLocal) ...[
                                              SizedBox(height: 12.h),
                                              _UploadQualitySelector(
                                                palette: palette,
                                                mode: c.uploadMode,
                                                onChanged: c.setUploadMode,
                                              ),
                                            ],
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                        _StudioDock(
                          palette: palette,
                          isKeyboardVisible: isKeyboardVisible,
                          isEdit: isEdit,
                          poll: _poll,
                          feed: widget.feed,
                          onCreatePoll: _createPoll,
                          onPickGallery: () =>
                              cubit.pickImageAndShowIt(false, context),
                          onPickCamera: () =>
                              cubit.pickImageAndShowIt(true, context),
                          submitListener: BlocListener<
                              CreatePostInCommunityCubit,
                              CreatePostInCommunityState>(
                            listener: (context, state) {
                              state.maybeWhen(
                                orElse: () {},
                                error: (message) {
                                  customSnackBar(
                                    context: context,
                                    message: message,
                                  );
                                },
                                loaded: (
                                  postLength,
                                  changeCounter,
                                  isImagePick,
                                  isUploadPostLoading,
                                  isUploadPostLoaded,
                                  message,
                                ) {
                                  if (message != '') {
                                    customSnackBar(
                                      context: context,
                                      message: message,
                                    );
                                  }
                                  if (isUploadPostLoaded) {
                                    _handleUploadSuccess();
                                  }
                                },
                              );
                            },
                            child: const SizedBox.shrink(),
                          ),
                          onSubmit: () => cubit.submitPost(
                            context,
                            widget.groupId,
                            _poll,
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<CreatePostInCommunityCubit,
                        CreatePostInCommunityState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const SizedBox.shrink(),
                          loaded: (
                            _,
                            __,
                            isImagePick,
                            isUploadPostLoading,
                            ___,
                            ____,
                          ) {
                            if (!isImagePick && !isUploadPostLoading) {
                              return const SizedBox.shrink();
                            }
                            final c = CreatePostInCommunityCubit.get(context);
                            return _PostBusyOverlay(
                              palette: palette,
                              isPicking: isImagePick,
                              isPublishing: isUploadPostLoading,
                              imageCount: c.imagesPicked.length,
                              isEdit: isEdit,
                              isFastMode:
                                  c.uploadMode == PostImageUploadMode.fast,
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _UploadQualitySelector extends StatelessWidget {
  final _StudioPalette palette;
  final PostImageUploadMode mode;
  final ValueChanged<PostImageUploadMode> onChanged;

  const _UploadQualitySelector({
    required this.palette,
    required this.mode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: palette.toolBg.withOpacity(palette.isDark ? 0.85 : 1),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: palette.line.withOpacity(0.75)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _QualityChip(
              palette: palette,
              selected: mode == PostImageUploadMode.fast,
              icon: Icons.bolt_rounded,
              title: context.tr(AppStrings.faster),
              subtitle: context.tr(AppStrings.smallerFiles),
              onTap: () => onChanged(PostImageUploadMode.fast),
            ),
          ),
          Expanded(
            child: _QualityChip(
              palette: palette,
              selected: mode == PostImageUploadMode.fullQuality,
              icon: Icons.high_quality_rounded,
              title: context.tr(AppStrings.fullQuality),
              subtitle: context.tr(AppStrings.originalSize),
              onTap: () => onChanged(PostImageUploadMode.fullQuality),
            ),
          ),
        ],
      ),
    );
  }
}

class _QualityChip extends StatelessWidget {
  final _StudioPalette palette;
  final bool selected;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QualityChip({
    required this.palette,
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? palette.accent.withOpacity(0.14) : Colors.transparent,
      borderRadius: BorderRadius.circular(11.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: selected ? palette.accent : palette.muted,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: selected ? palette.accent : palette.ink,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: palette.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostBusyOverlay extends StatelessWidget {
  final _StudioPalette palette;
  final bool isPicking;
  final bool isPublishing;
  final int imageCount;
  final bool isEdit;
  final bool isFastMode;

  const _PostBusyOverlay({
    required this.palette,
    required this.isPicking,
    required this.isPublishing,
    required this.imageCount,
    required this.isEdit,
    required this.isFastMode,
  });

  @override
  Widget build(BuildContext context) {
    final photoLabel = context.tr(
      imageCount == 1 ? AppStrings.photoSingular : AppStrings.photosPlural,
    );
    final title = isPicking
        ? context.tr(AppStrings.preparingPhotos)
        : (isEdit
            ? context.tr(AppStrings.savingYourPost)
            : context.tr(AppStrings.publishingYourPost));
    final subtitle = isPicking
        ? context.tr(AppStrings.openingYourGalleryAndAddingSelectedImages)
        : (imageCount > 0
            ? (isFastMode
                ? '${context.tr(AppStrings.optimizingAndUploading)} $imageCount $photoLabel…'
                : '${context.tr(AppStrings.uploading)} $imageCount $photoLabel ${context.tr(AppStrings.inFullQualityEllipsis)}')
            : context.tr(AppStrings.sendingYourPost));

    return PopScope(
      canPop: false,
      child: Positioned.fill(
        child: AbsorbPointer(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            builder: (context, t, child) => Opacity(opacity: t, child: child),
            child: ColoredBox(
              color: Colors.black.withOpacity(palette.isDark ? 0.55 : 0.38),
              child: Center(
                child: Container(
                  width: 280.w,
                  padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 22.h),
                  decoration: BoxDecoration(
                    color: palette.sheet,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: palette.line.withOpacity(0.85)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.22),
                        blurRadius: 28,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 54.r,
                        height: 54.r,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 54.r,
                              height: 54.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: palette.accent,
                                backgroundColor:
                                    palette.accent.withOpacity(0.16),
                              ),
                            ),
                            Icon(
                              isPicking
                                  ? Icons.photo_library_outlined
                                  : (isFastMode
                                      ? Icons.bolt_rounded
                                      : Icons.cloud_upload_rounded),
                              size: 22.sp,
                              color: palette.accent,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                          color: palette.ink,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          height: 1.35,
                          fontWeight: FontWeight.w500,
                          color: palette.muted,
                        ),
                      ),
                      if (isPublishing && imageCount > 0) ...[
                        SizedBox(height: 14.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: palette.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            isFastMode
                                ? context.tr(AppStrings.faster)
                                : context.tr(AppStrings.fullQuality),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: palette.accent,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StudioPalette {
  final bool isDark;

  const _StudioPalette(this.isDark);

  Color get canvas => isDark ? AppColors.darkScaffoldBG : AppColors.scaffoldBG;
  Color get sheet => isDark ? AppColors.darkCardBG : AppColors.white;
  Color get ink => isDark ? AppColors.darkTitle : AppColors.title;
  Color get muted => isDark ? AppColors.darkDescription : AppColors.description;
  Color get line =>
      isDark ? AppColors.darkBorder : AppColors.primary.withOpacity(0.14);
  Color get glow => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get glowAlt => isDark ? AppColors.primary : AppColors.darkPrimary;
  Color get accent => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get cta => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get toolBg => isDark ? AppColors.darkSurface : AppColors.subBG;
}

class _StudioTopBar extends StatelessWidget {
  final _StudioPalette palette;
  final bool isEdit;
  final VoidCallback onBack;

  const _StudioTopBar({
    required this.palette,
    required this.isEdit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 6.h, 18.w, 8.h),
        child: Row(
          children: [
            Material(
              color: palette.sheet.withOpacity(0.9),
              shape: const CircleBorder(),
              elevation: palette.isDark ? 0 : 1.5,
              shadowColor: Colors.black26,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onBack,
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: palette.ink,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEdit
                        ? context.tr(AppStrings.editDraftUpper)
                        : context.tr(AppStrings.newPostUpper),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                      color: palette.accent,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    isEdit
                        ? context.tr(AppStrings.editPost)
                        : context.tr(AppStrings.compose),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                      color: palette.ink,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IdentityPill extends StatelessWidget {
  final _StudioPalette palette;
  final String imageUrl;
  final String name;
  final bool showVerified;
  final String destinationLabel;
  final bool postingInGroup;

  const _IdentityPill({
    required this.palette,
    required this.imageUrl,
    required this.name,
    required this.showVerified,
    required this.destinationLabel,
    this.postingInGroup = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 14.w, 8.h),
      decoration: BoxDecoration(
        color: palette.sheet.withOpacity(palette.isDark ? 0.85 : 0.95),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: palette.line.withOpacity(0.7)),
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: palette.accent.withOpacity(0.45), width: 1.5),
            ),
            clipBehavior: Clip.antiAlias,
            child: CustomCachedNetworkImage(
              imageUrl: imageUrl,
              height: 34.w,
              width: 34.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w700,
                          color: palette.ink,
                        ),
                      ),
                    ),
                    if (showVerified) ...[
                      SizedBox(width: 4.w),
                      const VerificationIcon(isPatientCard: false),
                    ],
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(
                      postingInGroup
                          ? Icons.groups_rounded
                          : Icons.public_rounded,
                      size: 12.sp,
                      color: palette.accent,
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        postingInGroup
                            ? '${context.tr(AppStrings.postingIn)} $destinationLabel'
                            : '${context.tr(AppStrings.publishingTo)} $destinationLabel',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: palette.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HashtagTextEditingController extends TextEditingController {
  _HashtagTextEditingController({
    String? text,
    required this.hashtagStyle,
  }) : super(text: text);

  TextStyle hashtagStyle;

  static final RegExp _patternRegex = RegExp(
    r'(#[a-zA-Z0-9_\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+)|(\*[^*]+\*)',
  );

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // Keep default composing underline behavior for IME input.
    if (withComposing && value.composing.isValid && value.isComposingRangeValid) {
      return super.buildTextSpan(
        context: context,
        style: style,
        withComposing: withComposing,
      );
    }

    final text = value.text;
    if (text.isEmpty || !_patternRegex.hasMatch(text)) {
      return TextSpan(style: style, text: text);
    }

    final boldStyle = (style ?? const TextStyle()).merge(
      const TextStyle(fontWeight: FontWeight.w800),
    );
    final starStyle = (style ?? const TextStyle()).merge(
      TextStyle(
        fontWeight: FontWeight.w500,
        color: (style?.color ?? Colors.grey).withOpacity(0.45),
      ),
    );

    final children = <InlineSpan>[];
    var start = 0;
    for (final match in _patternRegex.allMatches(text)) {
      if (match.start > start) {
        children.add(TextSpan(
          text: text.substring(start, match.start),
          style: style,
        ));
      }

      final matched = match.group(0)!;
      if (matched.startsWith('#')) {
        // Use the exact controller text — no extra Unicode isolates,
        // or the caret lags behind by the injected character count.
        children.add(TextSpan(
          text: matched,
          style: style?.merge(hashtagStyle) ?? hashtagStyle,
        ));
      } else if (matched.startsWith('*') && matched.endsWith('*')) {
        // Keep '*' visible for editing; emphasize the word between them.
        children.add(TextSpan(text: '*', style: starStyle));
        children.add(TextSpan(
          text: matched.substring(1, matched.length - 1),
          style: boldStyle,
        ));
        children.add(TextSpan(text: '*', style: starStyle));
      }

      start = match.end;
    }
    if (start < text.length) {
      children.add(TextSpan(
        text: text.substring(start),
        style: style,
      ));
    }

    return TextSpan(style: style, children: children);
  }
}

class _WritingSheet extends StatefulWidget {
  final _StudioPalette palette;
  final ValueNotifier<TextDirection> textDirectionNotifier;
  final String? initialValue;
  final String hint;
  final ValueChanged<String> onChanged;

  const _WritingSheet({
    required this.palette,
    required this.textDirectionNotifier,
    required this.initialValue,
    required this.hint,
    required this.onChanged,
  });

  @override
  State<_WritingSheet> createState() => _WritingSheetState();
}

class _WritingSheetState extends State<_WritingSheet> {
  late final _HashtagTextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _HashtagTextEditingController(
      text: widget.initialValue,
      hashtagStyle: TextStyle(
        color: widget.palette.accent,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant _WritingSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.palette.accent != widget.palette.accent) {
      _controller.hashtagStyle = TextStyle(
        color: widget.palette.accent,
        fontWeight: FontWeight.w700,
      );
      _controller.notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = widget.palette;
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(22.r),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 220.h),
        decoration: BoxDecoration(
          color: palette.sheet,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: palette.line.withOpacity(0.65)),
          boxShadow: palette.isDark
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      palette.accent,
                      palette.accent.withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 16.h, 16.w, 14.h),
                  child: ValueListenableBuilder<TextDirection>(
                    valueListenable: widget.textDirectionNotifier,
                    builder: (context, textDirection, _) {
                      return TextField(
                        controller: _controller,
                        style: TextStyle(
                          color: palette.ink,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.55,
                          letterSpacing: -0.15,
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          hintText: widget.hint,
                          hintStyle: TextStyle(
                            color: palette.muted.withOpacity(0.85),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.55,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.zero,
                          counterText: '',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 7,
                        maxLength: 3000,
                        textDirection: textDirection,
                        onChanged: widget.onChanged,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterMeter extends StatelessWidget {
  final _StudioPalette palette;
  final int length;
  final int max;

  const _CharacterMeter({
    required this.palette,
    required this.length,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (length / max).clamp(0.0, 1.0);
    final nearLimit = length > max * 0.9;

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 3.h,
              backgroundColor: palette.line.withOpacity(0.55),
              valueColor: AlwaysStoppedAnimation(
                nearLimit ? Colors.red : palette.accent,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          '$length / $max',
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: nearLimit ? Colors.red : palette.muted,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

class _BallotCard extends StatelessWidget {
  final _StudioPalette palette;
  final PollModel poll;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _BallotCard({
    required this.palette,
    required this.poll,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: palette.sheet,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: palette.line.withOpacity(0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: palette.accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  context.tr(AppStrings.poll).toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                    color: palette.accent,
                  ),
                ),
              ),
              const Spacer(),
              _MiniIconBtn(
                palette: palette,
                icon: Icons.edit_outlined,
                onTap: onEdit,
              ),
              SizedBox(width: 6.w),
              _MiniIconBtn(
                palette: palette,
                icon: Icons.delete_outline_rounded,
                onTap: onDelete,
                danger: true,
              ),
            ],
          ),
          if (poll.question?.isNotEmpty ?? false) ...[
            SizedBox(height: 12.h),
            Text(
              poll.question!,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15.sp,
                color: palette.ink,
                letterSpacing: -0.2,
              ),
            ),
          ],
          SizedBox(height: 12.h),
          ...?(poll.options?.asMap().entries.map((entry) {
            final i = entry.key;
            final option = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
                decoration: BoxDecoration(
                  color: palette.toolBg.withOpacity(palette.isDark ? 0.7 : 1),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22.w,
                      height: 22.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: palette.accent, width: 1.4),
                      ),
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          color: palette.accent,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: palette.ink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
          if ((poll.allowMultipleChoices ?? false) ||
              (poll.allowAddOptions ?? false)) ...[
            SizedBox(height: 4.h),
            if (poll.allowMultipleChoices ?? false)
              buildSettingItem(
                icon: Icons.check_box_outlined,
                label: context.tr(AppStrings.allowMultipleChoices),
              ),
            if (poll.allowAddOptions ?? false)
              buildSettingItem(
                icon: Icons.add_circle_outline,
                label: context.tr(AppStrings.allowAddOptions),
              ),
          ],
        ],
      ),
    );
  }
}

class _MiniIconBtn extends StatelessWidget {
  final _StudioPalette palette;
  final IconData icon;
  final VoidCallback onTap;
  final bool danger;

  const _MiniIconBtn({
    required this.palette,
    required this.icon,
    required this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: palette.toolBg,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Icon(
            icon,
            size: 16.sp,
            color: danger ? Colors.red : palette.ink,
          ),
        ),
      ),
    );
  }
}

class _MediaFilmstrip extends StatelessWidget {
  final _StudioPalette palette;
  final int localCount;
  final Widget Function(int index) localBuilder;
  final void Function(int index) onRemoveLocal;
  final int remoteCount;
  final Widget Function(int index) remoteBuilder;
  final void Function(int index) onRemoveRemote;

  const _MediaFilmstrip({
    required this.palette,
    required this.localCount,
    required this.localBuilder,
    required this.onRemoveLocal,
    required this.remoteCount,
    required this.remoteBuilder,
    required this.onRemoveRemote,
  });

  @override
  Widget build(BuildContext context) {
    final total = localCount + remoteCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${context.tr(AppStrings.attachmentsUpper)} · $total',
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
            color: palette.muted,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 108.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: total,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final isLocal = index < localCount;
              final localIndex = index;
              final remoteIndex = index - localCount;
              return Stack(
                children: [
                  Container(
                    width: 108.w,
                    height: 108.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: palette.line),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: isLocal
                        ? localBuilder(localIndex)
                        : remoteBuilder(remoteIndex),
                  ),
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: Material(
                      color: Colors.black.withOpacity(0.55),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          if (isLocal) {
                            onRemoveLocal(localIndex);
                          } else {
                            onRemoveRemote(remoteIndex);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Icon(
                            Icons.close_rounded,
                            size: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StudioDock extends StatelessWidget {
  final _StudioPalette palette;
  final bool isKeyboardVisible;
  final bool isEdit;
  final PollModel? poll;
  final PostCommunityModel? feed;
  final VoidCallback onCreatePoll;
  final VoidCallback onPickGallery;
  final VoidCallback onPickCamera;
  final VoidCallback onSubmit;
  final Widget submitListener;

  const _StudioDock({
    required this.palette,
    required this.isKeyboardVisible,
    required this.isEdit,
    required this.poll,
    required this.feed,
    required this.onCreatePoll,
    required this.onPickGallery,
    required this.onPickCamera,
    required this.onSubmit,
    required this.submitListener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostInCommunityCubit, CreatePostInCommunityState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loaded: (
            postLength,
            changeCounter,
            isImagePick,
            isUploadPostLoading,
            isUploadPostLoaded,
            message,
          ) {
            final cubit = CreatePostInCommunityCubit.get(context);
            final hasPoll = poll != null || (cubit.editableFeed?.poll != null);
            final hasImages = cubit.imagesPicked.isNotEmpty ||
                (cubit.editableFeed?.mediaPath?.isNotEmpty ?? false);

            if (feed != null && feed!.poll != null) {
              if (isKeyboardVisible) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [submitListener],
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  submitListener,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 18.h),
                    color: palette.sheet,
                    child: Text(
                      context.tr(AppStrings.yourPollHasBeenPublished),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: palette.muted,
                      ),
                    ),
                  ),
                ],
              );
            }

            // Keep the writing area clear while typing.
            if (isKeyboardVisible) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [submitListener],
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                submitListener,
                Container(
                  decoration: BoxDecoration(
                    color: palette.sheet.withOpacity(0.96),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(26.r)),
                    border: Border(
                      top: BorderSide(color: palette.line.withOpacity(0.8)),
                    ),
                    boxShadow: palette.isDark
                        ? null
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 20,
                              offset: const Offset(0, -6),
                            ),
                          ],
                  ),
                  child: SafeArea(
                    top: false,
                    minimum: EdgeInsets.only(bottom: 10.h),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
                      child: isImagePick
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Center(
                                child: SizedBox(
                                  width: 26.w,
                                  height: 26.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.4,
                                    color: palette.accent,
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    if (!hasPoll) ...[
                                      _ToolChip(
                                        palette: palette,
                                        icon: Icons.image_outlined,
                                        label: context.tr(AppStrings.gallery),
                                        onTap: onPickGallery,
                                      ),
                                      SizedBox(width: 8.w),
                                      _ToolChip(
                                        palette: palette,
                                        icon: Icons.photo_camera_outlined,
                                        label: context.tr(AppStrings.camera),
                                        onTap: onPickCamera,
                                      ),
                                      if (!hasImages) SizedBox(width: 8.w),
                                    ],
                                    if (!hasImages)
                                      _ToolChip(
                                        palette: palette,
                                        icon: Icons.how_to_vote_outlined,
                                        label: context.tr(AppStrings.poll),
                                        onTap: onCreatePoll,
                                      ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  width: double.infinity,
                                  height: 40.h,
                                  child: Material(
                                    color: palette.cta,
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: InkWell(
                                      onTap:
                                          isUploadPostLoading ? null : onSubmit,
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Center(
                                        child: isUploadPostLoading
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 16.w,
                                                    height: 16.w,
                                                    child:
                                                        const CircularProgressIndicator(
                                                      strokeWidth: 2.2,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Text(
                                                    isEdit
                                                        ? context.tr(
                                                            AppStrings
                                                                .savingEllipsis,
                                                          )
                                                        : context.tr(
                                                            AppStrings
                                                                .publishingEllipsis,
                                                          ),
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.send_rounded,
                                                    size: 15.sp,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 6.w),
                                                  Text(
                                                    isEdit
                                                        ? context
                                                            .tr(AppStrings.save)
                                                        : context.tr(
                                                            AppStrings.addPost),
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                      letterSpacing: -0.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ToolChip extends StatelessWidget {
  final _StudioPalette palette;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ToolChip({
    required this.palette,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: palette.toolBg,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 11.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16.sp, color: palette.accent),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: palette.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
