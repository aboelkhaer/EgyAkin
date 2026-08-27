import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class PatientSectionsCommentsPreview extends StatefulWidget {
  final bool isDark;
  final String patientId;
  final String patientName;
  final DoctorModel currentDoctorModel;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;

  const PatientSectionsCommentsPreview({
    super.key,
    required this.isDark,
    required this.patientId,
    required this.patientName,
    required this.currentDoctorModel,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<PatientSectionsCommentsPreview> createState() =>
      _PatientSectionsCommentsPreviewState();
}

class _PatientSectionsCommentsPreviewState
    extends State<PatientSectionsCommentsPreview> {
  bool _loading = true;
  List<CommentModel> _preview = [];
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    final result =
        await sl<GetPatientCommentsUsecase>().execute(widget.patientId);
    if (!mounted) return;

    result.fold(
      (_) {
        setState(() {
          _loading = false;
          _preview = [];
          _totalCount = 0;
        });
      },
      (response) {
        final comments = response.data ?? <CommentModel>[];
        setState(() {
          _loading = false;
          _totalCount = comments.length;
          _preview = comments.take(2).toList();
        });
      },
    );
  }

  void _openAllComments() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.comments,
      arguments: AppRoutesArgs.patientCommentsRouteArgs(
        patientId: widget.patientId,
        currentDoctorModel: widget.currentDoctorModel,
        verified: widget.homeDataModel.verified ?? false,
        patientName: widget.patientName,
        currentDoctorPoints: widget.currentDoctorPoints,
        currentDoctorRole: widget.currentDoctorRole,
        homeDataModel: widget.homeDataModel,
        isSyndicateCardRequired:
            widget.homeDataModel.isSyndicateCardRequired?.toString() ?? '',
      ),
    );
  }

  static final _arabicChar = RegExp(r'[\u0600-\u06FF]');
  static final _latinChar = RegExp(r'[A-Za-z]');
  static final _strongChar = RegExp(r'[A-Za-z\u0600-\u06FF]');

  TextDirection _directionFor(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return TextDirection.ltr;
    for (final match in _strongChar.allMatches(trimmed)) {
      final ch = match.group(0)!;
      if (_arabicChar.hasMatch(ch)) return TextDirection.rtl;
      if (_latinChar.hasMatch(ch)) return TextDirection.ltr;
    }
    return TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final primary = HomeDashboardColors.primary(isDark);
    final titleColor = HomeDashboardColors.title(isDark);
    final subtitleColor = HomeDashboardColors.subtitle(isDark);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 10.h),
          child: Row(
            children: [
              Text(
                context.tr(AppStrings.patientComments).toUpperCase(),
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                  color: isDark
                      ? const Color(0xFF9A96A6)
                      : const Color(0xFF9CA3AF),
                ),
              ),
              if (_totalCount > 0) ...[
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primary.withOpacity(isDark ? 0.35 : 0.2),
                        primary.withOpacity(isDark ? 0.18 : 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: primary.withOpacity(0.28)),
                  ),
                  child: Text(
                    '$_totalCount',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: primary,
                    ),
                  ),
                ),
              ],
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 1,
                  color: isDark
                      ? const Color(0xFF2E2E36)
                      : const Color(0xFFE5E7EB),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: HomeDashboardColors.cardBg(isDark),
              border: Border.all(
                color: isDark
                    ? primary.withOpacity(0.28)
                    : HomeDashboardColors.border(isDark),
              ),
              boxShadow: [
                if (isDark)
                  BoxShadow(
                    color: primary.withOpacity(0.16),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  )
                else ...[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: primary.withOpacity(0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? [
                                  primary.withOpacity(0.28),
                                  HomeDashboardColors.cardBg(isDark),
                                  HomeDashboardColors.cardBg(isDark),
                                ]
                              : [
                                  primary.withOpacity(0.08),
                                  const Color(0xFFFAFAFC),
                                  Colors.white,
                                ],
                          stops: const [0, 0.34, 1],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -36,
                    right: -24,
                    child: IgnorePointer(
                      child: Container(
                        width: 120.r,
                        height: 120.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              primary.withOpacity(isDark ? 0.28 : 0.08),
                              primary.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    left: -20,
                    child: IgnorePointer(
                      child: Container(
                        width: 100.r,
                        height: 100.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              primary.withOpacity(isDark ? 0.14 : 0.04),
                              primary.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
                    child: _loading
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            child: Center(
                              child: SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: primary,
                                ),
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 38.r,
                                    height: 38.r,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          primary,
                                          Color.lerp(
                                            primary,
                                            const Color(0xFF1F2937),
                                            0.28,
                                          )!,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primary.withOpacity(
                                            isDark ? 0.4 : 0.28,
                                          ),
                                          blurRadius: 12,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.forum_rounded,
                                      color: Colors.white,
                                      size: 18.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context.tr(
                                            AppStrings.clinicalDiscussion,
                                          ),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -0.2,
                                            color: titleColor,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          _totalCount == 0
                                              ? context.tr(
                                                  AppStrings.noCommentsYet,
                                                )
                                              : context.tr(
                                                  AppStrings.clinicalThread,
                                                ),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: subtitleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14.h),
                              if (_preview.isEmpty)
                                _EmptyCommentsState(
                                  isDark: isDark,
                                  primary: primary,
                                  titleColor: titleColor,
                                  subtitleColor: subtitleColor,
                                )
                              else
                                ...List.generate(_preview.length, (index) {
                                  final comment = _preview[index];
                                  final isMine =
                                      comment.doctor?.id?.toString() ==
                                          widget.currentDoctorModel.id
                                              .toString();
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: index == _preview.length - 1
                                          ? 0
                                          : 10.h,
                                    ),
                                    child: _PreviewCommentCard(
                                      isDark: isDark,
                                      comment: comment,
                                      isMine: isMine,
                                      showConnector:
                                          index < _preview.length - 1,
                                      textDirection: _directionFor(
                                        comment.content ?? '',
                                      ),
                                    ),
                                  );
                                }),
                              SizedBox(height: 14.h),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _openAllComments,
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Ink(
                                    height: 34.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          primary,
                                          Color.lerp(
                                            primary,
                                            const Color(0xFF4C1D95),
                                            0.35,
                                          )!,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primary.withOpacity(0.28),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          context.tr(
                                            AppStrings.viewAllComments,
                                          ),
                                          style: TextStyle(
                                            fontSize: 11.5.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 14.sp,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
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
    );
  }
}

class _EmptyCommentsState extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color subtitleColor;

  const _EmptyCommentsState({
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : HomeDashboardColors.surfaceBg(false),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: HomeDashboardColors.border(isDark),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 52.r,
            height: 52.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primary.withOpacity(isDark ? 0.18 : 0.1),
              border: Border.all(color: primary.withOpacity(0.22)),
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              color: primary,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            context.tr(AppStrings.noCommentsYet),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w800,
              color: titleColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            context.tr(AppStrings.shareClinicalNotesAndCollaborate),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewCommentCard extends StatelessWidget {
  final bool isDark;
  final CommentModel comment;
  final bool isMine;
  final bool showConnector;
  final TextDirection textDirection;

  const _PreviewCommentCard({
    required this.isDark,
    required this.comment,
    required this.isMine,
    required this.showConnector,
    required this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final titleColor = HomeDashboardColors.title(isDark);
    final subtitleColor = HomeDashboardColors.subtitle(isDark);
    final doctor = comment.doctor;
    final firstName = doctor?.firstName ?? '';
    final initial = firstName.isNotEmpty ? firstName[0].toUpperCase() : 'D';
    final name = doctorName(
      firstName: doctor?.firstName ?? '',
      lastName: doctor?.lastName ?? '',
      role: doctor?.isSyndicateCardRequired.toString() ?? '',
    );
    final content = (comment.content ?? '').trim();
    final timeAgo = TimeAgoService.instance.formatTimeAgoFromString(
      comment.updatedAt.toString(),
      context,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40.w,
            child: Column(
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isMine
                          ? primary.withOpacity(0.55)
                          : HomeDashboardColors.border(isDark),
                      width: 1.6,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(isDark ? 0.2 : 0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: doctor?.image == null ||
                            doctor!.image.toString().isEmpty
                        ? HomeInitialsAvatar(initials: initial, radius: 17)
                        : CustomCachedNetworkImage(
                            imageUrl: doctor.image.toString(),
                            height: 36.r,
                            width: 36.r,
                          ),
                  ),
                ),
                if (showConnector)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            primary.withOpacity(isDark ? 0.4 : 0.3),
                            primary.withOpacity(0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(12.w, 11.h, 12.w, 11.h),
              decoration: BoxDecoration(
                color: isMine
                    ? primary.withOpacity(isDark ? 0.18 : 0.08)
                    : HomeDashboardColors.cardBg(isDark),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                border: Border.all(
                  color: isMine
                      ? primary.withOpacity(isDark ? 0.38 : 0.2)
                      : HomeDashboardColors.border(isDark),
                ),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.035),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          isMine
                              ? '$name ${context.tr(AppStrings.youInParentheses)}'
                              : name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: isMine ? primary : titleColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: HomeDashboardColors.surfaceBg(isDark)
                              .withOpacity(isDark ? 0.8 : 0.95),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          timeAgo,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: subtitleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  Directionality(
                    textDirection: textDirection,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        content.isEmpty ? '—' : content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                          color: titleColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
