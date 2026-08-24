import '../../../../exports.dart';

/// Skeleton that mirrors the Patient Sections layout (header + progress + cards).
class PatientSectionsLoadingShimmer extends StatelessWidget {
  final bool isDark;

  const PatientSectionsLoadingShimmer({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F7);
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final card = isDark ? AppColors.darkCardBG : Colors.white;
    final border = isDark ? AppColors.darkBorder : const Color(0xFFE8E4F5);
    final glow = isDark ? const Color(0xFF5B3FA0) : const Color(0xFFC4B5FD);

    return ColoredBox(
      color: scaffold,
      child: Column(
        children: [
          _HeaderSkeleton(
            isDark: isDark,
            base: base,
            highlight: highlight,
            glow: glow,
          ),
          Expanded(
            child: FadeIn(
              duration: const Duration(milliseconds: 360),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                children: [
                  _LabelSkeleton(base: base, highlight: highlight),
                  SizedBox(height: 10.h),
                  FadeInUp(
                    from: 14,
                    duration: const Duration(milliseconds: 420),
                    child: _ProgressCardSkeleton(
                      isDark: isDark,
                      base: base,
                      highlight: highlight,
                      card: card,
                      border: border,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  FadeInUp(
                    from: 12,
                    duration: const Duration(milliseconds: 420),
                    delay: const Duration(milliseconds: 60),
                    child: _GroupHeaderSkeleton(
                      base: base,
                      highlight: highlight,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ...List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: FadeInUp(
                        from: 16,
                        duration: const Duration(milliseconds: 420),
                        delay: Duration(milliseconds: 90 + (index * 55)),
                        child: _SectionCardSkeleton(
                          isDark: isDark,
                          base: base,
                          highlight: highlight,
                          card: card,
                          border: border,
                          titleWidthFactor: index.isEven ? 0.62 : 0.48,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 8.h),
                  FadeInUp(
                    from: 12,
                    duration: const Duration(milliseconds: 420),
                    delay: const Duration(milliseconds: 380),
                    child: _GroupHeaderSkeleton(
                      base: base,
                      highlight: highlight,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ...List.generate(2, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: FadeInUp(
                        from: 16,
                        duration: const Duration(milliseconds: 420),
                        delay: Duration(milliseconds: 420 + (index * 55)),
                        child: _SectionCardSkeleton(
                          isDark: isDark,
                          base: base,
                          highlight: highlight,
                          card: card,
                          border: border,
                          titleWidthFactor: 0.55,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color glow;

  const _HeaderSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.glow,
  });

  @override
  Widget build(BuildContext context) {
    final headerBase =
        isDark ? const Color(0xFF16141C) : const Color(0xFFF8F7FB);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            headerBase,
            Color.lerp(headerBase, glow, isDark ? 0.22 : 0.18)!,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 16.h),
          child: Shimmer.fromColors(
            baseColor: base,
            highlightColor: highlight,
            child: Column(
              children: [
                Row(
                  children: [
                    _bone(width: 34.w, height: 34.w, radius: 17.r),
                    const Spacer(),
                    _bone(width: 34.w, height: 34.w, radius: 17.r),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Container(
                      width: 64.r,
                      height: 64.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: base,
                        border: Border.all(
                          color: highlight.withOpacity(0.5),
                          width: 3,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _bone(width: 150.w, height: 16.h, radius: 8.r),
                          SizedBox(height: 8.h),
                          _bone(width: 96.w, height: 11.h, radius: 6.r),
                          SizedBox(height: 8.h),
                          _bone(width: 120.w, height: 10.h, radius: 6.r),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelSkeleton extends StatelessWidget {
  final Color base;
  final Color highlight;

  const _LabelSkeleton({
    required this.base,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Row(
        children: [
          _bone(width: 72.w, height: 10.h, radius: 4.r),
          SizedBox(width: 8.w),
          Expanded(
            child: Container(height: 1, color: base.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}

class _ProgressCardSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color card;
  final Color border;

  const _ProgressCardSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.card,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border),
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
      child: Shimmer.fromColors(
        baseColor: base,
        highlightColor: highlight,
        child: Row(
          children: [
            _bone(width: 52.r, height: 52.r, radius: 26.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bone(width: 110.w, height: 12.h, radius: 6.r),
                  SizedBox(height: 8.h),
                  _bone(
                    width: double.infinity,
                    height: 8.h,
                    radius: 6.r,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _bone(width: 64.w, height: 18.h, radius: 10.r),
                      SizedBox(width: 8.w),
                      _bone(width: 72.w, height: 18.h, radius: 10.r),
                    ],
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

class _GroupHeaderSkeleton extends StatelessWidget {
  final Color base;
  final Color highlight;

  const _GroupHeaderSkeleton({
    required this.base,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Row(
        children: [
          _bone(width: 8.w, height: 8.w, radius: 4.r),
          SizedBox(width: 8.w),
          _bone(width: 100.w, height: 12.h, radius: 6.r),
          SizedBox(width: 8.w),
          _bone(width: 28.w, height: 18.h, radius: 10.r),
        ],
      ),
    );
  }
}

class _SectionCardSkeleton extends StatelessWidget {
  final bool isDark;
  final Color base;
  final Color highlight;
  final Color card;
  final Color border;
  final double titleWidthFactor;

  const _SectionCardSkeleton({
    required this.isDark,
    required this.base,
    required this.highlight,
    required this.card,
    required this.border,
    required this.titleWidthFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: border),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Shimmer.fromColors(
        baseColor: base,
        highlightColor: highlight,
        child: Row(
          children: [
            _bone(width: 36.r, height: 36.r, radius: 12.r),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    widthFactor: titleWidthFactor,
                    child: _bone(
                      width: double.infinity,
                      height: 12.h,
                      radius: 6.r,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _bone(width: 84.w, height: 10.h, radius: 5.r),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            _bone(width: 18.w, height: 18.w, radius: 9.r),
          ],
        ),
      ),
    );
  }
}

Widget _bone({
  required double width,
  required double height,
  required double radius,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
