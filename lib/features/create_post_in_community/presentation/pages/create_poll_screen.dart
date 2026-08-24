import 'dart:math' as math;

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../exports.dart';

class CreatePollScreen extends StatefulWidget {
  final Function(PollModel) onPollCreated;
  final int initialOptionCount;
  final PollModel? existingPoll;

  const CreatePollScreen({
    super.key,
    required this.onPollCreated,
    this.initialOptionCount = 2,
    this.existingPoll,
  });

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  bool _allowMultipleChoices = false;
  bool _allowAddOptions = false;
  late final AnimationController _enterCtrl;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideIn;

  bool get _isEditing => widget.existingPoll != null;

  @override
  void initState() {
    super.initState();
    if (widget.existingPoll != null) {
      _questionController.text = widget.existingPoll!.question ?? '';
      _allowMultipleChoices =
          widget.existingPoll!.allowMultipleChoices ?? false;
      _allowAddOptions = widget.existingPoll!.allowAddOptions ?? false;
      for (final option in widget.existingPoll!.options ?? []) {
        _optionControllers.add(TextEditingController(text: option));
      }
    } else {
      for (int i = 0; i < widget.initialOptionCount; i++) {
        _optionControllers.add(TextEditingController());
      }
    }

    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _fadeIn = CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutCubic);
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutCubic));
    _enterCtrl.forward();
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    _enterCtrl.dispose();
    super.dispose();
  }

  void _addOption() {
    if (_optionControllers.length >= 6) return;
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    if (index < 0 || index >= _optionControllers.length) return;
    if (_optionControllers.length <= 2) return;
    setState(() {
      _optionControllers.removeAt(index).dispose();
    });
  }

  void _submitPoll() {
    if (!_formKey.currentState!.validate()) return;

    final poll = PollModel(
      question: _questionController.text,
      options: _optionControllers.map((controller) => controller.text).toList(),
      allowMultipleChoices: _allowMultipleChoices,
      allowAddOptions: _allowAddOptions,
    );

    widget.onPollCreated(poll);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final palette = _PollPalette(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent)
              : SystemUiOverlayStyle.dark
                  .copyWith(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: palette.canvas,
            body: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                final fullHeight = MediaQuery.sizeOf(context).height;
                return Stack(
                  children: [
                    // Keep glow blobs anchored to the full screen
                    // so keyboard insets don't push them upward.
                    Positioned.fill(
                      child: IgnorePointer(
                        child: OverflowBox(
                          maxHeight: fullHeight,
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: fullHeight,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -80.h,
                                  right: -60.w,
                                  child: Container(
                                    width: 240.w,
                                    height: 240.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          palette.glow.withOpacity(
                                            isDark ? 0.32 : 0.18,
                                          ),
                                          palette.glow.withOpacity(0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: fullHeight * 0.48,
                                  left: -80.w,
                                  child: Container(
                                    width: 200.w,
                                    height: 200.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          palette.glowAlt.withOpacity(
                                            isDark ? 0.2 : 0.1,
                                          ),
                                          palette.glowAlt.withOpacity(0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        _PollTopBar(
                          palette: palette,
                          isEditing: _isEditing,
                          onBack: () => Navigator.of(context).maybePop(),
                        ),
                        Expanded(
                          child: FadeTransition(
                            opacity: _fadeIn,
                            child: SlideTransition(
                              position: _slideIn,
                              child: Form(
                                key: _formKey,
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(
                                    18.w,
                                    4.h,
                                    18.w,
                                    20.h,
                                  ),
                                  children: [
                                    _PollIntroChip(
                                      palette: palette,
                                      isEditing: _isEditing,
                                    ),
                                    SizedBox(height: 14.h),
                                    _SectionLabel(
                                      palette: palette,
                                      title: context
                                          .tr(AppStrings.askAQuestion)
                                          .toUpperCase(),
                                    ),
                                    SizedBox(height: 6.h),
                                    _QuestionSheet(
                                      palette: palette,
                                      controller: _questionController,
                                      hint: context.tr(AppStrings.askAQuestion),
                                    ),
                                    SizedBox(height: 14.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _SectionLabel(
                                            palette: palette,
                                            title: context
                                                .tr(AppStrings.options)
                                                .toUpperCase(),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 3.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: palette.accent
                                                .withOpacity(0.12),
                                            borderRadius:
                                                BorderRadius.circular(999),
                                          ),
                                          child: Text(
                                            '${_optionControllers.length} / 6',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: palette.accent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    ...List.generate(
                                      _optionControllers.length,
                                      (index) => Padding(
                                        key: ValueKey(
                                          _optionControllers[index],
                                        ),
                                        padding: EdgeInsets.only(bottom: 6.h),
                                        child: _OptionRow(
                                          palette: palette,
                                          index: index,
                                          controller: _optionControllers[index],
                                          canRemove:
                                              _optionControllers.length > 2,
                                          onRemove: () => _removeOption(index),
                                          optionLabel:
                                              '${context.tr(AppStrings.option)} ${index + 1}',
                                          validatorMessage: context.tr(
                                            AppStrings.pleaseEnterAnOption,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_optionControllers.length < 6)
                                      _AddOptionButton(
                                        palette: palette,
                                        label:
                                            '+ ${context.tr(AppStrings.addAnotherOption)}',
                                        onTap: _addOption,
                                      ),
                                    SizedBox(height: 14.h),
                                    _SectionLabel(
                                      palette: palette,
                                      title: context
                                          .tr(AppStrings.settings)
                                          .toUpperCase(),
                                    ),
                                    SizedBox(height: 6.h),
                                    _SettingsCard(
                                      palette: palette,
                                      children: [
                                        _SettingToggle(
                                          palette: palette,
                                          icon: Icons.add_circle_outline,
                                          title: context
                                              .tr(AppStrings.allowAddOptions),
                                          value: _allowAddOptions,
                                          onChanged: (value) {
                                            setState(
                                              () => _allowAddOptions = value,
                                            );
                                          },
                                        ),
                                        Divider(
                                          height: 1,
                                          color: palette.line.withOpacity(0.7),
                                        ),
                                        _SettingToggle(
                                          palette: palette,
                                          icon: Icons.check_box_outlined,
                                          title: context.tr(
                                            AppStrings.allowMultipleChoices,
                                          ),
                                          value: _allowMultipleChoices,
                                          onChanged: (value) {
                                            setState(
                                              () =>
                                                  _allowMultipleChoices = value,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (!isKeyboardVisible)
                          _PollDock(
                            palette: palette,
                            isEditing: _isEditing,
                            onSubmit: _submitPoll,
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _PollPalette {
  final bool isDark;

  const _PollPalette(this.isDark);

  Color get canvas => isDark ? AppColors.darkScaffoldBG : AppColors.scaffoldBG;
  Color get sheet => isDark ? AppColors.darkCardBG : AppColors.white;
  Color get ink => isDark ? AppColors.darkTitle : AppColors.title;
  Color get muted => isDark ? AppColors.darkDescription : AppColors.description;
  Color get line =>
      isDark ? AppColors.darkBorder : AppColors.primary.withOpacity(0.14);
  Color get glow => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get glowAlt => isDark ? AppColors.primary : AppColors.darkPrimary;
  Color get accent => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get cta => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get toolBg => isDark ? AppColors.darkSurface : AppColors.subBG;
}

class _PollTopBar extends StatelessWidget {
  final _PollPalette palette;
  final bool isEditing;
  final VoidCallback onBack;

  const _PollTopBar({
    required this.palette,
    required this.isEditing,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 6.h, 18.w, 8.h),
        child: Row(
          children: [
            Material(
              color: palette.sheet.withOpacity(0.9),
              shape: const CircleBorder(),
              elevation: palette.isDark ? 0 : 1.5,
              shadowColor: Colors.black26,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onBack,
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: palette.ink,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditing
                        ? context.tr(AppStrings.editPollUpper)
                        : context.tr(AppStrings.newPollUpper),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                      color: palette.accent,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    context.tr(AppStrings.createPoll),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                      color: palette.ink,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PollIntroChip extends StatelessWidget {
  final _PollPalette palette;
  final bool isEditing;

  const _PollIntroChip({
    required this.palette,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            palette.accent.withOpacity(palette.isDark ? 0.22 : 0.14),
            palette.sheet,
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: palette.line.withOpacity(0.8)),
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: palette.accent.withOpacity(0.16),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.how_to_vote_rounded,
              size: 17.sp,
              color: palette.accent,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEditing
                      ? context.tr(AppStrings.refineYourBallot)
                      : context.tr(AppStrings.buildAQuickBallot),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: palette.ink,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Short question · clear options · ready to publish',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: palette.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final _PollPalette palette;
  final String title;

  const _SectionLabel({
    required this.palette,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
            color: palette.muted,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            height: 1,
            color: palette.line.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class _QuestionSheet extends StatelessWidget {
  final _PollPalette palette;
  final TextEditingController controller;
  final String hint;

  const _QuestionSheet({
    required this.palette,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44.h,
      decoration: BoxDecoration(
        color: palette.sheet,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: palette.line.withOpacity(0.75)),
      ),
      child: Row(
        children: [
          Container(
            width: 3.w,
            margin: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: palette.accent,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          SizedBox(width: 10.w),
          Icon(
            Icons.help_outline_rounded,
            size: 15.sp,
            color: palette.accent,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              maxLength: 200,
              maxLines: 1,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              style: TextStyle(
                color: palette.ink,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: palette.muted.withOpacity(0.9),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                counterText: '',
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              validator: (_) => null,
            ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  final _PollPalette palette;
  final int index;
  final TextEditingController controller;
  final bool canRemove;
  final VoidCallback onRemove;
  final String optionLabel;
  final String validatorMessage;

  const _OptionRow({
    required this.palette,
    required this.index,
    required this.controller,
    required this.canRemove,
    required this.onRemove,
    required this.optionLabel,
    required this.validatorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 40.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: palette.sheet,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: palette.line.withOpacity(0.75)),
      ),
      child: Row(
        children: [
          Container(
            width: 22.w,
            height: 22.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  palette.accent,
                  palette.accent.withOpacity(0.7),
                ],
              ),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextFormField(
              key: ValueKey('option_$index'),
              controller: controller,
              maxLines: 1,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              style: TextStyle(
                color: palette.ink,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: optionLabel,
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: palette.muted,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                isDense: true,
                errorStyle: TextStyle(fontSize: 9.sp, height: 0.9),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validatorMessage;
                }
                return null;
              },
            ),
          ),
          if (canRemove)
            InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.close_rounded,
                  size: 15.sp,
                  color: palette.muted,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddOptionButton extends StatelessWidget {
  final _PollPalette palette;
  final String label;
  final VoidCallback onTap;

  const _AddOptionButton({
    required this.palette,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: palette.accent.withOpacity(0.45),
            radius: 12.r,
          ),
          child: Container(
            width: double.infinity,
            height: 38.h,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded, size: 15.sp, color: palette.accent),
                SizedBox(width: 5.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    color: palette.accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1),
          Radius.circular(radius),
        ),
      );

    const dashWidth = 5.0;
    const dashSpace = 3.5;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = math.min(distance + dashWidth, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}

class _SettingsCard extends StatelessWidget {
  final _PollPalette palette;
  final List<Widget> children;

  const _SettingsCard({
    required this.palette,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: palette.sheet,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: palette.line.withOpacity(0.7)),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingToggle extends StatelessWidget {
  final _PollPalette palette;
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingToggle({
    required this.palette,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: Row(
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: palette.accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 14.sp, color: palette.accent),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: palette.ink,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch.adaptive(
              value: value,
              activeColor: palette.accent,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _PollDock extends StatelessWidget {
  final _PollPalette palette;
  final bool isEditing;
  final VoidCallback onSubmit;

  const _PollDock({
    required this.palette,
    required this.isEditing,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: palette.sheet.withOpacity(0.96),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
        border: Border(
          top: BorderSide(color: palette.line.withOpacity(0.8)),
        ),
        boxShadow: palette.isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: 10.h),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
          child: SizedBox(
            width: double.infinity,
            height: 40.h,
            child: Material(
              color: palette.cta,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                onTap: onSubmit,
                borderRadius: BorderRadius.circular(12.r),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        isEditing
                            ? context.tr(AppStrings.save)
                            : context.tr(AppStrings.createPoll),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
