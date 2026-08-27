import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/outcome/presentation/widgets/if_outcome_not_submitted.dart';
import 'package:egy_akin/features/outcome/presentation/widgets/if_outcome_submitted.dart';
import 'package:egy_akin/features/record/presentation/cubit/record_cubit.dart';
import 'package:egy_akin/features/record/presentation/pages/record_screen.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'dart:ui' as ui;

import '../../../../exports.dart';

class OutcomeScreen extends StatefulWidget {
  final bool accountVerification;
  final bool outcomeStatus;
  final String patientName;
  final String patientId;
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;

  const OutcomeScreen({
    super.key,
    required this.outcomeStatus,
    required this.patientName,
    required this.patientId,
    required this.accountVerification,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<OutcomeScreen> createState() => _OutcomeScreenState();
}

class _OutcomeScreenState extends State<OutcomeScreen> {
  @override
  void initState() {
    context.read<OutcomeCubit>().getOutcome(widget.patientId);
    super.initState();
  }

  String get _displayPatientName {
    final canViewName =
        widget.currentDoctorModel.id.toString() == widget.doctorId.toString() ||
            PermissionHelper.canPermission(AppPermissions.viewPatientsName);
    return canViewName
        ? widget.patientName.toString()
        : convertTextToSymbols(widget.patientName);
  }

  Future<void> _openVoice(OutcomeCubit outcomeCubit) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<RecordCubit>(),
          child: RecordScreen(
            questions: outcomeCubit.questionModelList,
            source: 'outcome',
            sectionId: '8',
            aiMode: 'voice',
            aiHintHtml: outcomeCubit.outcomeAiHint,
            aiVoiceTime: outcomeCubit.outcomeAiVoiceTime,
          ),
        ),
      ),
    );

    if (result is Map<String, dynamic>) {
      outcomeCubit.applyVoiceAnswers(result);
    }
  }

  void _openPatientSections() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.patientSections,
      arguments: AppRoutesArgs.patientSectionsRouteArguments(
        patientId: widget.patientId,
        currentDoctorModel: widget.currentDoctorModel,
        currentDoctorPoints: widget.currentDoctorPoints,
        currentDoctorRole: widget.currentDoctorRole,
        homeDataModel: widget.homeDataModel,
        isAllDataOpen: widget.currentDoctorModel.id.toString() !=
            widget.doctorId.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final OutcomeCubit cubit = OutcomeCubit.get(context);
        final displayName = _displayPatientName;
        final isArabicName =
            RegExp(r'[\u0600-\u06FF]').hasMatch(widget.patientName);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                )
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
          child: Scaffold(
            backgroundColor: scaffold,
            body: Column(
              children: [
                AnimatedContainer(
                  duration: Duration.zero,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        HomeDashboardColors.header(isDark),
                        scaffold,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _OutcomeRoundIconButton(
                            isDark: isDark,
                            icon: Icons.arrow_back_ios_new_rounded,
                            onTap: () => Navigator.of(context).maybePop(),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr(AppStrings.outcome),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800,
                                    color: titleColor,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: _openPatientSections,
                                    borderRadius: BorderRadius.circular(99),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(99),
                                        color: isDark
                                            ? Colors.white.withOpacity(0.12)
                                            : Colors.white.withOpacity(0.75),
                                        border: Border.all(
                                          color: isDark
                                              ? Colors.white.withOpacity(0.14)
                                              : primary.withOpacity(0.18),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          8.w,
                                          4.h,
                                          6.w,
                                          4.h,
                                        ),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 18.r,
                                                height: 18.r,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: isDark
                                                      ? primary.withOpacity(0.35)
                                                      : primary.withOpacity(0.12),
                                                ),
                                                child: Icon(
                                                  Icons.person_rounded,
                                                  size: 12.sp,
                                                  color: isDark
                                                      ? Colors.white
                                                      : primary,
                                                ),
                                              ),
                                              SizedBox(width: 6.w),
                                              Flexible(
                                                child: Tooltip(
                                                  message: widget.patientName,
                                                  child: Text(
                                                    displayName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textDirection: isArabicName
                                                        ? ui.TextDirection.rtl
                                                        : ui.TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 11.5.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: isDark
                                                          ? Colors.white
                                                              .withOpacity(0.92)
                                                          : titleColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              Icon(
                                                Icons.chevron_right_rounded,
                                                size: 16.sp,
                                                color: isDark
                                                    ? Colors.white
                                                        .withOpacity(0.7)
                                                    : primary.withOpacity(0.8),
                                                textDirection:
                                                    Directionality.of(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<OutcomeCubit, OutcomeState>(
                            builder: (context, _) {
                              final outcomeCubit = OutcomeCubit.get(context);
                              final showMic = !widget.outcomeStatus &&
                                  outcomeCubit.outcomeAiMode == 'voice';
                              if (!showMic) return const SizedBox.shrink();
                              return Padding(
                                padding: EdgeInsetsDirectional.only(start: 8.w),
                                child: _OutcomeAiActionButton(
                                  primary: primary,
                                  icon: Icons.mic_rounded,
                                  onTap: () => _openVoice(outcomeCubit),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: widget.outcomeStatus
                      ? IfOutcomeSubmitted(
                          cubit: cubit,
                          currentDoctorModel: widget.currentDoctorModel,
                          doctorId: widget.doctorId,
                          accountVerification: widget.accountVerification,
                          isSyndicateCardRequired:
                              widget.isSyndicateCardRequired,
                          currentDoctorRole: widget.currentDoctorRole,
                          currentDoctorPoints: widget.currentDoctorPoints,
                          homeDataModel: widget.homeDataModel,
                        )
                      : IfOutcomeNotSubmitted(
                          cubit: cubit,
                          outcomeStatus: widget.outcomeStatus,
                          accountVerification: widget.accountVerification,
                          patientId: widget.patientId,
                          isSyndicateCardRequired:
                              widget.isSyndicateCardRequired,
                          currentDoctorModel: widget.currentDoctorModel,
                          doctorId: widget.doctorId,
                          homeDataModel: widget.homeDataModel,
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

class _OutcomeRoundIconButton extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final VoidCallback onTap;

  const _OutcomeRoundIconButton({
    required this.isDark,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.r,
        height: 38.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? const Color(0xFF2A2A2E) : Colors.white,
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : const Color(0xFFE8E8EE),
          ),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Icon(
          icon,
          size: 15.sp,
          color: HomeDashboardColors.title(isDark),
          textDirection: Directionality.of(context),
        ),
      ),
    );
  }
}

class _OutcomeAiActionButton extends StatelessWidget {
  final Color primary;
  final IconData icon;
  final VoidCallback onTap;

  const _OutcomeAiActionButton({
    required this.primary,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  Color.lerp(primary, const Color(0xFFB794F6), 0.35)!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
          Positioned(
            top: -2.h,
            right: -2.w,
            child: Container(
              width: 13.r,
              height: 13.r,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: primary, width: 1),
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 7.sp,
                color: primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
