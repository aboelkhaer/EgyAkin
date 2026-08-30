import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/exports.dart';

class PendingExternalInvite {
  final String email;
  final String? inviteMessage;

  const PendingExternalInvite({
    required this.email,
    this.inviteMessage,
  });
}

bool isValidDoctorEmail(String value) {
  final email = value.trim();
  return email.isNotEmpty &&
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
}

/// Shown when search finds no in-app doctor for a typed email.
class InviteFromSearchPanel extends StatelessWidget {
  final bool isDark;
  final String email;
  final VoidCallback onInvite;

  const InviteFromSearchPanel({
    super.key,
    required this.isDark,
    required this.email,
    required this.onInvite,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final title = HomeDashboardColors.title(isDark);
    final subtitle = HomeDashboardColors.subtitle(isDark);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withOpacity(isDark ? 0.18 : 0.1),
                    ),
                    child: Icon(
                      Icons.mark_email_unread_outlined,
                      size: 28.sp,
                      color: primary,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    context.tr(AppStrings.noDoctorsFound),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: title,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    context.tr(AppStrings.noAccountForEmailInvite),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1.35,
                      color: subtitle,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onInvite,
                      borderRadius: BorderRadius.circular(14.r),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDark
                                ? [
                                    primary.withOpacity(0.28),
                                    primary.withOpacity(0.1),
                                  ]
                                : [
                                    primary.withOpacity(0.14),
                                    primary.withOpacity(0.05),
                                  ],
                          ),
                          border: Border.all(
                            color: primary.withOpacity(isDark ? 0.4 : 0.25),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(14.w, 14.h, 12.w, 14.h),
                        child: Row(
                          children: [
                            Container(
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(isDark ? 0.3 : 0.14),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.person_add_alt_1_rounded,
                                size: 20.sp,
                                color: primary,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr(AppStrings.addEmailToInviteList),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                      color: title,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    email,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.add_circle_outline_rounded,
                              size: 22.sp,
                              color: primary,
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
        );
      },
    );
  }
}
