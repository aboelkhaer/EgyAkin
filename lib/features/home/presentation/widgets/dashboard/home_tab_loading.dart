import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// Full-dashboard skeleton for the Home tab first load.
class HomeTabLoading extends StatelessWidget {
  final bool isDark;

  const HomeTabLoading({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final bone = isDark ? const Color(0xFF353142) : const Color(0xFFDDD7F0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w) +
          EdgeInsets.only(top: 6.h, bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FadeIn(
            delayMs: 0,
            child: _SearchSkeleton(base: base, highlight: highlight, bone: bone),
          ),
          SizedBox(height: 12.h),
          _FadeIn(
            delayMs: 40,
            child: _StatsSkeleton(
              isDark: isDark,
              base: base,
              highlight: highlight,
              bone: bone,
            ),
          ),
          SizedBox(height: 10.h),
          _FadeIn(
            delayMs: 70,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: _Bone(width: 88.w, height: 10.h, color: bone, radius: 5.r),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          _FadeIn(
            delayMs: 100,
            child: _DraftsSkeleton(
              isDark: isDark,
              base: base,
              highlight: highlight,
              bone: bone,
            ),
          ),
          SizedBox(height: 18.h),
          _FadeIn(
            delayMs: 140,
            child: _SectionHeaderSkeleton(
              base: base,
              highlight: highlight,
              bone: bone,
              titleWidth: 110.w,
            ),
          ),
          SizedBox(height: 10.h),
          ...List.generate(2, (i) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _FadeIn(
                delayMs: 170 + (i * 50),
                child: _ListRowSkeleton(
                  isDark: isDark,
                  base: base,
                  highlight: highlight,
                  bone: bone,
                  showAction: true,
                ),
              ),
            );
          }),
          SizedBox(height: 8.h),
          _FadeIn(
            delayMs: 260,
            child: _SectionHeaderSkeleton(
              base: base,
              highlight: highlight,
              bone: bone,
              titleWidth: 150.w,
            ),
          ),
          SizedBox(height: 10.h),
          _FadeIn(
            delayMs: 290,
            child: _ListRowSkeleton(
              isDark: isDark,
              base: base,
              highlight: highlight,
              bone: bone,
              showAction: true,
            ),
          ),
          SizedBox(height: 16.h),
          _FadeIn(
            delayMs: 320,
            child: _SectionHeaderSkeleton(
              base: base,
              highlight: highlight,
              bone: bone,
              titleWidth: 80.w,
            ),
          ),
          SizedBox(height: 12.h),
          _FadeIn(
            delayMs: 350,
            child: _ToggleSkeleton(
              isDark: isDark,
              base: base,
              highlight: highlight,
              bone: bone,
            ),
          ),
          SizedBox(height: 12.h),
          ...List.generate(2, (i) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _FadeIn(
                delayMs: 380 + (i * 55),
                child: _PatientCardSkeleton(
                  isDark: isDark,
                  base: base,
                  highlight: highlight,
                  bone: bone,
                ),
              ),
            );
          }),
          SizedBox(height: 8.h),
          _FadeIn(
            delayMs: 480,
            child: _SectionHeaderSkeleton(
              base: base,
              highlight: highlight,
              bone: bone,
              titleWidth: 56.w,
            ),
          ),
          SizedBox(height: 12.h),
          _FadeIn(
            delayMs: 510,
            child: _ToolsSkeleton(
              isDark: isDark,
              base: base,
              highlight: highlight,
              bone: bone,
            ),
          ),
          SizedBox(height: 14.h),
          _FadeIn(
            delayMs: 550,
            child: _WeekSkeleton(
              isDark: isDark,
              base: base,
              highlight: highlight,
              bone: bone,
            ),
          ),
          SizedBox(height: 14.h),
          _FadeIn(
            delayMs: 590,
            child: _InsightsSkeleton(
              isDark: isDark,
              base: base,
              highlight: highlight,
              bone: bone,
            ),
          ),
        ],
      ),
    );
  }
}

class _FadeIn extends StatelessWidget {
  final int delayMs;
  final Widget child;

  const _FadeIn({
    required this.delayMs,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 420 + delayMs.clamp(0, 240)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 14),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _Bone extends StatelessWidget {
  final double? width;
  final double height;
  final Color color;
  final double radius;

  const _Bone({
    this.width,
    required this.height,
    required this.color,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _SearchSkeleton extends StatelessWidget {
  final Color base;
  final Color highlight;
  final Color bone;

  const _SearchSkeleton({
    required this.base,
    required this.highlight,
    required this.bone,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        height: 38.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: bone,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.centerLeft,
        child: _Bone(width: 160.w, height: 10.h, color: bone, radius: 5.r),
      ),
    );
  }
}

class _StatsSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color bone;

  const _StatsSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.bone,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (i) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : 8.w),
            child: Shimmer.fromColors(
              baseColor: base,
              highlightColor: highlight,
              child: Container(
                padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 10.h),
                decoration: HomeDashboardDecor.card(
                  isDark,
                  color: HomeDashboardColors.primary(isDark)
                      .withOpacity(isDark ? 0.12 : 0.06),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Bone(width: 26.r, height: 26.r, color: bone, radius: 8.r),
                    SizedBox(height: 8.h),
                    _Bone(width: 42.w, height: 16.h, color: bone, radius: 6.r),
                    SizedBox(height: 6.h),
                    _Bone(width: 54.w, height: 10.h, color: bone, radius: 5.r),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _DraftsSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color bone;

  const _DraftsSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.bone,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: HomeDashboardDecor.card(
          isDark,
          color: HomeDashboardColors.primary(isDark)
              .withOpacity(isDark ? 0.12 : 0.06),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _Bone(width: 14.w, height: 14.h, color: bone, radius: 4.r),
                SizedBox(width: 6.w),
                _Bone(width: 100.w, height: 12.h, color: bone, radius: 6.r),
                const Spacer(),
                _Bone(width: 72.w, height: 18.h, color: bone, radius: 20.r),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: HomeDashboardColors.cardBg(isDark),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  _Bone(width: 36.r, height: 36.r, color: bone, radius: 18.r),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Bone(
                            width: 110.w,
                            height: 12.h,
                            color: bone,
                            radius: 6.r),
                        SizedBox(height: 6.h),
                        _Bone(
                            width: 80.w,
                            height: 10.h,
                            color: bone,
                            radius: 5.r),
                      ],
                    ),
                  ),
                  _Bone(width: 64.w, height: 28.h, color: bone, radius: 10.r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeaderSkeleton extends StatelessWidget {
  final Color base;
  final Color highlight;
  final Color bone;
  final double titleWidth;

  const _SectionHeaderSkeleton({
    required this.base,
    required this.highlight,
    required this.bone,
    required this.titleWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Row(
        children: [
          _Bone(width: titleWidth, height: 13.h, color: bone, radius: 6.r),
          const Spacer(),
          _Bone(width: 48.w, height: 11.h, color: bone, radius: 5.r),
        ],
      ),
    );
  }
}

class _ListRowSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color bone;
  final bool showAction;

  const _ListRowSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.bone,
    this.showAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        padding: EdgeInsets.all(11.w),
        decoration: HomeDashboardDecor.card(isDark),
        child: Row(
          children: [
            _Bone(width: 36.r, height: 36.r, color: bone, radius: 18.r),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Bone(width: 120.w, height: 12.h, color: bone, radius: 6.r),
                  SizedBox(height: 6.h),
                  _Bone(width: 90.w, height: 10.h, color: bone, radius: 5.r),
                ],
              ),
            ),
            if (showAction)
              _Bone(width: 70.w, height: 28.h, color: bone, radius: 10.r),
          ],
        ),
      ),
    );
  }
}

class _ToggleSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color bone;

  const _ToggleSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.bone,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: HomeDashboardColors.surfaceBg(isDark),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 36.h,
                decoration: BoxDecoration(
                  color: bone,
                  borderRadius: BorderRadius.circular(11.r),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Container(
                height: 36.h,
                decoration: BoxDecoration(
                  color: bone.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(11.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientCardSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color bone;

  const _PatientCardSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.bone,
  });

  @override
  Widget build(BuildContext context) {
    final accent = HomeDashboardColors.primary(isDark).withOpacity(0.28);

    return Container(
      decoration: HomeDashboardDecor.card(isDark).copyWith(
        borderRadius: BorderRadius.circular(20.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 5.w, color: accent),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: Padding(
                  padding: EdgeInsets.all(11.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          _Bone(
                              width: 32.r,
                              height: 32.r,
                              color: bone,
                              radius: 16.r),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _Bone(
                                    width: 110.w,
                                    height: 12.h,
                                    color: bone,
                                    radius: 6.r),
                                SizedBox(height: 6.h),
                                _Bone(
                                    width: 80.w,
                                    height: 10.h,
                                    color: bone,
                                    radius: 5.r),
                              ],
                            ),
                          ),
                          _Bone(
                              width: 56.w,
                              height: 22.h,
                              color: bone,
                              radius: 20.r),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: HomeDashboardColors.surfaceBg(isDark),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          children: [
                            _Bone(
                                width: 40.w,
                                height: 14.h,
                                color: bone,
                                radius: 6.r),
                            const Spacer(),
                            _Bone(
                                width: 70.w,
                                height: 10.h,
                                color: bone,
                                radius: 5.r),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _Bone(
                                height: 34.h, color: bone, radius: 12.r),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _Bone(
                                height: 34.h, color: bone, radius: 12.r),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolsSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color bone;

  const _ToolsSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.bone,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Row(
        children: List.generate(4, (i) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: i == 0 ? 0 : 8.w),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: HomeDashboardDecor.card(isDark),
                child: Column(
                  children: [
                    _Bone(width: 28.r, height: 28.r, color: bone, radius: 8.r),
                    SizedBox(height: 8.h),
                    _Bone(width: 40.w, height: 9.h, color: bone, radius: 4.r),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _WeekSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color bone;

  const _WeekSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.bone,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: HomeDashboardDecor.card(
          isDark,
          color: HomeDashboardColors.primary(isDark)
              .withOpacity(isDark ? 0.12 : 0.06),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _Bone(width: 14.w, height: 14.h, color: bone, radius: 4.r),
                SizedBox(width: 6.w),
                _Bone(width: 72.w, height: 12.h, color: bone, radius: 6.r),
                const Spacer(),
                _Bone(width: 64.w, height: 10.h, color: bone, radius: 5.r),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: List.generate(3, (i) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i == 0 ? 0 : 8.w),
                    child: Column(
                      children: [
                        _Bone(
                            width: 36.w,
                            height: 16.h,
                            color: bone,
                            radius: 6.r),
                        SizedBox(height: 6.h),
                        _Bone(
                            width: 48.w,
                            height: 10.h,
                            color: bone,
                            radius: 5.r),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightsSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color bone;

  const _InsightsSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.bone,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: HomeDashboardDecor.card(
          isDark,
          color: HomeDashboardColors.primary(isDark)
              .withOpacity(isDark ? 0.12 : 0.06),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _Bone(width: 15.w, height: 15.h, color: bone, radius: 4.r),
                SizedBox(width: 6.w),
                _Bone(width: 120.w, height: 13.h, color: bone, radius: 6.r),
                const Spacer(),
                _Bone(width: 64.w, height: 18.h, color: bone, radius: 20.r),
              ],
            ),
            SizedBox(height: 8.h),
            _Bone(width: 180.w, height: 10.h, color: bone, radius: 5.r),
            SizedBox(height: 14.h),
            _Bone(height: 12.h, color: bone, radius: 6.r),
            SizedBox(height: 12.h),
            _Bone(height: 12.h, color: bone, radius: 6.r),
            SizedBox(height: 12.h),
            _Bone(height: 12.h, color: bone, radius: 6.r),
          ],
        ),
      ),
    );
  }
}
