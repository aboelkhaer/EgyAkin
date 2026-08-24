import '../../../../../exports.dart';
import 'home_dashboard_shared.dart';

class HomeSearchField extends StatelessWidget {
  final bool isDark;
  final VoidCallback? onTap;

  const HomeSearchField({
    super.key,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: isDark ? HomeDashboardColors.surfaceBg(isDark) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: HomeDashboardColors.border(isDark)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 18.sp,
              color: HomeDashboardColors.subtitle(isDark),
            ),
            SizedBox(width: 8.w),
            Text(
              context.tr(AppStrings.searchPatientsAndDoses),
              style: TextStyle(
                fontSize: 12.sp,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
