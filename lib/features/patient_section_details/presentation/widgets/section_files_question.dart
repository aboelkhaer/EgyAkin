import 'package:egy_akin/features/patient_section_details/presentation/utils/patient_section_file_utils.dart';
import 'package:flutter/scheduler.dart';

import '../../../../exports.dart';

class SectionFilesQuestion extends StatefulWidget {
  final int questionIndex;
  final String patientId;
  final String sectionId;
  final bool isDark;

  const SectionFilesQuestion({
    super.key,
    required this.questionIndex,
    required this.patientId,
    required this.sectionId,
    required this.isDark,
  });

  @override
  State<SectionFilesQuestion> createState() => _SectionFilesQuestionState();
}

class _SectionFilesQuestionState extends State<SectionFilesQuestion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get _primary =>
      widget.isDark ? AppColors.darkPrimary : AppColors.primary;

  Color get _title =>
      widget.isDark ? Colors.white : const Color(0xFF111827);

  Color get _muted =>
      widget.isDark ? Colors.white54 : const Color(0xFF6B7280);

  Color get _surface =>
      widget.isDark ? const Color(0xFF2A2A2E) : const Color(0xFFF8F7FC);

  List<dynamic> _filesFor(PatientSectionDetailsCubit cubit) {
    final qid = cubit.questionModelList[widget.questionIndex].id.toString();
    final formEntry = cubit.formData[qid];
    if (formEntry is List && formEntry.isNotEmpty) {
      return List<dynamic>.from(formEntry);
    }

    final answer = cubit.questionModelList[widget.questionIndex].answer;
    if (answer is List && answer.isNotEmpty) {
      return List<dynamic>.from(answer);
    }
    return const [];
  }

  String _nameFor(dynamic file) {
    if (file is String) {
      if (isRemoteFileUrl(file)) {
        return Uri.tryParse(file)?.pathSegments.lastOrNull ??
            file.split('/').last;
      }
      return file.split('/').last;
    }
    if (file is Map) {
      final map = Map<String, dynamic>.from(
        file.map((k, v) => MapEntry(k.toString(), v)),
      );
      return fileDisplayName(map);
    }
    return 'file';
  }

  Future<void> _openFile(BuildContext context, dynamic file) async {
    if (file is String && isRemoteFileUrl(file)) {
      await launchURL(
        url: file,
        onError: (error) => showErrorDialog(context, error),
      );
      return;
    }
    if (file is Map) {
      final map = Map<String, dynamic>.from(
        file.map((k, v) => MapEntry(k.toString(), v)),
      );
      await openPatientSectionFile(context, map);
    }
  }

  IconData _iconForName(String name) {
    final lower = name.toLowerCase();
    if (lower.endsWith('.pdf')) return Icons.picture_as_pdf_rounded;
    if (lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.heic')) {
      return Icons.image_rounded;
    }
    if (lower.endsWith('.doc') || lower.endsWith('.docx')) {
      return Icons.description_rounded;
    }
    return Icons.insert_drive_file_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = PatientSectionDetailsCubit.get(context);

    return BlocConsumer<PatientSectionDetailsCubit, PatientSectionDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            customSnackBar(context: context, message: message);
          },
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
            if (message.isNotEmpty) {
              customSnackBar(context: context, message: message);
            }
          },
        );
      },
      builder: (context, state) {
        final isChoosingFiles = state.maybeWhen(
          loaded: (
            _,
            __,
            ___,
            ____,
            _____,
            isChooseFilesLoading,
            ______,
            _______,
            ________,
            _________,
            __________,
            ___________,
            ____________,
            _____________,
            ______________,
          ) =>
              isChooseFilesLoading &&
              cubit.questionIndexWhichDoctorClicked ==
                  widget.questionIndex.toString(),
          orElse: () => false,
        );

        final files = _filesFor(cubit);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _UploadDropZone(
              isDark: widget.isDark,
              primary: _primary,
              title: _title,
              muted: _muted,
              surface: _surface,
              isChoosingFiles: isChoosingFiles,
              pulse: _pulse,
              hasFiles: files.isNotEmpty,
              onTap: isChoosingFiles
                  ? null
                  : () {
                      cubit.questionIndexWhichDoctorClicked =
                          widget.questionIndex.toString();
                      cubit.pickFilesForQuestions(
                        widget.questionIndex,
                        widget.patientId,
                        widget.sectionId,
                        context,
                      );
                    },
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: files.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Column(
                        children: List.generate(files.length, (index) {
                          final file = files[index];
                          final name = _nameFor(file);
                          return _FileTile(
                            key: ValueKey('file-$index-$name'),
                            index: index,
                            name: name,
                            isDark: widget.isDark,
                            primary: _primary,
                            title: _title,
                            muted: _muted,
                            icon: _iconForName(name),
                            onOpen: () => _openFile(context, file),
                          );
                        }),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _UploadDropZone extends StatefulWidget {
  final bool isDark;
  final Color primary;
  final Color title;
  final Color muted;
  final Color surface;
  final bool isChoosingFiles;
  final Animation<double> pulse;
  final bool hasFiles;
  final VoidCallback? onTap;

  const _UploadDropZone({
    required this.isDark,
    required this.primary,
    required this.title,
    required this.muted,
    required this.surface,
    required this.isChoosingFiles,
    required this.pulse,
    required this.hasFiles,
    required this.onTap,
  });

  @override
  State<_UploadDropZone> createState() => _UploadDropZoneState();
}

class _UploadDropZoneState extends State<_UploadDropZone> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap == null
          ? null
          : (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: widget.isChoosingFiles
                ? widget.primary.withOpacity(widget.isDark ? 0.14 : 0.08)
                : widget.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: widget.isChoosingFiles
                  ? widget.primary.withOpacity(0.7)
                  : widget.primary.withOpacity(0.35),
              width: 1.2,
            ),
          ),
          child: CustomPaint(
            painter: _DashedBorderPainter(
              color: widget.primary
                  .withOpacity(widget.isChoosingFiles ? 0.0 : 0.28),
              radius: 15.r,
            ),
            child: Row(
              children: [
                ScaleTransition(
                  scale: widget.isChoosingFiles
                      ? const AlwaysStoppedAnimation(1)
                      : widget.pulse,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: widget.primary.withOpacity(
                        widget.isDark ? 0.22 : 0.12,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: widget.isChoosingFiles
                        ? Padding(
                            padding: EdgeInsets.all(12.w),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: widget.primary,
                            ),
                          )
                        : Icon(
                            widget.hasFiles
                                ? Icons.add_rounded
                                : Icons.cloud_upload_rounded,
                            color: widget.primary,
                            size: 22.sp,
                          ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        child: Text(
                          widget.isChoosingFiles
                              ? context.tr(AppStrings.choosingFiles)
                              : (widget.hasFiles
                                  ? context.tr(AppStrings.addMoreFiles)
                                  : context.tr(AppStrings.tapToUploadFiles)),
                          key: ValueKey(
                            '${widget.isChoosingFiles}-${widget.hasFiles}',
                          ),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: widget.title,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: [
                          _LimitChip(
                            label: context.tr(AppStrings.max5MbTotal),
                            isDark: widget.isDark,
                            primary: widget.primary,
                          ),
                          _LimitChip(
                            label: '2MB / file',
                            isDark: widget.isDark,
                            primary: widget.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!widget.isChoosingFiles)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: widget.muted,
                    size: 20.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LimitChip extends StatelessWidget {
  final String label;
  final bool isDark;
  final Color primary;

  const _LimitChip({
    required this.label,
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: primary.withOpacity(isDark ? 0.16 : 0.08),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
      ),
    );
  }
}

class _FileTile extends StatefulWidget {
  final int index;
  final String name;
  final bool isDark;
  final Color primary;
  final Color title;
  final Color muted;
  final IconData icon;
  final VoidCallback onOpen;

  const _FileTile({
    super.key,
    required this.index,
    required this.name,
    required this.isDark,
    required this.primary,
    required this.title,
    required this.muted,
    required this.icon,
    required this.onOpen,
  });

  @override
  State<_FileTile> createState() => _FileTileState();
}

class _FileTileState extends State<_FileTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 320 + (widget.index * 40).clamp(0, 200)),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onOpen,
              borderRadius: BorderRadius.circular(14.r),
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? const Color(0xFF232326)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: widget.isDark
                        ? Colors.white.withOpacity(0.06)
                        : const Color(0xFFE8E8EE),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 34.w,
                      height: 34.w,
                      decoration: BoxDecoration(
                        color: widget.primary.withOpacity(
                          widget.isDark ? 0.2 : 0.1,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 16.sp,
                        color: widget.primary,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        widget.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: widget.title,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.open_in_new_rounded,
                      size: 14.sp,
                      color: widget.muted,
                    ),
                  ],
                ),
              ),
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
    if (color.opacity <= 0) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0.6, 0.6, size.width - 1.2, size.height - 1.2),
          Radius.circular(radius),
        ),
      );

    const dashWidth = 5.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
