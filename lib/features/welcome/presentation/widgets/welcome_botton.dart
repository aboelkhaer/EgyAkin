import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class WeclomeBotton extends StatelessWidget {
  final WelcomeCubit cubit;
  final bool isDark;

  const WeclomeBotton({
    super.key,
    required this.cubit,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);

    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => cubit.getStartBotton(context),
          borderRadius: BorderRadius.circular(14.r),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  Color.lerp(primary, const Color(0xFF1F2937), 0.22)!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(isDark ? 0.35 : 0.28),
                  blurRadius: 16,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.getStarted,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
