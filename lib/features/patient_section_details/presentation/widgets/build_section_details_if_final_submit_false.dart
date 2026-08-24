import 'package:egy_akin/app/shared/functions/multiple_question_has_displayable_answer.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/functions/select_question_has_displayable_answer.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_question.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/section_submit_button.dart';
import 'package:flutter/rendering.dart';

import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class BuildSectionDetailsIfFinalSubmitFalse extends StatefulWidget {
  final List<QuestionModel> questions;
  final String doctorId;
  final String patientId;
  final SectionModel sectionModel;
  final HomeModelResponse homeDataModel;
  final bool isAllDataOpen;
  final DoctorModel currentDoctorModel;
  final bool finalSubmitStatus;
  const BuildSectionDetailsIfFinalSubmitFalse(
      {super.key,
      required this.questions,
      required this.patientId,
      required this.doctorId,
      required this.sectionModel,
      required this.homeDataModel,
      required this.currentDoctorModel,
      required this.finalSubmitStatus,
      required this.isAllDataOpen});

  @override
  State<BuildSectionDetailsIfFinalSubmitFalse> createState() =>
      _BuildSectionDetailsIfFinalSubmitFalseState();
}

class _BuildSectionDetailsIfFinalSubmitFalseState
    extends State<BuildSectionDetailsIfFinalSubmitFalse> {
  final Map<String, GlobalKey> _questionKeys = {};
  final ValueNotifier<String?> _invalidHighlightId =
      ValueNotifier<String?>(null);
  double? _pinnedInvalidScrollOffset;
  int _lastHandledErrorCounter = -1;

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
    required ScrollController scrollController,
    required String? questionId,
    required int? questionIndex,
  }) async {
    if (!scrollController.hasClients) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final maxExtent = scrollController.position.maxScrollExtent;

    if (questionIndex != null && questionIndex >= 0) {
      final estimate =
          (10.h + questionIndex * 140.h).clamp(0.0, maxExtent);
      if ((scrollController.offset - estimate).abs() > 24) {
        scrollController.jumpTo(estimate);
        await WidgetsBinding.instance.endOfFrame;
        if (!mounted) return;
        await Future<void>.delayed(const Duration(milliseconds: 24));
        if (!mounted || !scrollController.hasClients) return;
      }
    }

    double? measured =
        questionId != null ? _revealOffsetForQuestion(questionId) : null;
    final latestMax = scrollController.position.maxScrollExtent;
    final target = (measured ?? scrollController.offset).clamp(0.0, latestMax);
    final distance = (target - scrollController.offset).abs();
    if (distance > 2) {
      await scrollController.animateTo(
        target,
        duration: Duration(milliseconds: distance > 400 ? 420 : 280),
        curve: Curves.easeOutCubic,
      );
    }

    if (!mounted || !scrollController.hasClients) return;
    _pinnedInvalidScrollOffset = scrollController.offset;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !scrollController.hasClients || questionId == null) {
        return;
      }
      final refined = _revealOffsetForQuestion(questionId);
      if (refined == null) return;
      final refinedClamped =
          refined.clamp(0.0, scrollController.position.maxScrollExtent);
      if ((refinedClamped - scrollController.offset).abs() > 4) {
        scrollController.jumpTo(refinedClamped);
      }
      _pinnedInvalidScrollOffset = scrollController.offset;
    });
  }

  void _restorePinnedInvalidScroll(ScrollController scrollController) {
    final pinned = _pinnedInvalidScrollOffset;
    if (pinned == null || !scrollController.hasClients) return;
    final max = scrollController.position.maxScrollExtent;
    final target = pinned.clamp(0.0, max);
    if ((scrollController.offset - target).abs() > 1) {
      scrollController.jumpTo(target);
    }
  }

  bool _shouldShowAiBadge({
    required PatientSectionDetailsCubit cubit,
    required QuestionModel question,
    required String questionId,
  }) {
    if (!cubit.aiFilledQuestionIds.contains(questionId)) return false;
    if (question.type == AppStrings.questionTypeSelect ||
        question.type == AppStrings.selectType) {
      return selectQuestionHasDisplayableAnswer(
        optionValues: question.values,
        storedAnswer: cubit.formData[questionId] ?? question.answer,
      );
    }
    if (question.type == AppStrings.multipleType ||
        question.type == AppStrings.questionTypeMultiple) {
      return multipleQuestionHasDisplayableAnswer(
        optionValues: question.values,
        storedAnswer: cubit.formData[questionId] ?? question.answer,
      );
    }
    return true;
  }

  Future<void> _handleValidationMessage({
    required PatientSectionDetailsCubit cubit,
    required String message,
    required int snackbarErrorCounter,
  }) async {
    if (message.isEmpty) return;
    if (snackbarErrorCounter == _lastHandledErrorCounter) return;
    _lastHandledErrorCounter = snackbarErrorCounter;

    final invalidId = cubit.firstInvalidQuestionId;
    final invalidIndex = cubit.firstInvalidQuestionIndex;
    final errorMessage = message;
    _invalidHighlightId.value = invalidId;

    FocusManager.instance.primaryFocus?.unfocus();
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;

    await _scrollToInvalidQuestion(
      scrollController: cubit.patientSectionDetailsScrollController,
      questionId: invalidId,
      questionIndex: invalidIndex,
    );
    if (!mounted) return;

    await showHintDialog(
      context: context,
      message: errorMessage,
      dialogType: DialogType.error,
    );
    if (!mounted) return;

    cubit.acknowledgeFieldErrorDialog();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
    _restorePinnedInvalidScroll(cubit.patientSectionDetailsScrollController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      FocusManager.instance.primaryFocus?.unfocus();
      _restorePinnedInvalidScroll(cubit.patientSectionDetailsScrollController);
    });
  }

  @override
  void dispose() {
    _invalidHighlightId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = PatientSectionDetailsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
        final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
        final muted = HomeDashboardColors.subtitle(isDark);
        final titleColor = HomeDashboardColors.title(isDark);

        return BlocListener<PatientSectionDetailsCubit,
            PatientSectionDetailsState>(
          listenWhen: (previous, current) {
            return current.maybeWhen(
              loaded: (_, __, ___, message, snackbarErrorCounter, ____, _____,
                  ______, _______, ________, _________, __________,
                  ___________, ____________, _____________) {
                return message.isNotEmpty;
              },
              orElse: () => false,
            );
          },
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (
                questions,
                isSubmitLoading,
                isSubmitted,
                message,
                snackbarErrorCounter,
                isChooseFilesLoading,
                isChooseFilesLoaded,
                uploadFilesProgress,
                isGetMedicationsLoading,
                isGetMedicationsLoaded,
                isSearchMedicationLoading,
                counterChanges,
                isCreateMedicationLoading,
                isCreateMedicationLoaded,
                dialogMessage,
              ) {
                if (isSubmitted || isSubmitLoading) return;
                _handleValidationMessage(
                  cubit: cubit,
                  message: message,
                  snackbarErrorCounter: snackbarErrorCounter,
                );
              },
            );
          },
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                behavior: HitTestBehavior.deferToChild,
                child: Form(
                key: cubit.sectionDetailsKeyForm,
                child: Column(
                  children: [
                    Expanded(
                      child: Theme(
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
                          textTheme: Theme.of(context).textTheme.apply(
                                fontSizeFactor: 0.92,
                              ),
                        ),
                        child: BlocBuilder<PatientSectionDetailsCubit,
                            PatientSectionDetailsState>(
                          // Avoid rebuilding the list on message-only emits
                          // (keeps scroll stable after dialog OK).
                          buildWhen: (previous, current) {
                            return previous.maybeWhen(
                              loaded: (
                                questions,
                                isSubmitLoading,
                                _,
                                __,
                                ___,
                                ____,
                                _____,
                                ______,
                                _______,
                                ________,
                                _________,
                                counterChanges,
                                __________,
                                ___________,
                                ____________,
                              ) {
                                return current.maybeWhen(
                                  loaded: (
                                    q2,
                                    loading2,
                                    _,
                                    __,
                                    ___,
                                    ____,
                                    _____,
                                    ______,
                                    _______,
                                    ________,
                                    _________,
                                    counter2,
                                    __________,
                                    ___________,
                                    ____________,
                                  ) =>
                                      !identical(questions, q2) ||
                                      isSubmitLoading != loading2 ||
                                      counterChanges != counter2,
                                  orElse: () => true,
                                );
                              },
                              orElse: () => true,
                            );
                          },
                          builder: (context, state) {
                            return ListView.separated(
                              itemCount: widget.questions.length,
                              controller:
                                  cubit.patientSectionDetailsScrollController,
                              physics: const BouncingScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              cacheExtent: 10000,
                              padding: EdgeInsets.fromLTRB(
                                14.w,
                                10.h,
                                14.w,
                                110.h,
                              ),
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 8.h),
                              itemBuilder: (context, index) {
                                final questionModel = widget.questions[index];
                                final questionId =
                                    questionModel.id.toString();
                                final isRequired =
                                    questionModel.mandatory == true ||
                                        questionModel.question ==
                                            AppStrings.nationalID;
                                const errorRed = Color(0xFFEF4444);
                                final showAi = _shouldShowAiBadge(
                                  cubit: cubit,
                                  question: questionModel,
                                  questionId: questionId,
                                );

                                return ValueListenableBuilder<String?>(
                                  valueListenable: _invalidHighlightId,
                                  builder: (context, invalidId, _) {
                                    final isInvalidHighlight =
                                        invalidId == questionId;
                                    return KeyedSubtree(
                                      key: _keyForQuestion(questionId),
                                      child: TweenAnimationBuilder<double>(
                                        key: ValueKey(
                                          'q-$questionId-invalid-$isInvalidHighlight',
                                        ),
                                        tween: Tween<double>(
                                          begin:
                                              isInvalidHighlight ? 0.96 : 1.0,
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
                                                    : const Color(0xFFFEF2F2))
                                                : cardBg,
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            border: Border.all(
                                              color: isInvalidHighlight
                                                  ? errorRed
                                                  : (isDark
                                                      ? Colors.white
                                                          .withOpacity(0.06)
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
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                '${index + 1} · ',
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: primary,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: questionModel
                                                                    .question ??
                                                                '',
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  titleColor,
                                                              height: 1.25,
                                                            ),
                                                          ),
                                                          if (isRequired)
                                                            TextSpan(
                                                              text: ' *',
                                                              style:
                                                                  TextStyle(
                                                                fontSize:
                                                                    12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color:
                                                                    errorRed,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  if (showAi) ...[
                                                    SizedBox(width: 8.w),
                                                    const AiFilledFieldBanner(
                                                      compact: true,
                                                    ),
                                                  ],
                                                  _RemoveAllFilesAction(
                                                    cubit: cubit,
                                                    index: index,
                                                    questionModel:
                                                        questionModel,
                                                    patientId: widget.patientId,
                                                    sectionId: widget
                                                        .sectionModel.sectionId
                                                        .toString(),
                                                    primary: primary,
                                                  ),
                                                ],
                                              ),
                                              if (questionModel.type ==
                                                  AppStrings.questionTypeFiles)
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 6.h),
                                                  child: Text(
                                                    'Files upload immediately after selection',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: muted,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              SizedBox(height: 10.h),
                                              GestureDetector(
                                                onTap: () {
                                                  cubit.clearInvalidHighlight(
                                                      questionId);
                                                  _invalidHighlightId.value =
                                                      null;
                                                },
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                child: BuildQuestion(
                                                  index: index,
                                                  currentDoctorModel: widget
                                                      .currentDoctorModel,
                                                  doctorId: widget.doctorId,
                                                  homeDataModel:
                                                      widget.homeDataModel,
                                                  isAllDataOpen:
                                                      widget.isAllDataOpen,
                                                  patientId: widget.patientId,
                                                  sectionModel:
                                                      widget.sectionModel,
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
                        ),
                      ),
                    ),
                    if (widget.sectionModel.sectionId.toString() != '9' &&
                        (PermissionHelper.canPermission(AppPermissions
                                .viewSubmitButtonForAdminInPatientSectionDetails) ||
                            !(widget.finalSubmitStatus &&
                                widget.sectionModel.alwaysOpen != true)))
                      const SizedBox(height: 78),
                  ],
                ),
              ),
              ),
              SectionSubmitButton(
                doctorId: widget.doctorId,
                currentDoctorModel: widget.currentDoctorModel,
                currentDoctorRole: widget.homeDataModel.role.toString(),
                sectionModel: widget.sectionModel,
                patientId: widget.patientId,
                currentDoctorPoints:
                    int.parse(widget.homeDataModel.scoreValue.toString()),
                finalSubmitStatus: widget.finalSubmitStatus,
                homeDataModel: widget.homeDataModel,
                isAllDataOpen: widget.isAllDataOpen,
                handleErrorDialogs: false,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RemoveAllFilesAction extends StatelessWidget {
  final PatientSectionDetailsCubit cubit;
  final int index;
  final QuestionModel questionModel;
  final String patientId;
  final String sectionId;
  final Color primary;

  const _RemoveAllFilesAction({
    required this.cubit,
    required this.index,
    required this.questionModel,
    required this.patientId,
    required this.sectionId,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    if (questionModel.type != AppStrings.questionTypeFiles) {
      return const SizedBox.shrink();
    }

    final formFiles = cubit.formData[questionModel.id.toString()];
    final hasFormFiles =
        formFiles is List && formFiles.isNotEmpty;
    final answer = cubit.questionModelList[index].answer;
    final hasAnswerFiles = answer is List && answer.isNotEmpty;
    if (!hasFormFiles && !hasAnswerFiles) {
      return const SizedBox.shrink();
    }

    return InkWell(
      onTap: () {
        cubit.removeAllFilesInFilesQuestion(
          patientId: patientId,
          sectionId: sectionId,
          questionId: questionModel.id.toString(),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Text(
          context.tr(AppStrings.removeAll),
          style: TextStyle(
            color: primary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
