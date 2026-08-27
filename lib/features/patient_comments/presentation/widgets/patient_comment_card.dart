import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/patient_comments/presentation/widgets/delete_comment_dialog.dart';

import '../../../../exports.dart';

class PatientCommentCard extends StatelessWidget {
  final bool isDark;
  final CommentModel commentModel;
  final DoctorModel currentDoctorModel;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;
  final VoidCallback onDelete;
  final bool isMine;
  final bool showConnector;

  const PatientCommentCard({
    super.key,
    required this.isDark,
    required this.commentModel,
    required this.currentDoctorModel,
    required this.currentDoctorRole,
    required this.homeDataModel,
    required this.onDelete,
    required this.isMine,
    this.showConnector = true,
  });

  static final _arabicChar = RegExp(r'[\u0600-\u06FF]');
  static final _latinChar = RegExp(r'[A-Za-z]');
  static final _strongChar = RegExp(r'[A-Za-z\u0600-\u06FF]');

  TextDirection _getTextDirection(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return TextDirection.ltr;
    for (final match in _strongChar.allMatches(trimmed)) {
      final ch = match.group(0)!;
      if (_arabicChar.hasMatch(ch)) return TextDirection.rtl;
      if (_latinChar.hasMatch(ch)) return TextDirection.ltr;
    }
    return TextDirection.ltr;
  }

  Future<void> _onLongPress(BuildContext context) async {
    final doctorId = commentModel.doctor?.id?.toString();
    final canManage = doctorId == currentDoctorModel.id.toString() ||
        currentDoctorRole == AppStrings.roleAdmin;
    if (!canManage) return;

    final hasPermission = await PermissionHelper.hasPermission(
      AppPermissions.deletePatientComment,
    );

    if (!context.mounted) return;

    if (hasPermission) {
      showDeleteCommentDialog(
        context: context,
        isDark: isDark,
        onConfirm: onDelete,
      );
    } else {
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.attention),
        description: context
            .tr(AppStrings.youDontHavePermissionToDeletePatientComments),
        coloredButtonText: context.tr(AppStrings.ok),
        coloredButtonOnTap: () => Navigator.of(context).pop(),
        isNoColorShow: false,
      );
    }
  }

  void _openDoctorProfile() {
    final doctor = commentModel.doctor;
    if (doctor?.id == null) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctor!.id.toString(),
        currentDoctorModel: currentDoctorModel,
        isSyndicateCardRequired:
            homeDataModel.isSyndicateCardRequired.toString(),
        accountVerification: homeDataModel.verified!,
        currentDoctorRole: currentDoctorRole,
        currentDoctorPoints: int.parse(homeDataModel.scoreValue!),
        homeDataModel: homeDataModel,
        initialIndex: 0,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final doctor = commentModel.doctor;
    final content = commentModel.content ?? '';
    final firstName = doctor?.firstName ?? '';
    final initial = firstName.isNotEmpty ? firstName[0].toUpperCase() : 'D';
    final name = doctorName(
      firstName: doctor?.firstName ?? '',
      lastName: doctor?.lastName ?? '',
      role: doctor?.isSyndicateCardRequired.toString() ?? '',
    );
    final timeAgo = TimeAgoService.instance.formatTimeAgoFromString(
      commentModel.updatedAt.toString(),
      context,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: () => _onLongPress(context),
        borderRadius: BorderRadius.circular(18.r),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 40.w,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _openDoctorProfile,
                      child: Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isMine
                                ? primary.withOpacity(0.55)
                                : HomeDashboardColors.border(isDark),
                            width: 1.5,
                          ),
                        ),
                        child: ClipOval(
                          child: doctor?.image == null ||
                                  doctor!.image.toString().isEmpty
                              ? HomeInitialsAvatar(
                                  initials: initial,
                                  radius: 17,
                                )
                              : CustomCachedNetworkImage(
                                  imageUrl: doctor.image.toString(),
                                  height: 36.r,
                                  width: 36.r,
                                ),
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
                                primary.withOpacity(isDark ? 0.35 : 0.25),
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
                        ? primary.withOpacity(isDark ? 0.16 : 0.08)
                        : HomeDashboardColors.cardBg(isDark),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                    border: Border.all(
                      color: isMine
                          ? primary.withOpacity(isDark ? 0.35 : 0.2)
                          : HomeDashboardColors.border(isDark).withOpacity(0.75),
                    ),
                    boxShadow: isDark
                        ? null
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: _openDoctorProfile,
                              child: Text(
                                isMine
                                    ? '$name ${context.tr(AppStrings.youInParentheses)}'
                                    : name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: isMine
                                      ? primary
                                      : HomeDashboardColors.title(isDark),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: HomeDashboardColors.surfaceBg(isDark),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              timeAgo,
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                                color: HomeDashboardColors.subtitle(isDark),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Directionality(
                        textDirection: _getTextDirection(content),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            content,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13.sp,
                              height: 1.45,
                              fontWeight: FontWeight.w500,
                              color: HomeDashboardColors.title(isDark),
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
        ),
      ),
    );
  }
}
