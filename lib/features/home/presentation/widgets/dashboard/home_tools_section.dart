import 'package:egy_akin/features/home/data/models/home_dashboard_fake_data.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../../exports.dart';

class HomeToolsSection extends StatelessWidget {
  final bool isDark;
  final List<HomeToolFake> tools;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const HomeToolsSection({
    super.key,
    required this.isDark,
    required this.tools,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  IconData _iconFor(String name) {
    switch (name) {
      case 'calculate':
        return Icons.calculate_outlined;
      case 'stethoscope':
        return Icons.monitor_heart_outlined;
      case 'analytics':
        return Icons.bar_chart_rounded;
      case 'bookmark':
        return Icons.bookmark_border_rounded;
      default:
        return Icons.widgets_outlined;
    }
  }

  String _labelFor(BuildContext context, HomeToolFake tool) {
    switch (tool.iconName) {
      case 'calculate':
        return context.tr(AppStrings.gfrCalc);
      case 'stethoscope':
        return context.tr(AppStrings.consults);
      case 'analytics':
        return context.tr(AppStrings.analytics);
      case 'bookmark':
        return context.tr(AppStrings.marked);
      default:
        return tool.label;
    }
  }

  void _onToolTap(BuildContext context, HomeToolFake tool) {
    switch (tool.iconName) {
      case 'calculate':
        navigatorKey.currentState?.pushNamed(
          AppRoutes.gfrCalculator,
          arguments: AppRoutesArgs.gfrCalculatorRouteArgs(
            homeDataModel: homeDataModel,
          ),
        );
        break;
      case 'stethoscope':
        navigatorKey.currentState?.pushNamed(
          AppRoutes.consultation,
          arguments: AppRoutesArgs.consultationRouteArgs(
            homeDataModel: homeDataModel,
            currentDoctorModel: currentDoctorModel,
            initialTab: 0,
          ),
        );
        break;
      case 'analytics':
        navigatorKey.currentState?.pushNamed(
          AppRoutes.webview,
          arguments: AppRoutesArgs.webViewRouteArgs(
            url:
                '${ApiEndPoint.baseUrl}/analytics?user_id=${currentDoctorModel.id}&dark=${isDark ? 'true' : 'false'}',
            title: context.tr(AppStrings.analytics),
          ),
        );
        break;
      case 'bookmark':
        navigatorKey.currentState?.pushNamed(
          AppRoutes.profilePatients,
          arguments: AppRoutesArgs.profilePatientsRouteArgs(
            doctorId: currentDoctorModel.id.toString(),
            currentDoctorModel: currentDoctorModel,
            accountVerification: homeDataModel.verified ?? false,
            isSyndicateCardRequired:
                homeDataModel.isSyndicateCardRequired.toString(),
            doctorFirstName: currentDoctorModel.firstName.toString(),
            currentDoctorRole: homeDataModel.role.toString(),
            currentDoctorPoints:
                int.tryParse(homeDataModel.scoreValue ?? '') ?? 0,
            homeDataModel: homeDataModel,
            initialShowMarked: true,
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final iconBg = isDark
        ? const Color(0xFF29253A)
        : HomeDashboardColors.primary(isDark).withOpacity(0.1);
    final iconColor =
        isDark ? const Color(0xFFA29BFE) : HomeDashboardColors.primary(isDark);
    final labelColor =
        isDark ? const Color(0xFFE0E0E0) : HomeDashboardColors.title(isDark);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(AppStrings.tools),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            for (var i = 0; i < tools.length; i++) ...[
              if (i > 0) SizedBox(width: 10.w),
              Expanded(
                child: Material(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(18.r),
                  child: InkWell(
                    onTap: () => _onToolTap(context, tools[i]),
                    borderRadius: BorderRadius.circular(18.r),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8.w, 14.h, 8.w, 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.r),
                        boxShadow: isDark
                            ? null
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 42.r,
                            height: 42.r,
                            decoration: BoxDecoration(
                              color: iconBg,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Icon(
                              _iconFor(tools[i].iconName),
                              size: 22.sp,
                              color: iconColor,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            _labelFor(context, tools[i]),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: labelColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
