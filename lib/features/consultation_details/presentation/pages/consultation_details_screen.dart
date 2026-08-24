import 'package:egy_akin/features/consultation_details/presentation/cubit/consultation_details_state.dart';
import 'package:egy_akin/features/consultation_details/presentation/widgets/consultation_lock_widget.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/patients/home_patient_widgets.dart';
import 'package:readmore/readmore.dart';

import '../../../../exports.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String patientName;
  final String consultationId;
  final bool isReceivedConsultation;
  final bool isOpen;

  const ConsultationDetailsScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.isReceivedConsultation,
    required this.consultationId,
    required this.patientName,
    required this.isOpen,
  });

  @override
  State<ConsultationDetailsScreen> createState() =>
      _ConsultationDetailsScreenState();
}

class _ConsultationDetailsScreenState extends State<ConsultationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ConsultationDetailsCubit>()
        .getConsultationDetails(widget.consultationId.toString());
  }

  void _toggleConsultationLock() async {
    final cubit = context.read<ConsultationDetailsCubit>();
    final currentState = cubit.state;

    bool currentIsOpen = true;
    if (currentState.maybeWhen(
      loaded: (consultDetails, newCommentValue, isSendingConsultation,
          isSendedConsultation, message, isLocking, isLocked) {
        currentIsOpen = consultDetails.isOpen ?? true;
        return true;
      },
      orElse: () => false,
    )) {
      await cubit.lockOrUnlockConsultation(
        widget.consultationId,
        !currentIsOpen,
      );
    }
  }

  void _onSendReply({
    required ConsultationDetailsCubit cubit,
    required GetConsultationDetailsModelResponse consultDetails,
    required String reply,
  }) {
    if (!widget.homeDataModel.verified!) {
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.emailVerification),
        description: context
            .tr(AppStrings.toAddConsultationYouMustVerifyYourEmailAddress),
        noColoredButtonOnTap: () => Navigator.of(context).pop(),
        coloredButtonText: context.tr(AppStrings.verify),
        noColoredButtonText: context.tr(AppStrings.cancel),
        coloredButtonOnTap: () {
          Navigator.of(context).pop();
          navigatorKey.currentState?.pushNamed(
            AppRoutes.emailVerification,
            arguments: AppRoutesArgs.emailVerificationRouteArgs(
              currentDoctorModel: widget.currentDoctorModel,
            ),
          );
        },
      );
    }

    if (widget.homeDataModel.verified! &&
        widget.homeDataModel.isSyndicateCardRequired != 'Required' &&
        widget.homeDataModel.isSyndicateCardRequired != 'Pending') {
      cubit.addConsultationReply(
        consultationId: consultDetails.id.toString(),
        reply: reply,
      );
    } else {
      if (widget.homeDataModel.isSyndicateCardRequired != 'Required' &&
          widget.homeDataModel.isSyndicateCardRequired != 'Pending') {
        showCustomDialog(
          context: context,
          title: context.tr(AppStrings.emailVerification),
          description: context
              .tr(AppStrings.toAddConsultationYouMustVerifyYourSyndicateCard),
          noColoredButtonOnTap: () => Navigator.of(context).pop(),
          coloredButtonText: context.tr(AppStrings.verify),
          noColoredButtonText: context.tr(AppStrings.cancel),
          coloredButtonOnTap: () {
            Navigator.of(context).pop();
            navigatorKey.currentState?.pushNamed(
              AppRoutes.emailVerification,
              arguments: AppRoutesArgs.emailVerificationRouteArgs(
                currentDoctorModel: widget.currentDoctorModel,
              ),
            );
          },
        );
      }
    }

    if (widget.homeDataModel.verified! &&
        (widget.homeDataModel.isSyndicateCardRequired == 'Required' ||
            widget.homeDataModel.isSyndicateCardRequired == 'Pending')) {
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.syndicateCardVerification),
        description: context
            .tr(AppStrings.toAddConsultationYouMustVerifyYourSyndicateCard),
        noColoredButtonOnTap: () => Navigator.of(context).pop(),
        coloredButtonText: context.tr(AppStrings.ok),
        noColoredButtonText: '',
        isNoColorShow: true,
        coloredButtonOnTap: () => Navigator.of(context).pop(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ConsultationDetailsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent)
              : SystemUiOverlayStyle.dark
                  .copyWith(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: scaffold,
            body:
                BlocConsumer<ConsultationDetailsCubit, ConsultationDetailsState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (message) {
                    customSnackBar(
                      context: context,
                      message: context.tr(message),
                    );
                  },
                  loaded: (
                    consultDetails,
                    newCommentValue,
                    isSendingConsultation,
                    isSendedConsultation,
                    message,
                    isLocking,
                    isLocked,
                  ) {
                    if (message != '') {
                      customSnackBar(
                        context: context,
                        message: context.tr(message),
                      );
                    }
                    if (isSendedConsultation) {
                      cubit.getConsultationDetails(
                        widget.consultationId.toString(),
                      );
                    }
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => _LoadingView(isDark: isDark, primary: primary),
                  loaded: (
                    consultDetails,
                    newConsultationValue,
                    isSendingConsultation,
                    isSendedConsultation,
                    message,
                    isLocking,
                    isLocked,
                  ) {
                    final isOpen = consultDetails.isOpen ?? true;
                    final replies = (consultDetails.consultationDoctors ?? [])
                        .where((d) =>
                            d.reply != null &&
                            d.reply != 'No reply available remove this')
                        .toList();
                    final canManageLock = !(widget.isReceivedConsultation &&
                        consultDetails.doctorId.toString() !=
                            widget.currentDoctorModel.id.toString());

                    return Column(
                      children: [
                        _Header(
                          isDark: isDark,
                          scaffold: scaffold,
                          primary: primary,
                          titleColor: titleColor,
                          muted: muted,
                          patientName: widget.patientName,
                          isOpen: isOpen,
                          showDoctorsAction: !isLocked,
                          onBack: () => Navigator.of(context).maybePop(),
                          onDoctorsTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.sendConsultation,
                              arguments:
                                  AppRoutesArgs.sendConsultationRouteArgs(
                                homeDataModel: widget.homeDataModel,
                                currentDoctorModel: widget.currentDoctorModel,
                                patientId: consultDetails.patientModel!.id
                                    .toString(),
                                isSendConsultation: true,
                                groupId: '',
                                isForAddNewDoctors: true,
                                consultationId: widget.consultationId,
                                ownerOfConsultationId:
                                    consultDetails.doctorId.toString(),
                              ),
                            );
                          },
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              ListView(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(
                                  14.w,
                                  8.h,
                                  14.w,
                                  isOpen ? 100.h : 24.h,
                                ),
                                children: [
                                  if (canManageLock)
                                    ConsultationLockWidget(
                                      isLocked: !isOpen,
                                      isLoading: isLocking,
                                      onToggle: _toggleConsultationLock,
                                    ),
                                  if (canManageLock) SizedBox(height: 12.h),
                                  _SectionLabel(
                                    isDark: isDark,
                                    title: context
                                        .tr(AppStrings.message)
                                        .toUpperCase(),
                                  ),
                                  SizedBox(height: 8.h),
                                  _MessageCard(
                                    isDark: isDark,
                                    primary: primary,
                                    message:
                                        consultDetails.consultMessage ?? '',
                                  ),
                                  SizedBox(height: 16.h),
                                  _SectionLabel(
                                    isDark: isDark,
                                    title: context
                                        .tr(AppStrings.patient)
                                        .toUpperCase(),
                                  ),
                                  SizedBox(height: 8.h),
                                  if (consultDetails.patientModel != null)
                                    HomePatientCard(
                                      isDark: isDark,
                                      patient: consultDetails.patientModel!,
                                      onAddCommentTap: () {
                                        final patient =
                                            consultDetails.patientModel!;
                                        navigatorKey.currentState?.pushNamed(
                                          AppRoutes.comments,
                                          arguments: AppRoutesArgs
                                              .patientCommentsRouteArgs(
                                            patientId: patient.id.toString(),
                                            currentDoctorModel:
                                                widget.currentDoctorModel,
                                            verified:
                                                widget.homeDataModel.verified!,
                                            patientName:
                                                patient.name.toString(),
                                            currentDoctorPoints: int.parse(widget
                                                .homeDataModel.scoreValue!),
                                            currentDoctorRole: widget
                                                .homeDataModel.role
                                                .toString(),
                                            homeDataModel: widget.homeDataModel,
                                            isSyndicateCardRequired: widget
                                                .homeDataModel
                                                .isSyndicateCardRequired!,
                                          ),
                                        );
                                      },
                                      onOutcomeTap: () {
                                        final patient =
                                            consultDetails.patientModel!;
                                        navigatorKey.currentState?.pushNamed(
                                          AppRoutes.outcome,
                                          arguments:
                                              AppRoutesArgs.outcomeRouteArgs(
                                            verified:
                                                widget.homeDataModel.verified!,
                                            outcomeStatus: patient
                                                    .sections?.outcomeStatus ??
                                                false,
                                            patientName:
                                                patient.name.toString(),
                                            patientId: patient.id.toString(),
                                            currentDoctorModel:
                                                widget.currentDoctorModel,
                                            doctorId: patient.doctor?.id
                                                    .toString() ??
                                                '',
                                            isSyndicateCardRequired: widget
                                                .homeDataModel
                                                .isSyndicateCardRequired!,
                                            currentDoctorRole: widget
                                                .homeDataModel.role
                                                .toString(),
                                            currentDoctorPoints: int.parse(widget
                                                .homeDataModel.scoreValue!),
                                            homeDataModel: widget.homeDataModel,
                                          ),
                                        );
                                      },
                                      onTap: () {
                                        final patient =
                                            consultDetails.patientModel!;
                                        navigatorKey.currentState?.pushNamed(
                                          AppRoutes.patientSections,
                                          arguments: AppRoutesArgs
                                              .patientSectionsRouteArguments(
                                            patientId: patient.id.toString(),
                                            currentDoctorRole: widget
                                                .homeDataModel.role
                                                .toString(),
                                            currentDoctorPoints: int.parse(widget
                                                .homeDataModel.scoreValue!),
                                            currentDoctorModel:
                                                widget.currentDoctorModel,
                                            homeDataModel: widget.homeDataModel,
                                            isAllDataOpen: true,
                                          ),
                                        );
                                      },
                                    ),
                                  SizedBox(height: 18.h),
                                  _SectionLabel(
                                    isDark: isDark,
                                    title: context
                                        .tr(AppStrings.consultations)
                                        .toUpperCase(),
                                    trailing: replies.isEmpty
                                        ? null
                                        : _CountPill(
                                            isDark: isDark,
                                            primary: primary,
                                            count: replies.length,
                                          ),
                                  ),
                                  SizedBox(height: 8.h),
                                  if (replies.isEmpty)
                                    _EmptyReplies(isDark: isDark, muted: muted)
                                  else
                                    ...replies.map(
                                      (doctorConsultation) => Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: _ReplyCard(
                                          isDark: isDark,
                                          primary: primary,
                                          titleColor: titleColor,
                                          muted: muted,
                                          reply: doctorConsultation,
                                          isCurrentDoctor: doctorConsultation
                                                  .doctorId
                                                  .toString() ==
                                              widget.currentDoctorModel.id
                                                  .toString(),
                                          onDoctorTap: () {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.doctorInfoView,
                                              arguments: AppRoutesArgs
                                                  .doctorInfoViewRouteArgs(
                                                doctorId: doctorConsultation
                                                    .doctorId
                                                    .toString(),
                                                currentDoctorModel:
                                                    widget.currentDoctorModel,
                                                isSyndicateCardRequired: widget
                                                    .homeDataModel
                                                    .isSyndicateCardRequired
                                                    .toString(),
                                                accountVerification: widget
                                                    .homeDataModel.verified!,
                                                currentDoctorRole: widget
                                                    .homeDataModel.role
                                                    .toString(),
                                                currentDoctorPoints: int.parse(
                                                  widget.homeDataModel.scoreValue
                                                      .toString(),
                                                ),
                                                homeDataModel:
                                                    widget.homeDataModel,
                                                initialIndex: 0,
                                                isNavigateToTheButtonOfInformationTab:
                                                    false,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              if (isOpen)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: _ReplyComposer(
                                    isDark: isDark,
                                    primary: primary,
                                    isSending: isSendingConsultation,
                                    showSend: newConsultationValue.trim() !=
                                        AppStrings.empty,
                                    onChanged: (val) {
                                      cubit.newConsultation = val;
                                      cubit.newConsultationValueChanged(val);
                                    },
                                    onSend: () => _onSendReply(
                                      cubit: cubit,
                                      consultDetails: consultDetails,
                                      reply: newConsultationValue,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final bool isDark;
  final Color scaffold;
  final Color primary;
  final Color titleColor;
  final Color muted;
  final String patientName;
  final bool isOpen;
  final bool showDoctorsAction;
  final VoidCallback onBack;
  final VoidCallback onDoctorsTap;

  const _Header({
    required this.isDark,
    required this.scaffold,
    required this.primary,
    required this.titleColor,
    required this.muted,
    required this.patientName,
    required this.isOpen,
    required this.showDoctorsAction,
    required this.onBack,
    required this.onDoctorsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _RoundIconButton(
                    isDark: isDark,
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: onBack,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      patientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  if (showDoctorsAction) ...[
                    SizedBox(width: 8.w),
                    _HeaderActionButton(
                      isDark: isDark,
                      primary: primary,
                      icon: Icons.group_outlined,
                      label: context.tr(AppStrings.doctors),
                      onTap: onDoctorsTap,
                    ),
                  ],
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: isOpen
                          ? HomeDashboardColors.success
                              .withOpacity(isDark ? 0.18 : 0.12)
                          : HomeDashboardColors.danger
                              .withOpacity(isDark ? 0.18 : 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isOpen ? Icons.lock_open_rounded : Icons.lock_rounded,
                          size: 12.sp,
                          color: isOpen
                              ? HomeDashboardColors.success
                              : HomeDashboardColors.danger,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          isOpen
                              ? context.tr(AppStrings.opened)
                              : context.tr(AppStrings.locked),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: isOpen
                                ? HomeDashboardColors.success
                                : HomeDashboardColors.danger,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      context.tr(AppStrings.consultationDetails),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: muted,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconButton({
    required this.isDark,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? const Color(0xFF2A2733) : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? const Color(0xFF3A3645) : const Color(0xFFE6E2F0),
            ),
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: HomeDashboardColors.title(isDark),
            textDirection: Directionality.of(context),
          ),
        ),
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HeaderActionButton({
    required this.isDark,
    required this.primary,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.75),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          child: Row(
            children: [
              Icon(icon, size: 14.sp, color: primary),
              SizedBox(width: 4.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final bool isDark;
  final String title;
  final Widget? trailing;

  const _SectionLabel({
    required this.isDark,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final color = HomeDashboardColors.subtitle(isDark);
    final line = HomeDashboardColors.border(isDark);

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
            color: color,
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: 8.w),
          trailing!,
        ],
        SizedBox(width: 10.w),
        Expanded(child: Container(height: 1, color: line)),
      ],
    );
  }
}

class _CountPill extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final int count;

  const _CountPill({
    required this.isDark,
    required this.primary,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: primary.withOpacity(isDark ? 0.2 : 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$count',
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w700,
          color: primary,
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String message;

  const _MessageCard({
    required this.isDark,
    required this.primary,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: HomeDashboardDecor.card(isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: primary.withOpacity(isDark ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 14.sp,
                  color: primary,
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  context.tr(AppStrings.consultationRequest),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: HomeDashboardColors.title(isDark),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ReadMoreText(
            message,
            trimMode: TrimMode.Line,
            trimLines: 3,
            colorClickableText: primary,
            trimCollapsedText: ' ${context.tr(AppStrings.seeMore)} ',
            trimExpandedText: ' ${context.tr(AppStrings.seeLess)} ',
            moreStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: primary,
              fontSize: 11.sp,
            ),
            lessStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: primary,
              fontSize: 11.sp,
            ),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              height: 1.45,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReplyCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color muted;
  final DoctorsConsultationDetailsModelResponse reply;
  final bool isCurrentDoctor;
  final VoidCallback onDoctorTap;

  const _ReplyCard({
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.muted,
    required this.reply,
    required this.isCurrentDoctor,
    required this.onDoctorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: HomeDashboardDecor.card(isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onDoctorTap,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary.withOpacity(isDark ? 0.2 : 0.12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: reply.doctorId == null
                      ? Center(
                          child: Text(
                            (reply.doctorFirstName ?? 'D')[0].toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13.sp,
                              color: primary,
                            ),
                          ),
                        )
                      : CustomCachedNetworkImage(
                          imageUrl: reply.doctorImage.toString(),
                          height: 36.w,
                          width: 36.w,
                        ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            doctorName(
                              firstName: reply.doctorFirstName ?? '',
                              lastName: reply.doctorLastName ?? '',
                              role: reply.isVerified.toString(),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: isCurrentDoctor
                                  ? HomeDashboardColors.success
                                  : titleColor,
                            ),
                          ),
                        ),
                        if (reply.isVerified == true) ...[
                          SizedBox(width: 4.w),
                          const VerificationIcon(),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      TimeAgoService.instance.formatTimeAgoFromString(
                        reply.updatedAt.toString(),
                        context,
                      ),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            reply.reply.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              height: 1.45,
              color: HomeDashboardColors.title(isDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyReplies extends StatelessWidget {
  final bool isDark;
  final Color muted;

  const _EmptyReplies({required this.isDark, required this.muted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
      decoration: HomeDashboardDecor.card(isDark),
      child: Column(
        children: [
          Icon(Icons.forum_outlined, size: 28.sp, color: muted),
          SizedBox(height: 8.h),
          Text(
            context.tr(AppStrings.noRepliesYet),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: HomeDashboardColors.title(isDark),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            context.tr(AppStrings.beTheFirstToAddConsultationReply),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReplyComposer extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool isSending;
  final bool showSend;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  const _ReplyComposer({
    required this.isDark,
    required this.primary,
    required this.isSending,
    required this.showSend,
    required this.onChanged,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final barBg = isDark ? HomeDashboardColors.cardBg(isDark) : Colors.white;
    final topBorder = HomeDashboardColors.border(isDark);

    return Container(
      decoration: BoxDecoration(
        color: barBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        border: Border(top: BorderSide(color: topBorder, width: 0.8)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: 8.h),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 2.h),
          child: Row(
            children: [
              if (isSending)
                SizedBox(
                  width: 28.w,
                  height: 28.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: primary,
                  ),
                )
              else
                Expanded(
                  child: CustomTextFormField(
                    title: context.tr(AppStrings.writeConsultation),
                    textInputType: TextInputType.text,
                    enableSuggestions: true,
                    onChanged: onChanged,
                    onFieldSubmitted: (_) {},
                    textInputAction: TextInputAction.done,
                    validator: (_) => null,
                  ),
                ),
              if (!isSending && showSend) ...[
                SizedBox(width: 8.w),
                Material(
                  color: primary,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    onTap: onSend,
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      width: 42.w,
                      height: 42.w,
                      child: Icon(
                        Icons.send_rounded,
                        size: 18.sp,
                        color: Colors.white,
                        textDirection: Directionality.of(context),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  final bool isDark;
  final Color primary;

  const _LoadingView({required this.isDark, required this.primary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 28.w,
            height: 28.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: primary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            context.tr(AppStrings.loadingConsultation),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
        ],
      ),
    );
  }
}
