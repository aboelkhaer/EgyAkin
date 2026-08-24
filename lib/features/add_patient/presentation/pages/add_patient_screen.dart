import 'dart:developer';
import 'package:egy_akin/app/shared/functions/select_question_has_displayable_answer.dart';
import 'package:egy_akin/app/shared/functions/multiple_question_has_displayable_answer.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:egy_akin/features/record/presentation/cubit/record_cubit.dart';
import 'package:egy_akin/features/record/presentation/pages/record_screen.dart';

import '../../../../exports.dart';

class AddPatientScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;
  const AddPatientScreen({
    super.key,
    required this.currentDoctorModel,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  late final ScrollController _scrollController;
  final Map<String, GlobalKey> _questionKeys = {};

  /// 1 = fully visible, 0 = fully hidden (scroll-linked, no jump).
  final ValueNotifier<double> _subtitleT = ValueNotifier<double>(1);
  static const double _subtitleCollapseRange = 48;

  /// Drives the red invalid highlight without setState (avoids list rebuild races).
  final ValueNotifier<String?> _invalidHighlightId =
      ValueNotifier<String?>(null);

  /// Exact offset after a successful scroll-to-invalid (restored after dialog OK).
  double? _pinnedInvalidScrollOffset;

  GlobalKey _keyForQuestion(String questionId) {
    return _questionKeys.putIfAbsent(questionId, GlobalKey.new);
  }

  double? _revealOffsetForQuestion(String questionId) {
    final ctx = _questionKeys[questionId]?.currentContext;
    if (ctx == null || !ctx.mounted) return null;
    final ro = ctx.findRenderObject();
    if (ro == null || !ro.attached) return null;
    final viewport = RenderAbstractViewport.maybeOf(ro);
    if (viewport == null) return null;
    return viewport.getOffsetToReveal(ro, 0.12).offset;
  }

  Future<void> _scrollToInvalidQuestion({
    required String? questionId,
    required int? questionIndex,
  }) async {
    if (!_scrollController.hasClients) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final maxExtent = _scrollController.position.maxScrollExtent;

    // 1) Jump near the estimated index so ListView builds the row.
    if (questionIndex != null && questionIndex >= 0) {
      final estimate = (10.h + questionIndex * 140.h).clamp(0.0, maxExtent);
      if ((_scrollController.offset - estimate).abs() > 24) {
        _scrollController.jumpTo(estimate);
        await WidgetsBinding.instance.endOfFrame;
        if (!mounted) return;
        await Future<void>.delayed(const Duration(milliseconds: 24));
        if (!mounted || !_scrollController.hasClients) return;
      }
    }

    // 2) Measure the real row offset and animate once.
    double? target;
    if (questionId != null) {
      target = _revealOffsetForQuestion(questionId);
      // One more frame if the row just mounted.
      if (target == null) {
        await WidgetsBinding.instance.endOfFrame;
        if (!mounted) return;
        target = _revealOffsetForQuestion(questionId);
      }
    }
    final latestMax = _scrollController.position.maxScrollExtent;
    target ??= (questionIndex != null && questionIndex >= 0)
        ? (10.h + questionIndex * 140.h).clamp(0.0, latestMax)
        : null;
    if (target == null) return;

    final clamped = target.clamp(0.0, latestMax);
    final distance = (clamped - _scrollController.offset).abs();
    if (distance > 1.5) {
      final ms = (380 + distance * 0.45).clamp(420.0, 900.0).round();
      await _scrollController.animateTo(
        clamped,
        duration: Duration(milliseconds: ms),
        curve: Curves.easeOutCubic,
      );
    }

    if (!mounted || !_scrollController.hasClients) return;

    // 3) Fine-tune once the row is laid out at the new scroll position.
    if (questionId != null) {
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted || !_scrollController.hasClients) return;
      final refined = _revealOffsetForQuestion(questionId);
      if (refined != null) {
        final refinedClamped =
            refined.clamp(0.0, _scrollController.position.maxScrollExtent);
        if ((refinedClamped - _scrollController.offset).abs() > 4) {
          _scrollController.jumpTo(refinedClamped);
        }
      }
    }

    if (!_scrollController.hasClients) return;
    _pinnedInvalidScrollOffset = _scrollController.offset;
  }

  void _restorePinnedInvalidScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    final pinned = _pinnedInvalidScrollOffset;
    if (pinned == null || !_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final target = pinned.clamp(0.0, max);
    if ((_scrollController.offset - target).abs() > 1) {
      _scrollController.jumpTo(target);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _subtitleT.dispose();
    _invalidHighlightId.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final next = (1 - (_scrollController.offset / _subtitleCollapseRange))
        .clamp(0.0, 1.0);
    if ((next - _subtitleT.value).abs() > 0.008) {
      _subtitleT.value = next;
    }
  }

  IconData _iconForQuestion(String? question) {
    final q = (question ?? '').toLowerCase();
    if (q.contains('name')) return Icons.person_outline_rounded;
    if (q.contains('hospital')) return Icons.apartment_rounded;
    if (q.contains('department')) return Icons.medical_services_outlined;
    if (q.contains('collect') || q.contains('from')) {
      return Icons.groups_outlined;
    }
    if (q.contains('email')) return Icons.mail_outline_rounded;
    if (q.contains('age')) return Icons.cake_outlined;
    if (q.contains('gender') || q.contains('sex')) {
      return Icons.wc_outlined;
    }
    if (q.contains('occupation') || q.contains('job')) {
      return Icons.work_outline_rounded;
    }
    if (q.contains('phone') || q.contains('mobile')) {
      return Icons.phone_outlined;
    }
    if (q.contains('national') || q.contains('id')) {
      return Icons.badge_outlined;
    }
    if (q.contains('address')) return Icons.location_on_outlined;
    if (q.contains('duration') || q.contains('time')) {
      return Icons.schedule_outlined;
    }
    if (q.contains('complain') || q.contains('symptom')) {
      return Icons.monitor_heart_outlined;
    }
    if (q.contains('marital')) return Icons.favorite_border_rounded;
    if (q.contains('education')) return Icons.school_outlined;
    if (q.contains('habit')) return Icons.smoking_rooms_outlined;
    if (q.contains('child') || q.contains('kids') || q.contains('offspring')) {
      return Icons.child_care_outlined;
    }
    return Icons.edit_outlined;
  }

  bool _isOthersSelected(AddPatientCubit cubit, String questionId) {
    final data = cubit.formData[questionId];
    if (data is! Map) return false;
    final answers = data[AppStrings.answers];
    return answers == AppStrings.others || answers == 'Others';
  }

  bool _shouldShowAiBadge({
    required AddPatientCubit cubit,
    required QuestionModel question,
    required String questionId,
  }) {
    if (!cubit.aiFilledQuestionIds.contains(questionId)) return false;
    if (question.type == AppStrings.questionTypeSelect) {
      return selectQuestionHasDisplayableAnswer(
        optionValues: question.values,
        storedAnswer: cubit.formData[questionId],
      );
    }
    if (question.type == AppStrings.multipleType) {
      return multipleQuestionHasDisplayableAnswer(
        optionValues: question.values,
        storedAnswer: cubit.formData[questionId],
      );
    }
    return true;
  }

  Future<void> _openVoice(AddPatientCubit cubit) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<RecordCubit>(),
          child: RecordScreen(
            questions: cubit.questionModelList ?? [],
            source: 'add_patient',
            sectionId: '1',
            aiMode: 'voice',
            aiHintHtml: cubit.addPatientAiHint,
            aiVoiceTime: cubit.addPatientAiVoiceTime,
          ),
        ),
      ),
    );

    if (result is Map<String, dynamic>) {
      cubit.applyVoiceAnswers(result);
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AddPatientCubit.get(context);
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
        final inputBg =
            isDark ? const Color(0xFF141416) : const Color(0xFFF3F4F6);
        final titleColor = HomeDashboardColors.title(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);

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
            body: Stack(
              children: [
                Column(
                  children: [
                    // Compact purple header — solid when subtitle is hidden
                    AnimatedContainer(
                      duration: Duration.zero,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isDark
                              ? [
                                  const Color(0xFF4A2F7A),
                                  const Color(0xFF2B1A52),
                                  scaffold,
                                ]
                              : [
                                  primary.withOpacity(0.28),
                                  primary.withOpacity(0.14),
                                  scaffold,
                                ],
                          stops: const [0.0, 0.55, 1.0],
                        ),
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 4.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _RoundIconButton(
                                    isDark: isDark,
                                    icon: Icons.arrow_back_ios_new_rounded,
                                    onTap: () =>
                                        Navigator.of(context).maybePop(),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      context.tr(AppStrings.newPatientTitle),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w800,
                                        color:
                                            isDark ? Colors.white : titleColor,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ),
                                  _MicButton(
                                    primary: primary,
                                    onTap: () => _openVoice(cubit),
                                  ),
                                ],
                              ),
                              ValueListenableBuilder<double>(
                                valueListenable: _subtitleT,
                                builder: (context, subtitleT, _) {
                                  final subtitleEase =
                                      Curves.easeOutCubic.transform(subtitleT);
                                  return ClipRect(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      heightFactor: subtitleEase,
                                      child: Opacity(
                                        opacity: Curves.easeOut
                                            .transform(subtitleT)
                                            .clamp(0.0, 1.0),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            8.w,
                                            10.h,
                                            8.w,
                                            2.h,
                                          ),
                                          child: Text(
                                            context.tr(
                                              AppStrings
                                                  .enterBasicDataToCreatePatient,
                                            ),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              color: isDark
                                                  ? Colors.white
                                                      .withOpacity(0.62)
                                                  : muted,
                                            ),
                                          ),
                                        ),
                                      ),
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
                      child: Form(
                        key: cubit.addPatientKeyForm,
                        child: BlocBuilder<AddPatientCubit, AddPatientState>(
                          // Don't rebuild the form list on validation message-only
                          // emits — that resets scroll when the error dialog closes.
                          buildWhen: (previous, current) {
                            return previous.maybeWhen(
                              loaded: (questions, _, __, isLoading, ___, ____) {
                                return current.maybeWhen(
                                  loaded: (q2, _, __, loading2, ___, ____) =>
                                      !identical(questions, q2) ||
                                      isLoading != loading2,
                                  orElse: () => true,
                                );
                              },
                              orElse: () => true,
                            );
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => _AddPatientLoadingView(
                                isDark: isDark,
                                primary: primary,
                                message: context.tr(
                                  AppStrings.preparingPatientForm,
                                ),
                              ),
                              loaded: (
                                questions,
                                isAddedPatientSuccessfully,
                                patientId,
                                isAddPatientLoading,
                                message,
                                _,
                              ) {
                                if (isAddPatientLoading) {
                                  return _AddPatientLoadingView(
                                    isDark: isDark,
                                    primary: primary,
                                    message: 'Creating patient…',
                                  );
                                }
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    inputDecorationTheme: InputDecorationTheme(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 10.h,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: 11.sp,
                                        color: muted,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      labelStyle: TextStyle(
                                        fontSize: 11.sp,
                                        color: muted,
                                      ),
                                    ),
                                    textTheme:
                                        Theme.of(context).textTheme.apply(
                                              fontSizeFactor: 0.92,
                                            ),
                                  ),
                                  child: ListView.separated(
                                    controller: _scrollController,
                                    physics: const BouncingScrollPhysics(),
                                    // Build all form rows so scroll-to-invalid can
                                    // use one exact animateTo (no second settle).
                                    cacheExtent: 10000,
                                    padding: EdgeInsets.fromLTRB(
                                      14.w,
                                      10.h,
                                      14.w,
                                      110.h,
                                    ),
                                    itemCount: questions.length + 1,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 8.h),
                                    itemBuilder: (context, index) {
                                      if (index == questions.length) {
                                        return Padding(
                                          padding: EdgeInsets.only(top: 4.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.shield_outlined,
                                                size: 11.sp,
                                                color: muted,
                                              ),
                                              SizedBox(width: 4.w),
                                              Flexible(
                                                child: Text(
                                                  context.tr(
                                                    AppStrings
                                                        .encryptedVisibleOnlyToAssignedDoctors,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 9.5.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: muted,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }

                                      final question = questions[index];
                                      final isRequired =
                                          question.mandatory == true ||
                                              question.question ==
                                                  AppStrings.nationalID;
                                      final isMultiple = question.type ==
                                          AppStrings.multipleType;
                                      final questionId = question.id.toString();
                                      const errorRed = Color(0xFFEF4444);

                                      return ValueListenableBuilder<String?>(
                                        valueListenable: _invalidHighlightId,
                                        builder: (context, invalidId, _) {
                                          final isInvalidHighlight =
                                              invalidId == questionId;
                                          return KeyedSubtree(
                                            key: _keyForQuestion(questionId),
                                            child:
                                                TweenAnimationBuilder<double>(
                                              key: ValueKey(
                                                'q-$questionId-invalid-$isInvalidHighlight',
                                              ),
                                              tween: Tween<double>(
                                                begin: isInvalidHighlight
                                                    ? 0.96
                                                    : 1.0,
                                                end: 1.0,
                                              ),
                                              duration: Duration(
                                                milliseconds: isInvalidHighlight
                                                    ? 560
                                                    : 220,
                                              ),
                                              curve: isInvalidHighlight
                                                  ? Curves.easeOutBack
                                                  : Curves.easeOutCubic,
                                              builder: (context, scale, child) {
                                                return Transform.scale(
                                                  scale: scale,
                                                  alignment: Alignment.center,
                                                  child: child,
                                                );
                                              },
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 320),
                                                curve: Curves.easeOutCubic,
                                                padding: EdgeInsets.fromLTRB(
                                                  12.w,
                                                  10.h,
                                                  12.w,
                                                  10.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isInvalidHighlight
                                                      ? (isDark
                                                          ? errorRed
                                                              .withOpacity(0.14)
                                                          : const Color(
                                                              0xFFFEF2F2))
                                                      : cardBg,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                  border: Border.all(
                                                    color: isInvalidHighlight
                                                        ? errorRed
                                                        : (isDark
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.06)
                                                            : const Color(
                                                                0xFFE8E8EE)),
                                                    width: isInvalidHighlight
                                                        ? 1.6
                                                        : 1,
                                                  ),
                                                  boxShadow: isDark
                                                      ? null
                                                      : [
                                                          BoxShadow(
                                                            color: isInvalidHighlight
                                                                ? errorRed
                                                                    .withOpacity(
                                                                        0.12)
                                                                : Colors.black
                                                                    .withOpacity(
                                                                        0.03),
                                                            blurRadius: 10,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '${index + 1} · ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: isInvalidHighlight
                                                                        ? errorRed
                                                                        : primary,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: question
                                                                          .question ??
                                                                      '',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color:
                                                                        titleColor,
                                                                  ),
                                                                ),
                                                                if (isRequired)
                                                                  TextSpan(
                                                                    text: ' *',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          11.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color:
                                                                          errorRed,
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        if (_shouldShowAiBadge(
                                                          cubit: cubit,
                                                          question: question,
                                                          questionId:
                                                              questionId,
                                                        )) ...[
                                                          SizedBox(width: 8.w),
                                                          const AiFilledFieldBanner(
                                                            compact: true,
                                                          ),
                                                        ],
                                                      ],
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    if (isMultiple)
                                                      buildQuestionWidget(
                                                        questions,
                                                        index,
                                                        size,
                                                        cubit,
                                                      )
                                                    else ...[
                                                      // No fixed height — FormField error
                                                      // text must be allowed to grow.
                                                      Container(
                                                        constraints:
                                                            BoxConstraints(
                                                          minHeight: 44.h,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: inputBg,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            12.r,
                                                          ),
                                                          border: Border.all(
                                                            color: isInvalidHighlight
                                                                ? errorRed
                                                                    .withOpacity(
                                                                        0.85)
                                                                : primary
                                                                    .withOpacity(
                                                                        0.75),
                                                            width: 1.2,
                                                          ),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 2.h,
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: 12.h,
                                                              ),
                                                              child: Icon(
                                                                _iconForQuestion(
                                                                  question
                                                                      .question,
                                                                ),
                                                                size: 15.sp,
                                                                color:
                                                                    isInvalidHighlight
                                                                        ? errorRed
                                                                        : muted,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 6.w),
                                                            Expanded(
                                                              child:
                                                                  buildQuestionWidget(
                                                                questions,
                                                                index,
                                                                size,
                                                                cubit,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      if (question.type ==
                                                              AppStrings
                                                                  .questionTypeSelect &&
                                                          _isOthersSelected(
                                                            cubit,
                                                            questionId,
                                                          )) ...[
                                                        SizedBox(height: 8.h),
                                                        Container(
                                                          height: 44.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: inputBg,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              12.r,
                                                            ),
                                                            border: Border.all(
                                                              color: primary
                                                                  .withOpacity(
                                                                      0.75),
                                                              width: 1.2,
                                                            ),
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 10.w,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .edit_note_rounded,
                                                                size: 15.sp,
                                                                color: muted,
                                                              ),
                                                              SizedBox(
                                                                  width: 6.w),
                                                              Expanded(
                                                                child:
                                                                    CustomTextFormField(
                                                                  title: context
                                                                      .tr(
                                                                    AppStrings
                                                                        .answerHere,
                                                                  ),
                                                                  initialValue:
                                                                      () {
                                                                    final raw =
                                                                        cubit.formData[
                                                                            questionId];
                                                                    if (raw
                                                                        is Map) {
                                                                      final other =
                                                                          raw[AppStrings
                                                                              .otherField];
                                                                      if (other
                                                                          is String) {
                                                                        return other;
                                                                      }
                                                                    }
                                                                    return '';
                                                                  }(),
                                                                  textInputType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  fillColor: Colors
                                                                      .transparent,
                                                                  isCreatePostInCommunity:
                                                                      true,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        2.w,
                                                                    vertical:
                                                                        8.h,
                                                                  ),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                  validator:
                                                                      (_) =>
                                                                          null,
                                                                  onChanged:
                                                                      (value) {
                                                                    final map = Map<
                                                                        String,
                                                                        dynamic>.from(
                                                                      cubit.formData[questionId]
                                                                              as Map? ??
                                                                          {
                                                                            AppStrings.answers:
                                                                                AppStrings.others,
                                                                            AppStrings.otherField:
                                                                                '',
                                                                          },
                                                                    );
                                                                    map[AppStrings
                                                                            .otherField] =
                                                                        value;
                                                                    cubit.formData[
                                                                            questionId] =
                                                                        map;
                                                                    cubit
                                                                        .clearAiFilledMark(
                                                                      questionId,
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0B0B0D) : Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18.r),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: isDark
                              ? Colors.white.withOpacity(0.06)
                              : const Color(0xFFE8E8EE),
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.45 : 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      minimum: EdgeInsets.only(bottom: 2.h),
                      child: BlocConsumer<AddPatientCubit, AddPatientState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () {},
                            loaded: (
                              questions,
                              isAddedPatientSuccessfully,
                              patientId,
                              isAddPatientLoading,
                              message,
                              _,
                            ) {
                              if (isAddedPatientSuccessfully) {
                                navigatorKey.currentState
                                    ?.pushNamed(AppRoutes.home, arguments: 0);
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.patientSections,
                                  arguments: AppRoutesArgs
                                      .patientSectionsRouteArguments(
                                    patientId: patientId.toString(),
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    currentDoctorPoints:
                                        widget.currentDoctorPoints,
                                    currentDoctorRole: widget.currentDoctorRole,
                                    homeDataModel: widget.homeDataModel,
                                    isAllDataOpen: false,
                                  ),
                                );
                              }
                              if (message.isNotEmpty) {
                                final invalidId = cubit.firstInvalidQuestionId;
                                final invalidIndex =
                                    cubit.firstInvalidQuestionIndex;
                                final errorMessage = message;
                                _invalidHighlightId.value = invalidId;
                                () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  // Wait a frame so highlight/layout settle.
                                  await WidgetsBinding.instance.endOfFrame;
                                  if (!mounted) return;
                                  await _scrollToInvalidQuestion(
                                    questionId: invalidId,
                                    questionIndex: invalidIndex,
                                  );
                                  if (!context.mounted) return;
                                  await showHintDialog(
                                    context: context,
                                    message: errorMessage,
                                    dialogType: DialogType.error,
                                  );
                                  if (!mounted) return;
                                  cubit.acknowledgeFieldErrorDialog();
                                  // Restore after focus/route settle (Age jump fix).
                                  await Future<void>.delayed(
                                    const Duration(milliseconds: 50),
                                  );
                                  if (!mounted) return;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _restorePinnedInvalidScroll();
                                  // Second pass next frame in case layout shifted.
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (!mounted) return;
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    _restorePinnedInvalidScroll();
                                  });
                                }();
                              }
                            },
                            error: (message) {
                              showCustomDialog(
                                context: context,
                                title: context.tr(AppStrings.attention),
                                description: message,
                                coloredButtonText:
                                    context.tr(AppStrings.cancel),
                                isNoColorShow: false,
                                coloredButtonOnTap: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            loaded: (
                              questions,
                              isAddedPatientSuccessfully,
                              patientId,
                              isAddPatientLoading,
                              message,
                              _,
                            ) {
                              if (isAddPatientLoading) {
                                return _AddPatientFooterLoading(
                                  isDark: isDark,
                                  primary: primary,
                                );
                              }
                              return SubmitButton(cubit: cubit);
                            },
                            loading: () => _AddPatientFooterSkeleton(
                              isDark: isDark,
                            ),
                            orElse: () => _AddPatientFooterSkeleton(
                              isDark: isDark,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildQuestionWidget(List<QuestionModel> questionList, int index,
      Size size, AddPatientCubit cubit) {
    switch (questionList[index].type) {
      case AppStrings.string:
        var questionAnswer = questionList[index].answer;
        questionAnswer ??= '';
        final qid = questionList[index].id.toString();
        return BuildStringValueQuestions(
          questionList: questionList,
          initialValue: () {
            final raw = cubit.formData[qid];
            if (raw is String) return raw;
            return AppStrings.empty;
          }(),
          index: index,
          isAddPatient: true,
          showAiFilledBanner: false,
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qid),
          textInputFormatter:
              questionList[index].question == AppStrings.phone ||
                      questionList[index].question == AppStrings.mobile
                  ? [
                      LengthLimitingTextInputFormatter(11),
                    ]
                  : questionList[index].question == AppStrings.nationalID
                      ? [
                          LengthLimitingTextInputFormatter(14),
                        ]
                      : questionList[index].question == 'Age'
                          ? [
                              LengthLimitingTextInputFormatter(3),
                            ]
                          : [
                              LengthLimitingTextInputFormatter(200),
                            ],
          onChanged: (val) {
            cubit.clearInvalidHighlight(questionList[index].id.toString());
            _invalidHighlightId.value = null;
            if (questionAnswer != val) {
              questionAnswer = val;
              cubit.formData[questionList[index].id.toString()] = val;
            } else {
              questionAnswer = null;
              cubit.formData.remove(questionList[index].id.toString());
            }
            log(questionAnswer.toString());
          },
          validator: (val) {
            return null;
          },
        );

      //! Select
      case AppStrings.questionTypeSelect:
        var questionAnswer = questionList[index].answer;
        final qidSelect = questionList[index].id.toString();

        // Keep a mutable map tied to formData (never store null other_field).
        Map<dynamic, dynamic> answerMapForSelect = Map<dynamic, dynamic>.from(
          cubit.formData[qidSelect] is Map
              ? cubit.formData[qidSelect] as Map
              : {
                  AppStrings.answers: '',
                  AppStrings.otherField: AppStrings.empty,
                },
        );
        answerMapForSelect[AppStrings.otherField] ??= AppStrings.empty;
        cubit.formData[qidSelect] = answerMapForSelect;

        final storedAnswer = answerMapForSelect[AppStrings.answers];
        final modelAnswer = questionAnswer is Map
            ? questionAnswer[AppStrings.answers]
            : questionAnswer;

        return BuildSelectValueQuestion(
          questionList: questionList,
          index: index,
          formData: cubit.formData,
          isAddPatient: true,
          showAiFilledBanner: false,
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qidSelect),
          selected: initialValueInSelectQuestion(
            questionAnswer: storedAnswer ?? modelAnswer,
            selectedValue: storedAnswer,
            values: questionList[index].values!,
          ),
          validator: (val) {
            final answers = answerMapForSelect[AppStrings.answers];
            if (questionList[index].mandatory == true &&
                (answers == null ||
                    answers.toString().trim().isEmpty ||
                    answers == AppStrings.empty)) {
              return AppStrings.thisFieldIsRequired;
            }
            return null;
          },
          onChanged: (val) {
            cubit.clearInvalidHighlight(qidSelect);
            _invalidHighlightId.value = null;
            setState(() {
              answerMapForSelect[AppStrings.answers] = val ?? '';
              if (val != AppStrings.others) {
                answerMapForSelect[AppStrings.otherField] = AppStrings.empty;
              }
              cubit.formData[qidSelect] = Map<dynamic, dynamic>.from(
                answerMapForSelect,
              );
            });
            debugPrint('onChanged: ${cubit.formData}');
          },
          onChangedForOtherField: (value) {
            setState(() {
              answerMapForSelect[AppStrings.otherField] = value ?? '';
              cubit.formData[qidSelect] = Map<dynamic, dynamic>.from(
                answerMapForSelect,
              );
            });
            debugPrint('onChangedForOtherField: ${cubit.formData}');
          },
        );

      //! Multiple
      case AppStrings.multipleType:
        final qidMulti = questionList[index].id.toString();
        final rawMulti = cubit.formData[qidMulti];
        final Map<String, dynamic> answerMap = rawMulti is Map
            ? {
                AppStrings.answers: List<dynamic>.from(
                  (rawMulti[AppStrings.answers] is List)
                      ? rawMulti[AppStrings.answers] as List
                      : const [],
                ),
                AppStrings.otherField:
                    rawMulti[AppStrings.otherField]?.toString() ??
                        AppStrings.empty,
              }
            : {
                AppStrings.answers: <dynamic>[],
                AppStrings.otherField: AppStrings.empty,
              };
        // Keep cubit.formData in sync with a mutable typed map.
        cubit.formData[qidMulti] = answerMap;

        return BuildMultipleValueQuestion(
          index: index,
          questionList: questionList,
          initialValue: answerMap[AppStrings.otherField] ?? AppStrings.empty,
          showAiFilledBanner: false,
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qidMulti),
          onChanged: (val) {
            setState(() {
              answerMap[AppStrings.otherField] = val;
            });
            cubit.formData[questionList[index].id.toString()] = {
              AppStrings.answers: List.from(answerMap[AppStrings.answers]),
              AppStrings.otherField: answerMap[AppStrings.otherField],
            };
            debugPrint('map ${cubit.formData}');
          },
          validator: (val) {
            if (questionList[index].mandatory == true &&
                (answerMap[AppStrings.answers] as List<dynamic>)
                    .contains(AppStrings.others)) {
              if (val == null || val.isEmpty) {
                return AppStrings.thisFieldIsRequired;
              }
            }
            return null;
          },
          listContainOther: List.from(answerMap[AppStrings.answers]),
          children: questionList[index].values!.map((value) {
            final isSelected = (answerMap[AppStrings.answers] as List<dynamic>)
                .contains(value);
            final currentTheme = BlocProvider.of<ThemeBloc>(context).state;
            final isDarkModeLocal =
                currentTheme is ThemeLoaded && currentTheme.isDarkMode;
            final primaryLocal =
                isDarkModeLocal ? AppColors.darkPrimary : AppColors.primary;

            return GestureDetector(
              onTap: () {
                cubit.clearAiFilledMark(qidMulti);
                cubit.clearInvalidHighlight(qidMulti);
                _invalidHighlightId.value = null;
                setState(() {
                  if (isSelected) {
                    (answerMap[AppStrings.answers] as List).remove(value);
                  } else {
                    (answerMap[AppStrings.answers] as List).add(value);
                  }
                });
                cubit.formData[questionList[index].id.toString()] = {
                  AppStrings.answers: List.from(answerMap[AppStrings.answers]),
                  AppStrings.otherField: answerMap[AppStrings.otherField],
                };
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                margin: EdgeInsets.only(bottom: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryLocal.withOpacity(isDarkModeLocal ? 0.28 : 0.14)
                      : (isDarkModeLocal
                          ? const Color(0xFF2A2A2E)
                          : const Color(0xFFF3F4F6)),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? primaryLocal.withOpacity(0.55)
                        : (isDarkModeLocal
                            ? Colors.white.withOpacity(0.08)
                            : const Color(0xFFE5E7EB)),
                  ),
                ),
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? (isDarkModeLocal ? Colors.white : primaryLocal)
                        : (isDarkModeLocal
                            ? Colors.white70
                            : const Color(0xFF4B5563)),
                  ),
                ),
              ),
            );
          }).toList(),
        );

      //! Date
      case AppStrings.date:
        String? questionAnswer = questionList[index].answer;

        return SizedBox(
          width: size.width * 0.4,
          child: CustomElevatedButton(
            onPressed: () async {},
            title: questionAnswer == null
                ? AppStrings.addDate
                : stringDateTostring(questionAnswer),
            hasIcon: true,
          ),
        );

      default:
        return Container();
    }
  }

  String stringDateTostring(String datevalue) {
    DateTime convertDate = DateTime.parse(datevalue);

    String stringdate =
        '${convertDate.day}/${convertDate.month}/${convertDate.year}';

    return stringdate;
  }

  showDate(String dateTime) async {
    DateTime dateTime0;
    if (dateTime.isNotEmpty) {
      dateTime0 = DateFormat('MM/dd/yyyy').parse(dateTime);
    } else {
      dateTime0 = DateTime.now();
    }
    return await showDatePicker(
      context: context,
      initialDate: dateTime0,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  Future processItems({
    required List<QuestionModel> questionList,
    required bool isValid,
  }) async {
    Future.forEach(questionList, (QuestionModel questionModel) async {
      if (questionModel.type == AppStrings.multipleType &&
          questionModel.mandatory == true) {
        if (questionModel.answer == [] ||
            questionModel.answer[AppStrings.otherField] == null ||
            questionModel.answer[AppStrings.otherField] == AppStrings.empty) {
          customSnackBar(
              message:
                  '${AppStrings.enterAllRequiredFieldsPlease} \n{${questionModel.question}}',
              context: context);

          isValid = false;
          return;
        }
      }
      if (questionModel.mandatory == true &&
          (questionModel.answer == null ||
              questionModel.answer == AppStrings.empty)) {
        customSnackBar(
            message:
                '${AppStrings.enterAllRequiredFieldsPlease} \n{${questionModel.question}}',
            context: context);

        isValid = false;
        return;
      }
    });
  }
}

class _AddPatientLoadingView extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String message;

  const _AddPatientLoadingView({
    required this.isDark,
    required this.primary,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primary.withOpacity(isDark ? 0.28 : 0.16),
                    primary.withOpacity(0),
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                  border: Border.all(
                    color: primary.withOpacity(0.35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Please wait a moment',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white54 : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddPatientFooterSkeleton extends StatelessWidget {
  final bool isDark;

  const _AddPatientFooterSkeleton({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final base = isDark ? const Color(0xFF2A2A2E) : const Color(0xFFE8E8EE);
    final highlight =
        isDark ? const Color(0xFF3A3A40) : const Color(0xFFF5F5F7);

    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 2.h),
      child: Shimmer.fromColors(
        baseColor: base,
        highlightColor: highlight,
        period: const Duration(milliseconds: 1200),
        child: Container(
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 8.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 30.r,
                height: 30.r,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPatientFooterLoading extends StatelessWidget {
  final bool isDark;
  final Color primary;

  const _AddPatientFooterLoading({
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 8.h),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: primary.withOpacity(isDark ? 0.22 : 0.12),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: primary.withOpacity(0.28)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16.r,
              height: 16.r,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              'Creating patient…',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: primary,
              ),
            ),
          ],
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
        ),
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  final Color primary;
  final VoidCallback onTap;

  const _MicButton({
    required this.primary,
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
              Icons.mic_rounded,
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
