import '../../../../exports.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _fade = CurvedAnimation(parent: _intro, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic));
    _intro.forward();
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ResetPasswordCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffold =
            isDark ? AppColors.darkScaffoldBG : AppColors.scaffoldBG;
        final title = isDark ? AppColors.darkTitle : AppColors.title;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;

        return Scaffold(
          backgroundColor: scaffold,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: scaffold,
            foregroundColor: title,
            iconTheme: IconThemeData(color: title),
            title: Text(
              context.tr(AppStrings.resetPassword),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
                color: title,
              ),
            ),
          ),
          body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              state.maybeWhen(
                passwordChagedSuccessfully: () {
                  Navigator.of(context).pop();
                  customSnackBar(
                    message:
                        context.tr(AppStrings.passwordUpdatedSuccessfully),
                    context: context,
                  );
                },
                error: (message) {
                  customSnackBar(message: message, context: context);
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );
              final remainingSeconds = state.maybeWhen(
                countDownInProgress: (seconds) => seconds,
                orElse: () => cubit.countdown,
              );
              final canResend = state.maybeWhen(
                countDownInProgress: (_) => false,
                orElse: () => cubit.isResendBottonShow && !isLoading,
              );
              final keyboardOpen =
                  MediaQuery.viewInsetsOf(context).bottom > 0;
              final step = cubit.currentStep;

              return FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 20.h),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - 8.h,
                          ),
                          child: Column(
                            mainAxisAlignment: keyboardOpen
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _StepProgress(
                                isDark: isDark,
                                primary: primary,
                                currentStep: step,
                              ),
                              SizedBox(height: 14.h),
                              if (!keyboardOpen) ...[
                                _HeroBanner(
                                  isDark: isDark,
                                  primary: primary,
                                  step: step,
                                  email: cubit.email,
                                  isSendingCode: isLoading && step == 0,
                                  onChangeEmail: cubit.backToSetEmail,
                                ),
                                SizedBox(height: 14.h),
                              ] else if (step == 1) ...[
                                _EmailChip(
                                  isDark: isDark,
                                  primary: primary,
                                  email: cubit.email,
                                  onChangeEmail: cubit.backToSetEmail,
                                ),
                                SizedBox(height: 12.h),
                              ],
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 280),
                                switchInCurve: Curves.easeOutCubic,
                                switchOutCurve: Curves.easeInCubic,
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.04, 0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    ),
                                  );
                                },
                                child: KeyedSubtree(
                                  key: ValueKey(step),
                                  child: step == 0
                                      ? const FirstStep()
                                      : step == 1
                                          ? const SecondStep()
                                          : const ThirdStep(),
                                ),
                              ),
                              SizedBox(height: 14.h),
                              SizedBox(
                                height: 40.h,
                                child: isLoading
                                    ? Center(
                                        child: SizedBox(
                                          width: 22.w,
                                          height: 22.w,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.2,
                                            color: primary,
                                          ),
                                        ),
                                      )
                                    : CustomElevatedButton(
                                        onPressed: () {
                                          if (step == 0) {
                                            cubit.sendEmailForResetPassword();
                                          } else if (step == 1) {
                                            cubit.verifyOTP();
                                          } else {
                                            cubit.changePassword(context);
                                          }
                                        },
                                        title: step == 0
                                            ? context
                                                .tr(AppStrings.continueText)
                                            : step == 1
                                                ? context
                                                    .tr(AppStrings.confirm)
                                                : context.tr(AppStrings.save),
                                      ),
                              ),
                              if (step == 1) ...[
                                SizedBox(height: 12.h),
                                _ResendRow(
                                  isDark: isDark,
                                  primary: primary,
                                  canResend: canResend,
                                  isLoading: isLoading,
                                  formattedTime: cubit
                                      .getFormattedTime(remainingSeconds),
                                  onResend: () => cubit.resendOtp(context),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _StepProgress extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final int currentStep;

  const _StepProgress({
    required this.isDark,
    required this.primary,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final labels = [
      context.tr(AppStrings.email),
      context.tr(AppStrings.verify),
      context.tr(AppStrings.password),
    ];
    final muted =
        isDark ? AppColors.darkDescription : Colors.grey.shade500;
    final circleSize = 28.w;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBG : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : Colors.grey.shade200,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / 3;

          return Column(
            children: [
              SizedBox(
                height: circleSize,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: segmentWidth / 2,
                      right: segmentWidth / 2,
                      top: (circleSize - 2) / 2,
                      child: Row(
                        children: List.generate(2, (lineIndex) {
                          final isFilled = currentStep > lineIndex;
                          return Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              height: 2,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                color: isFilled
                                    ? primary
                                    : (isDark
                                        ? AppColors.darkBorder
                                        : Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Row(
                      children: List.generate(3, (index) {
                        final isDone = currentStep > index;
                        final isActive = currentStep == index;
                        final color = isDone || isActive ? primary : muted;

                        return Expanded(
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              width: circleSize,
                              height: circleSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDone
                                    ? primary
                                    : isActive
                                        ? primary.withOpacity(
                                            isDark ? 0.22 : 0.12)
                                        : (isDark
                                            ? Colors.white.withOpacity(0.06)
                                            : Colors.grey.shade100),
                                border: Border.all(
                                  color: isDone || isActive
                                      ? primary
                                      : (isDark
                                          ? AppColors.darkBorder
                                          : Colors.grey.shade300),
                                  width: 1.4,
                                ),
                              ),
                              child: Center(
                                child: isDone
                                    ? Icon(
                                        Icons.check_rounded,
                                        size: 16.sp,
                                        color: Colors.white,
                                      )
                                    : Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w800,
                                          color: color,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: List.generate(3, (index) {
                  final isDone = currentStep > index;
                  final isActive = currentStep == index;
                  final color = isDone || isActive ? primary : muted;

                  return Expanded(
                    child: Text(
                      labels[index],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        fontWeight:
                            isActive ? FontWeight.w800 : FontWeight.w600,
                        color: color,
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final int step;
  final String email;
  final bool isSendingCode;
  final VoidCallback onChangeEmail;

  const _HeroBanner({
    required this.isDark,
    required this.primary,
    required this.step,
    required this.email,
    required this.isSendingCode,
    required this.onChangeEmail,
  });

  @override
  Widget build(BuildContext context) {
    final (title, subtitle, icon, image) = switch (step) {
      1 => (
          context.tr(AppStrings.verifyYourEmail),
          context.tr(AppStrings.weHaveSentTheCodeVerificationTo),
          Icons.mark_email_unread_outlined,
          AppImages.reset2,
        ),
      2 => (
          context.tr(AppStrings.resetPasswordSetNewTitle),
          context.tr(AppStrings.resetPasswordSetNewSubtitle),
          Icons.lock_reset_rounded,
          AppImages.reset1,
        ),
      _ => (
          context.tr(AppStrings.resetPasswordEnterEmailTitle),
          context.tr(AppStrings.resetPasswordEnterEmailSubtitle),
          Icons.mail_outline_rounded,
          AppImages.reset1,
        ),
    };

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.primary.withOpacity(0.32),
                  AppColors.darkCardBG,
                ]
              : [
                  AppColors.primary.withOpacity(0.12),
                  AppColors.subBG,
                ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.22)),
      ),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isDark ? 0.08 : 0.92),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.14),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  icon,
                  color: primary,
                  size: 28.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.darkTitle : Colors.grey.shade900,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.35,
              color: isDark
                  ? AppColors.darkDescription
                  : Colors.grey.shade600,
            ),
          ),
          if (step == 1) ...[
            SizedBox(height: 12.h),
            _EmailChip(
              isDark: isDark,
              primary: primary,
              email: email,
              onChangeEmail: onChangeEmail,
              embedded: true,
            ),
          ],
          if (isSendingCode) ...[
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 12.w,
                  height: 12.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.8,
                    color: primary,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr(AppStrings.sendingVerificationCode),
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkDescription
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _EmailChip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String email;
  final VoidCallback onChangeEmail;
  final bool embedded;

  const _EmailChip({
    required this.isDark,
    required this.primary,
    required this.email,
    required this.onChangeEmail,
    this.embedded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: embedded
            ? (isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.white.withOpacity(0.85))
            : (isDark ? AppColors.darkCardBG : Colors.white),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.mail_outline_rounded, size: 18.sp, color: primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              email,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkTitle : Colors.grey.shade900,
              ),
            ),
          ),
          GestureDetector(
            onTap: onChangeEmail,
            child: Text(
              context.tr(AppStrings.changeYourEmail),
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w700,
                color: primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResendRow extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool canResend;
  final bool isLoading;
  final String formattedTime;
  final VoidCallback onResend;

  const _ResendRow({
    required this.isDark,
    required this.primary,
    required this.canResend,
    required this.isLoading,
    required this.formattedTime,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    final muted =
        isDark ? AppColors.darkDescription : Colors.grey.shade600;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: canResend
          ? TextButton(
              key: const ValueKey('resend'),
              onPressed: isLoading ? null : onResend,
              style: TextButton.styleFrom(
                foregroundColor: primary,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh_rounded, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    context.tr(AppStrings.resend),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              key: const ValueKey('wait'),
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.schedule_rounded, size: 15.sp, color: muted),
                  SizedBox(width: 6.w),
                  Text(
                    context.tr(AppStrings.resendCodeAfter),
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: muted,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
