import '../../../../exports.dart';

class EmailVerifciationScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  const EmailVerifciationScreen({super.key, required this.currentDoctorModel});

  @override
  State<EmailVerifciationScreen> createState() =>
      _EmailVerifciationScreenState();
}

class _EmailVerifciationScreenState extends State<EmailVerifciationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    context.read<EmailVerificationCubit>().initializeLifecycleObserver();
    context.read<EmailVerificationCubit>().sendEmailForVerification();

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

  void _updatePin(EmailVerificationCubit cubit, int index, String value) {
    switch (index) {
      case 1:
        cubit.pin1 = value;
        break;
      case 2:
        cubit.pin2 = value;
        break;
      case 3:
        cubit.pin3 = value;
        break;
      case 4:
        cubit.pin4 = value;
        break;
    }
    cubit.isOTPDone = [
      cubit.pin1,
      cubit.pin2,
      cubit.pin3,
      cubit.pin4,
    ].every((pin) => pin != null && pin.isNotEmpty);
  }

  void _changeEmail() {
    Future.delayed(Duration.zero, () {
      navigatorKey.currentState?.pushReplacementNamed(
        AppRoutes.home,
        arguments: 4,
      );
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.doctorProfile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = EmailVerificationCubit.get(context);

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
              context.tr(AppStrings.emailVerification),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
                color: title,
              ),
            ),
          ),
          body: BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                emailVerificationSuccess: () {
                  customSnackBar(
                    message:
                        context.tr(AppStrings.emailVerifiedSuccessfully),
                    context: context,
                  );
                },
                emailVerificationComplete: () {
                  navigatorKey.currentState
                      ?.pushReplacementNamed(AppRoutes.home, arguments: 0);
                  customSnackBar(
                    message:
                        context.tr(AppStrings.emailVerifiedSuccessfully),
                    context: context,
                  );
                },
                error: (message) {
                  customSnackBar(message: message, context: context);
                },
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
                orElse: () => !isLoading && !cubit.isConfirmingOtp,
              );
              final isSubmittingOtp = cubit.isConfirmingOtp ||
                  (isLoading && cubit.isOTPDone);
              final isSendingCode =
                  isLoading && !cubit.isConfirmingOtp && !cubit.isOTPDone;
              final keyboardOpen =
                  MediaQuery.viewInsetsOf(context).bottom > 0;
              final email = widget.currentDoctorModel.email ?? '';

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
                              if (!keyboardOpen) ...[
                                _HeroBanner(
                                  isDark: isDark,
                                  primary: primary,
                                  email: email,
                                  isSendingCode: isSendingCode,
                                  onChangeEmail: _changeEmail,
                                ),
                                SizedBox(height: 14.h),
                              ] else ...[
                                _EmailChip(
                                  isDark: isDark,
                                  primary: primary,
                                  email: email,
                                  onChangeEmail: _changeEmail,
                                ),
                                SizedBox(height: 12.h),
                              ],
                              _CodeCard(
                                isDark: isDark,
                                primary: primary,
                                cubit: cubit,
                                onPinChanged: (i, v) =>
                                    _updatePin(cubit, i, v),
                              ),
                              SizedBox(height: 14.h),
                              SizedBox(
                                height: 40.h,
                                child: ElevatedButton(
                                  onPressed: isSubmittingOtp
                                      ? null
                                      : () => cubit
                                          .sendOTPForEmailVerification(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isDark
                                        ? AppColors.darkPrimary
                                            .withOpacity(0.7)
                                        : AppColors.primary.withOpacity(0.7),
                                    disabledBackgroundColor: isDark
                                        ? AppColors.darkPrimary
                                            .withOpacity(0.45)
                                        : AppColors.primary.withOpacity(0.45),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: isSubmittingOtp
                                      ? SizedBox(
                                          width: 20.w,
                                          height: 20.w,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 2.2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          context.tr(AppStrings.confirm),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              _ResendRow(
                                isDark: isDark,
                                primary: primary,
                                canResend: canResend,
                                isLoading: isLoading || cubit.isConfirmingOtp,
                                formattedTime: cubit
                                    .getFormattedTime(remainingSeconds),
                                onResend: () => cubit.resendOtp(),
                              ),
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

class _HeroBanner extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String email;
  final bool isSendingCode;
  final VoidCallback onChangeEmail;

  const _HeroBanner({
    required this.isDark,
    required this.primary,
    required this.email,
    required this.isSendingCode,
    required this.onChangeEmail,
  });

  @override
  Widget build(BuildContext context) {
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
                AppImages.emailVerification,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.mark_email_unread_outlined,
                  color: primary,
                  size: 28.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            context.tr(AppStrings.verifyYourEmail),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.darkTitle : Colors.grey.shade900,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            context.tr(AppStrings.weHaveSentTheCodeVerificationTo),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.35,
              color: isDark
                  ? AppColors.darkDescription
                  : Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 12.h),
          _EmailChip(
            isDark: isDark,
            primary: primary,
            email: email,
            onChangeEmail: onChangeEmail,
            embedded: true,
          ),
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

class _CodeCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final EmailVerificationCubit cubit;
  final void Function(int index, String value) onPinChanged;

  const _CodeCard({
    required this.isDark,
    required this.primary,
    required this.cubit,
    required this.onPinChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBG : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : Colors.grey.shade200,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(9.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.pin_outlined,
                  color: primary,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(AppStrings.verificationCode),
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTitle
                            : Colors.grey.shade900,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      context.tr(AppStrings.enterThe4DigitCode),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isDark
                            ? AppColors.darkDescription
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          OTPRow(
            formKey: cubit.emailVerificationOTPFormKey,
            firstOTPFocusNode: cubit.firstOTPFocusNode,
            firstOTPOnChanged: (value) => onPinChanged(1, value),
            secondOTPOnChanged: (value) => onPinChanged(2, value),
            thirdOTPOnChanged: (value) => onPinChanged(3, value),
            fourthOTPOnChanged: (value) => onPinChanged(4, value),
            firstOTPValidator: (value) =>
                AppValidators.fieldsIsEmptyValidation(value!),
            secondOTPValidator: (value) =>
                AppValidators.fieldsIsEmptyValidation(value!),
            thirdOTPValidator: (value) =>
                AppValidators.fieldsIsEmptyValidation(value!),
            fourthOTPValidator: (value) =>
                AppValidators.fieldsIsEmptyValidation(value!),
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
