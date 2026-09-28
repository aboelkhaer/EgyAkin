import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class GroupMembersScreen extends StatefulWidget {
  final String groupId;
  final String postId;
  final String ownerId;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final bool isPostLikes;

  const GroupMembersScreen({
    super.key,
    required this.groupId,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.postId,
    this.isPostLikes = false,
    required this.ownerId,
  });

  @override
  State<GroupMembersScreen> createState() => _GroupMembersScreenState();
}

class _GroupMembersScreenState extends State<GroupMembersScreen> {
  GroupMembersCubit? _cubit;

  @override
  void initState() {
    super.initState();
    if (widget.isPostLikes) {
      context.read<GroupMembersCubit>().getPostLikes(widget.postId);
    } else {
      context.read<GroupMembersCubit>().getGroupMembers(widget.groupId);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<GroupMembersCubit>();
      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController?.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    final cubit = context.read<GroupMembersCubit>();
    if (cubit.isLastPage || cubit.scrollController == null) return;
    if (!cubit.scrollController!.hasClients) return;

    final maxScroll = cubit.scrollController!.position.maxScrollExtent;
    final currentScroll = cubit.scrollController!.position.pixels;
    const threshold = 200.0;
    if (!cubit.isLoadingMoreForScroll &&
        maxScroll - currentScroll <= threshold) {
      cubit.isLoadingMoreForScroll = true;
      if (!widget.isPostLikes) {
        cubit.loadMoreMembers(widget.groupId);
      }
    }
  }

  void _openDoctor(DoctorModel doctor) {
    final doctorId = doctor.id?.toString();
    if (doctorId == null || doctorId.isEmpty) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.somethingWentWrong),
      );
      return;
    }

    // Prefer live home payload — sheet args can carry a stale/partial model.
    HomeModelResponse home = widget.homeDataModel;
    DoctorModel current = widget.currentDoctorModel;
    try {
      final live = resolveHomeCubit();
      if (live.homeDataModel.verified != null ||
          (live.homeDataModel.scoreValue?.isNotEmpty ?? false)) {
        home = live.homeDataModel;
      }
      if (live.currentDoctorModel.id != null) {
        current = live.currentDoctorModel;
      }
    } catch (_) {}

    final points = int.tryParse(home.scoreValue?.trim() ?? '') ??
        int.tryParse(widget.homeDataModel.scoreValue?.trim() ?? '') ??
        0;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctorId,
        currentDoctorModel: current,
        isSyndicateCardRequired:
            (home.isSyndicateCardRequired ??
                    widget.homeDataModel.isSyndicateCardRequired ??
                    '')
                .toString(),
        initialIndex: 0,
        accountVerification: home.verified ??
            widget.homeDataModel.verified ??
            false,
        currentDoctorRole:
            (home.role ?? widget.homeDataModel.role ?? '').toString(),
        currentDoctorPoints: points,
        homeDataModel: home,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  bool get _isSystemAdmin {
    final role = (widget.homeDataModel.role ?? '').trim().toLowerCase();
    return role == AppStrings.roleAdmin.toLowerCase();
  }

  bool get _isGroupOwner {
    final owner = widget.ownerId.trim();
    if (owner.isEmpty) return false;
    final me = widget.currentDoctorModel.id?.toString() ??
        (() {
          try {
            return resolveHomeCubit().currentDoctorModel.id?.toString();
          } catch (_) {
            return null;
          }
        })();
    if (me == null || me.isEmpty) return false;
    return me == owner;
  }

  /// Group admin/owner (or system admin / remove permission) can remove members.
  bool get _canModerate =>
      _isGroupOwner ||
      _isSystemAdmin ||
      PermissionHelper.canPermission(AppPermissions.removeGroupMember);

  Future<void> _confirmAndRemove(DoctorModel doctor) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final primary = HomeDashboardColors.primary(isDark);
        final surface = HomeDashboardColors.cardBg(isDark);
        final title = HomeDashboardColors.title(isDark);
        final sub = HomeDashboardColors.subtitle(isDark);
        final name = doctorDisplayName(doctor, fallback: 'this member');

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 12.h),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 16.h),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: HomeDashboardColors.border(isDark).withOpacity(0.85),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: HomeDashboardColors.border(isDark),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  DoctorCircleAvatar(
                    doctor: doctor,
                    primary: primary,
                    size: 52.r,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    context.tr(AppStrings.removeMember),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: title,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    context.tr(AppStrings.removeMemberConfirm),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                      color: sub,
                    ),
                  ),
                  if (name.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: title,
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: title,
                            side: BorderSide(
                              color: HomeDashboardColors.border(isDark),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(context.tr(AppStrings.cancel)),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HomeDashboardColors.danger,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(context.tr(AppStrings.remove)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (confirmed != true || !mounted) return;
    final cubit = context.read<GroupMembersCubit>();
    cubit.doctorIdForLoading = doctor.id.toString();
    cubit.removeMemberFromGroup(widget.groupId, doctor.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = GroupMembersCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);

        // No nested Scaffold — the host bottom sheet already provides one
        // (with its own ScaffoldMessenger) so snackbars stay on top at the
        // bottom of the sheet instead of under the modal barrier.
        return ColoredBox(
          color: scaffold,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: HomeDashboardColors.border(isDark),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Row(
                  children: [
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: primary.withOpacity(isDark ? 0.2 : 0.12),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        widget.isPostLikes
                            ? Icons.favorite_rounded
                            : Icons.groups_rounded,
                        size: 18.sp,
                        color: primary,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isPostLikes
                                ? context.tr(AppStrings.postLikes)
                                : context.tr(AppStrings.groupMembers),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                              color: HomeDashboardColors.title(isDark),
                            ),
                          ),
                          BlocBuilder<GroupMembersCubit, GroupMembersState>(
                            builder: (context, state) {
                              final subtitle = state.maybeWhen(
                                loaded: (
                                  _,
                                  __,
                                  response,
                                  ___,
                                  ____,
                                  _____,
                                  ______,
                                  _______,
                                  postLikes,
                                ) {
                                  if (widget.isPostLikes) {
                                    final n =
                                        postLikes.data?.data?.length ?? 0;
                                    final unit = n == 1
                                        ? context.tr(AppStrings.likeSingular)
                                        : context.tr(AppStrings.likesPlural);
                                    return '$n $unit';
                                  }
                                  final members =
                                      response.data?.members?.data?.length ??
                                          0;
                                  final pending = response
                                          .data?.pendingInvitations?.length ??
                                      0;
                                  final total = (response
                                          .data?.members?.total ??
                                      members);
                                  final membersLabel =
                                      context.tr(AppStrings.members);
                                  if (pending > 0) {
                                    return '$total $membersLabel · $pending ${context.tr(AppStrings.pending)}';
                                  }
                                  return '$total $membersLabel';
                                },
                                orElse: () => widget.isPostLikes
                                    ? context.tr(AppStrings.loadingLikes)
                                    : context.tr(AppStrings.loadingMembers),
                              );
                              return Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: HomeDashboardColors.subtitle(isDark),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: BlocConsumer<GroupMembersCubit, GroupMembersState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      loaded: (
                        snackBarMessage,
                        dialogMessage,
                        _,
                        __,
                        ___,
                        ____,
                        _____,
                        ______,
                        _______,
                      ) {
                        if (snackBarMessage.isNotEmpty) {
                          customSnackBar(
                            context: context,
                            message: snackBarMessage,
                          );
                        }
                        if (dialogMessage.isNotEmpty) {
                          customSnackBar(
                            context: context,
                            message: dialogMessage,
                          );
                        }
                      },
                      error: (message) {
                        customSnackBar(context: context, message: message);
                      },
                    );
                  },
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 280),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      // Default Stack centers children — short likes lists
                      // were floating mid/bottom. Pin content to the top.
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },
                      child: state.maybeWhen(
                        orElse: () => _MembersLoading(key: const ValueKey('loading'), isDark: isDark),
                        error: (_) => DashboardEmptyState(
                          key: const ValueKey('error'),
                          isDark: isDark,
                          icon: Icons.error_outline_rounded,
                          title: context.tr(AppStrings.couldntLoadMembers),
                          subtitle:
                              context.tr(AppStrings.closeAndOpenMembersAgain),
                          hint: context.tr(AppStrings.checkConnectionAndRetry),
                        ),
                        loaded: (
                          _,
                          __,
                          response,
                          isSeeMore,
                          isRemoveLoading,
                          ___,
                          isAcceptLoading,
                          isDeclineLoading,
                          postLikesResponse,
                        ) {
                          if (widget.isPostLikes) {
                            final likes =
                                postLikesResponse.data?.data ?? const [];
                            if (likes.isEmpty) {
                              return DashboardEmptyState(
                                key: const ValueKey('empty-likes'),
                                isDark: isDark,
                                icon: Icons.favorite_border_rounded,
                                title: context.tr(AppStrings.noLikesYet),
                                subtitle: context.tr(
                                  AppStrings.beTheFirstToLikeThisPost,
                                ),
                                hint: context.tr(AppStrings.likesWillAppearHere),
                              );
                            }
                            return ListView.separated(
                              key: const ValueKey('likes-list'),
                              controller: cubit.scrollController,
                              padding: EdgeInsets.fromLTRB(
                                16.w,
                                4.h,
                                16.w,
                                20.h,
                              ),
                              itemCount: likes.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 8.h),
                              itemBuilder: (context, index) {
                                return FadeInUp(
                                  duration: const Duration(milliseconds: 320),
                                  delay: Duration(
                                    milliseconds: (40 * index).clamp(0, 280),
                                  ),
                                  from: 12,
                                  child: _MemberTile(
                                    isDark: isDark,
                                    primary: primary,
                                    doctor: likes[index],
                                    roleLabel:
                                        context.tr(AppStrings.likedThisPost),
                                    onTap: () => _openDoctor(likes[index]),
                                  ),
                                );
                              },
                            );
                          }

                          final pending =
                              response.data?.pendingInvitations ?? const [];
                          final members =
                              response.data?.members?.data ?? const [];

                          if (pending.isEmpty && members.isEmpty) {
                            return DashboardEmptyState(
                              key: const ValueKey('empty-members'),
                              isDark: isDark,
                              icon: Icons.group_off_rounded,
                              title: context.tr(AppStrings.noMembersYet),
                              subtitle: context.tr(
                                AppStrings.inviteDoctorsToGrowGroup,
                              ),
                              hint: context.tr(
                                AppStrings.useInviteFromGroupHeader,
                              ),
                            );
                          }

                          final items = <Widget>[];
                          var animIndex = 0;

                          if (pending.isNotEmpty) {
                            items.add(
                              FadeIn(
                                duration: const Duration(milliseconds: 280),
                                child: _SectionLabel(
                                  isDark: isDark,
                                  label: context
                                      .tr(AppStrings.pendingInvitations),
                                  count: pending.length,
                                  accent: HomeDashboardColors.warning,
                                ),
                              ),
                            );
                            for (final doctor in pending) {
                              final i = animIndex++;
                              items.add(SizedBox(height: 8.h));
                              items.add(
                                FadeInUp(
                                  duration: const Duration(milliseconds: 340),
                                  delay: Duration(
                                    milliseconds: (45 * i).clamp(0, 360),
                                  ),
                                  from: 14,
                                  child: _MemberTile(
                                    isDark: isDark,
                                    primary: primary,
                                    doctor: doctor,
                                    roleLabel: context.tr(AppStrings.pending),
                                    pending: true,
                                    isAcceptLoading: isAcceptLoading &&
                                        cubit.doctorIdForAcceptOrDeclineMember ==
                                            doctor.id.toString(),
                                    isDeclineLoading: isDeclineLoading &&
                                        cubit.doctorIdForAcceptOrDeclineMember ==
                                            doctor.id.toString(),
                                    onTap: () => _openDoctor(doctor),
                                    onAccept: () {
                                      cubit.acceptOrDeclineMemberInGroup(
                                        groupId: widget.groupId,
                                        invitationId:
                                            doctor.invitationId ?? 0,
                                        status: AcceptOrDeclineMemberInGroup
                                            .accepted.name,
                                        doctorId: doctor.id.toString(),
                                      );
                                    },
                                    onDecline: () {
                                      cubit.acceptOrDeclineMemberInGroup(
                                        groupId: widget.groupId,
                                        invitationId:
                                            doctor.invitationId ?? 0,
                                        status: AcceptOrDeclineMemberInGroup
                                            .declined.name,
                                        doctorId: doctor.id.toString(),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                            items.add(SizedBox(height: 16.h));
                          }

                          if (members.isNotEmpty) {
                            items.add(
                              FadeIn(
                                duration: const Duration(milliseconds: 280),
                                child: _SectionLabel(
                                  isDark: isDark,
                                  label: context.tr(AppStrings.members),
                                  count: response.data?.members?.total ??
                                      members.length,
                                  accent: primary,
                                ),
                              ),
                            );
                            for (final doctor in members) {
                              final i = animIndex++;
                              final isOwner =
                                  doctor.id.toString() == widget.ownerId;
                              final isSelf = doctor.id.toString() ==
                                  widget.currentDoctorModel.id.toString();
                              final canRemove = _canModerate &&
                                  !isSelf &&
                                  !isOwner;

                              items.add(SizedBox(height: 8.h));
                              items.add(
                                FadeInUp(
                                  duration: const Duration(milliseconds: 340),
                                  delay: Duration(
                                    milliseconds: (45 * i).clamp(0, 360),
                                  ),
                                  from: 14,
                                  child: _MemberTile(
                                    isDark: isDark,
                                    primary: primary,
                                    doctor: doctor,
                                    roleLabel: isOwner
                                        ? context.tr(AppStrings.adminOfGroup)
                                        : context.tr(AppStrings.memberOfGroup),
                                    isAdmin: isOwner,
                                    isRemoving: isRemoveLoading &&
                                        cubit.doctorIdForLoading ==
                                            doctor.id.toString(),
                                    onTap: () => _openDoctor(doctor),
                                    onRemove: canRemove
                                        ? () => _confirmAndRemove(doctor)
                                        : null,
                                  ),
                                ),
                              );
                            }
                          }

                          if (isSeeMore) {
                            items.add(
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 18.h),
                                child: Center(
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.2,
                                      color: primary,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            items.add(SizedBox(height: 20.h));
                          }

                          return ListView(
                            key: const ValueKey('members-list'),
                            controller: cubit.scrollController,
                            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                            children: items,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final bool isDark;
  final String label;
  final int count;
  final Color accent;

  const _SectionLabel({
    required this.isDark,
    required this.label,
    required this.count,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.r,
          height: 6.r,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
        SizedBox(width: 6.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: accent.withOpacity(isDark ? 0.18 : 0.12),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
        ),
      ],
    );
  }
}

class _MemberTile extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final DoctorModel doctor;
  final String roleLabel;
  final bool pending;
  final bool isAdmin;
  final bool isAcceptLoading;
  final bool isDeclineLoading;
  final bool isRemoving;
  final VoidCallback onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onRemove;

  const _MemberTile({
    required this.isDark,
    required this.primary,
    required this.doctor,
    required this.roleLabel,
    required this.onTap,
    this.pending = false,
    this.isAdmin = false,
    this.isAcceptLoading = false,
    this.isDeclineLoading = false,
    this.isRemoving = false,
    this.onAccept,
    this.onDecline,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final name = doctorDisplayName(doctor);
    final verified = doctorIsVerified(doctor);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onRemove,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 10.w, 10.h),
          decoration: BoxDecoration(
            color: HomeDashboardColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.85),
            ),
          ),
          child: Row(
            children: [
              DoctorCircleAvatar(
                doctor: doctor,
                primary: isAdmin
                    ? primary
                    : HomeDashboardColors.border(isDark),
                size: 44.r,
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
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: HomeDashboardColors.title(isDark),
                            ),
                          ),
                        ),
                        if (verified) ...[
                          SizedBox(width: 4.w),
                          const VerificationIcon(),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      roleLabel,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: pending
                            ? HomeDashboardColors.warning
                            : isAdmin
                                ? primary
                                : HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              if (pending) ...[
                _RoundAction(
                  isDark: isDark,
                  color: HomeDashboardColors.danger,
                  icon: Icons.close_rounded,
                  loading: isDeclineLoading,
                  onTap: onDecline,
                ),
                SizedBox(width: 6.w),
                _RoundAction(
                  isDark: isDark,
                  color: HomeDashboardColors.success,
                  icon: Icons.check_rounded,
                  loading: isAcceptLoading,
                  onTap: onAccept,
                ),
              ] else ...[
                if (onRemove != null) ...[
                  _RemoveMemberChip(
                    isDark: isDark,
                    loading: isRemoving,
                    onTap: onRemove!,
                  ),
                  SizedBox(width: 4.w),
                ],
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color:
                      HomeDashboardColors.subtitle(isDark).withOpacity(0.7),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RemoveMemberChip extends StatelessWidget {
  final bool isDark;
  final bool loading;
  final VoidCallback onTap;

  const _RemoveMemberChip({
    required this.isDark,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = HomeDashboardColors.danger;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: color.withOpacity(isDark ? 0.18 : 0.12),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: color.withOpacity(0.35)),
          ),
          child: loading
              ? SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.8,
                    color: color,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_remove_rounded, size: 14.sp, color: color),
                    SizedBox(width: 4.w),
                    Text(
                      context.tr(AppStrings.remove),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  final bool isDark;
  final Color color;
  final IconData icon;
  final bool loading;
  final VoidCallback? onTap;

  const _RoundAction({
    required this.isDark,
    required this.color,
    required this.icon,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: loading ? null : onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          width: 34.r,
          height: 34.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(isDark ? 0.18 : 0.12),
          ),
          child: loading
              ? Padding(
                  padding: EdgeInsets.all(8.r),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                )
              : Icon(icon, size: 16.sp, color: color),
        ),
      ),
    );
  }
}

class _MembersLoading extends StatelessWidget {
  final bool isDark;

  const _MembersLoading({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final bone = isDark ? const Color(0xFF353142) : const Color(0xFFDDD7F0);

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: HomeDashboardColors.cardBg(isDark),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bone,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 80.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: bone,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
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
