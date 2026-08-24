import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../../exports.dart';

class AiOpinionCard extends StatelessWidget {
  final bool isDark;
  final String response;
  final String timeAgo;

  const AiOpinionCard({
    super.key,
    required this.isDark,
    required this.response,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: primary.withOpacity(isDark ? 0.22 : 0.12),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: primary.withOpacity(isDark ? 0.35 : 0.2),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/images/ai.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.auto_awesome_rounded,
                    size: 18.sp,
                    color: primary,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
                  decoration: HomeDashboardDecor.card(isDark).copyWith(
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(16.r),
                      bottomStart: Radius.circular(16.r),
                      bottomEnd: Radius.circular(16.r),
                    ),
                    border: Border.all(
                      color: primary.withOpacity(isDark ? 0.28 : 0.16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            context.tr(AppStrings.aiClinicalOpinion),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: primary,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.verified_outlined,
                            size: 14.sp,
                            color: HomeDashboardColors.subtitle(isDark),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      MarkdownBody(
                        data: response,
                        styleSheet: MarkdownStyleSheet(
                          h1: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: HomeDashboardColors.title(isDark),
                          ),
                          h2: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: HomeDashboardColors.title(isDark),
                          ),
                          h3: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: HomeDashboardColors.title(isDark),
                          ),
                          p: TextStyle(
                            fontSize: 13.sp,
                            height: 1.45,
                            color: HomeDashboardColors.title(isDark),
                          ),
                          strong: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: HomeDashboardColors.title(isDark),
                          ),
                          listBullet: TextStyle(
                            fontSize: 13.sp,
                            color: HomeDashboardColors.title(isDark),
                          ),
                          blockSpacing: 8.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 4.w),
              child: Text(
                timeAgo,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
