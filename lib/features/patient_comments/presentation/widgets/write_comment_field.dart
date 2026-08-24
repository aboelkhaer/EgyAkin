import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class WriteCommentField extends StatefulWidget {
  const WriteCommentField({
    super.key,
    required this.cubit,
    required this.accountVerification,
    required this.currentDoctorModel,
    required this.patientId,
    required this.isSyndicateCardRequired,
  });

  final PatientCommentsCubit cubit;
  final bool accountVerification;
  final DoctorModel currentDoctorModel;
  final String patientId;
  final String isSyndicateCardRequired;

  @override
  State<WriteCommentField> createState() => _WriteCommentFieldState();
}

class _WriteCommentFieldState extends State<WriteCommentField> {
  late final TextEditingController _controller;
  late TextDirection _textDirection;

  static final _arabicChar = RegExp(r'[\u0600-\u06FF]');
  static final _latinChar = RegExp(r'[A-Za-z]');

  TextDirection _appTextDirection() =>
      context.isRTL ? TextDirection.rtl : TextDirection.ltr;

  TextDirection _directionFor(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return _appTextDirection();
    for (final match in RegExp(r'[A-Za-z\u0600-\u06FF]').allMatches(trimmed)) {
      final ch = match.group(0)!;
      if (_arabicChar.hasMatch(ch)) return TextDirection.rtl;
      if (_latinChar.hasMatch(ch)) return TextDirection.ltr;
    }
    return _appTextDirection();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.cubit.newComment);
    _textDirection = _controller.text.trim().isNotEmpty
        ? _directionFor(_controller.text)
        : _appTextDirection();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showEmailVerificationDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: context.tr(AppStrings.emailVerification),
      description:
          context.tr(AppStrings.toAddCommentYouMustVerifyYourEmailAddress),
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

  void _showSyndicateDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: context.tr(AppStrings.syndicateCardVerification),
      description:
          context.tr(AppStrings.toAddCommentYouMustVerifyYourSyndicateCard),
      noColoredButtonOnTap: () => Navigator.of(context).pop(),
      coloredButtonText: context.tr(AppStrings.ok),
      noColoredButtonText: '',
      isNoColorShow: true,
      coloredButtonOnTap: () => Navigator.of(context).pop(),
    );
  }

  void _trySubmit(BuildContext context) {
    if (!widget.accountVerification) {
      _showEmailVerificationDialog(context);
      return;
    }

    final needsSyndicate = widget.isSyndicateCardRequired == 'Required' ||
        widget.isSyndicateCardRequired == 'Pending';

    if (needsSyndicate) {
      _showSyndicateDialog(context);
      return;
    }

    widget.cubit.addPatientComments(patientId: widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

        return BlocConsumer<PatientCommentsCubit, PatientCommentsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (_, newComment, __, ___, ____) {
                if (newComment.isEmpty && _controller.text.isNotEmpty) {
                  _controller.clear();
                  final next = _appTextDirection();
                  if (next != _textDirection) {
                    setState(() => _textDirection = next);
                  }
                }
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loaded: (
                comments,
                newComment,
                isLoading,
                isCommentSuccess,
                message,
              ) {
                final canSend = newComment.trim().isNotEmpty && !isLoading;

                return PermissionGuard(
                  permission: AppPermissions.createPatientComment,
                  fallback: const SizedBox.shrink(),
                  child: SafeArea(
                    top: false,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(12.w, 8, 12.w, 8),
                      decoration: BoxDecoration(
                        color: HomeDashboardColors.scaffold(isDark),
                        border: Border(
                          top: BorderSide(
                            color: HomeDashboardColors.border(isDark)
                                .withOpacity(0.55),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              decoration: BoxDecoration(
                                color: HomeDashboardColors.cardBg(isDark),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: HomeDashboardColors.border(isDark)
                                      .withOpacity(0.8),
                                ),
                              ),
                              child: TextField(
                                controller: _controller,
                                enabled: !isLoading,
                                minLines: 1,
                                maxLines: 1,
                                textDirection: _textDirection,
                                textAlign: TextAlign.start,
                                textInputAction: TextInputAction.send,
                                cursorColor: primary,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: HomeDashboardColors.title(isDark),
                                ),
                                onChanged: (val) {
                                  widget.cubit.newComment = val;
                                  widget.cubit.newCommentValueChanged(val);
                                  final next = _directionFor(val);
                                  if (next != _textDirection) {
                                    setState(() => _textDirection = next);
                                  }
                                },
                                onSubmitted: (_) {
                                  if (canSend) _trySubmit(context);
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  filled: false,
                                  hintText:
                                      context.tr(AppStrings.writeComment),
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: HomeDashboardColors.subtitle(
                                      isDark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: canSend ? () => _trySubmit(context) : null,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 150),
                              opacity: canSend || isLoading ? 1 : 0.35,
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primary,
                                  shape: BoxShape.circle,
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(
                                        Icons.send_rounded,
                                        size: 18.sp,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
