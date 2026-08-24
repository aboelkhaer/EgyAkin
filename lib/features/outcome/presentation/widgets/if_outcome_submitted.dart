import 'package:egy_akin/app/shared/functions/show_answer_with_select_type.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/convert_list_to_string.dart';

import '../../../../exports.dart';

class IfOutcomeSubmitted extends StatelessWidget {
  const IfOutcomeSubmitted({
    super.key,
    required this.cubit,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });
  final OutcomeCubit cubit;
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;

  Future<void> _openSubmitterProfile(
    BuildContext context,
    OutcomeSubmitterModel submitterModel,
  ) async {
    final attention = context.tr(AppStrings.attention);
    final noPermission = context.tr(
      AppStrings.youDontHavePermissionToViewDoctorProfiles,
    );
    final ok = context.tr(AppStrings.ok);

    final hasPermission = await PermissionHelper.hasPermission(
      AppPermissions.viewDoctorPatients,
    );

    if (!hasPermission &&
        currentDoctorModel.id.toString() != submitterModel.id.toString()) {
      final dialogContext = navigatorKey.currentContext;
      if (dialogContext == null) return;
      showCustomDialog(
        context: dialogContext,
        title: attention,
        description: noPermission,
        coloredButtonText: ok,
        coloredButtonOnTap: () => navigatorKey.currentState?.pop(),
        isNoColorShow: false,
      );
      return;
    }

    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: submitterModel.id.toString(),
        currentDoctorModel: currentDoctorModel,
        accountVerification: accountVerification,
        currentDoctorPoints: currentDoctorPoints,
        isSyndicateCardRequired: isSyndicateCardRequired,
        currentDoctorRole: currentDoctorRole,
        homeDataModel: homeDataModel,
        initialIndex: 0,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  String _answerText(QuestionModel question) {
    if (question.type == AppStrings.questionTypeMultiple) {
      return convertDynamicToString(question);
    }
    if (question.type == AppStrings.questionTypeSelect) {
      return showAnswerWithSelectType(question.answer);
    }
    return question.answer ?? '...';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);
        final cardBg = HomeDashboardColors.cardBg(isDark);

        return BlocConsumer<OutcomeCubit, OutcomeState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (message) {
                customSnackBar(context: context, message: message);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const ShimmerLoadingPatientsCards(ishorizontal: false);
              },
              loaded: (
                response,
                isSubmitedOutcome,
                message,
                _,
                isSubmitedOutcomeLoading,
                submitterModel,
              ) {
                final name = doctorName(
                  firstName: submitterModel.name,
                  lastName: submitterModel.name,
                  role: 'true',
                );
                final imageUrl = submitterModel.image?.toString().trim() ?? '';
                final hasSubmitter = (submitterModel.id?.isNotEmpty ?? false) ||
                    (submitterModel.name?.isNotEmpty ?? false);
                final initial = (submitterModel.name?.isNotEmpty == true)
                    ? submitterModel.name![0].toUpperCase()
                    : 'D';

                return ListView(
                  padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 28.h),
                  children: [
                    if (hasSubmitter) ...[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              _openSubmitterProfile(context, submitterModel),
                          borderRadius: BorderRadius.circular(16.r),
                          child: Ink(
                            decoration: HomeDashboardDecor.card(isDark)
                                .copyWith(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: primary.withOpacity(
                                  isDark ? 0.35 : 0.22,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                12.w,
                                12.h,
                                12.w,
                                12.h,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48.r,
                                    height: 48.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          primary.withOpacity(0.18),
                                          primary.withOpacity(0.05),
                                        ],
                                      ),
                                      border: Border.all(
                                        color: primary.withOpacity(0.25),
                                      ),
                                    ),
                                    child: imageUrl.isEmpty
                                        ? HomeInitialsAvatar(
                                            initials: initial,
                                            radius: 22,
                                          )
                                        : ClipOval(
                                            child: CustomCachedNetworkImage(
                                              imageUrl: imageUrl,
                                              height: 48.r,
                                              width: 48.r,
                                            ),
                                          ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context.tr(AppStrings.submitBy),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: muted,
                                            letterSpacing: 0.1,
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Text(
                                          name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: titleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 32.r,
                                    height: 32.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primary.withOpacity(
                                        isDark ? 0.18 : 0.1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 12.sp,
                                      color: primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                    ],
                    ...List.generate(response.length, (index) {
                      final question = response[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withOpacity(0.06)
                                  : const Color(0xFFE8E8EE),
                            ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1} · ${question.question ?? ''}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: titleColor,
                                  height: 1.35,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.04)
                                      : primary.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  _answerText(question),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: titleColor.withOpacity(0.9),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
