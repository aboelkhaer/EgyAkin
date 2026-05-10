import 'dart:io';

import '../../../../exports.dart';
import '../cubit/ai_form_upload_cubit.dart';
import '../cubit/ai_form_upload_state.dart';

class AiFormUploadScreen extends StatefulWidget {
  final String sectionId;

  const AiFormUploadScreen({
    super.key,
    required this.sectionId,
  });

  @override
  State<AiFormUploadScreen> createState() => _AiFormUploadScreenState();
}

class _AiFormUploadScreenState extends State<AiFormUploadScreen> {
  final Set<String> _removingImagePaths = {};
  final Set<String> _removingFilePaths = {};

  Future<void> _animateRemoveImage({
    required File file,
    required int index,
    required AiFormUploadCubit cubit,
  }) async {
    setState(() => _removingImagePaths.add(file.path));
    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!mounted) return;
    cubit.clearImageAt(index);
    setState(() => _removingImagePaths.remove(file.path));
  }

  Future<void> _animateRemoveFile({
    required File file,
    required int index,
    required AiFormUploadCubit cubit,
  }) async {
    setState(() => _removingFilePaths.add(file.path));
    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!mounted) return;
    cubit.clearFileAt(index);
    setState(() => _removingFilePaths.remove(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AiFormUploadCubit>(),
      child: BlocConsumer<AiFormUploadCubit, AiFormUploadState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            customSnackBar(context: context, message: state.errorMessage);
          }
          if (state.answersMap != null) {
            Navigator.of(context).pop(
              Map<String, dynamic>.from(state.answersMap!),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AiFormUploadCubit>();
          final isDarkMode = context.watch<ThemeBloc>().state is ThemeLoaded &&
              (context.watch<ThemeBloc>().state as ThemeLoaded).isDarkMode;
          return Scaffold(
            backgroundColor:
                isDarkMode ? AppColors.darkScaffoldBG : const Color(0xFFF7FAFF),
            appBar: AppBar(
              title: const Text('AI Image Analysis'),
              centerTitle: true,
              backgroundColor:
                  isDarkMode ? AppColors.darkCardBG : AppColors.primary,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode
                            ? AppColors.darkBorder
                            : AppColors.primary.withOpacity(0.16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload content for AI analysis',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Add images and supporting files, then analyze to fill this section automatically.',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode
                                ? AppColors.darkDescription
                                : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _PickerButton(
                                icon: Icons.photo_library_outlined,
                                label: state.isPickingImages
                                    ? 'Loading...'
                                    : 'Add Images',
                                isLoading: state.isPickingImages,
                                onPressed: state.isPickingImages
                                    ? null
                                    : cubit.pickImages,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _PickerButton(
                                icon: Icons.attach_file,
                                label: state.isPickingFiles
                                    ? 'Loading...'
                                    : 'Add Files',
                                isLoading: state.isPickingFiles,
                                onPressed: state.isPickingFiles
                                    ? null
                                    : cubit.pickFiles,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        if (state.selectedImages.isNotEmpty) ...[
                          Text(
                            'Images (${state.selectedImages.length})',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: isDarkMode
                                  ? AppColors.darkTitle
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GridView.builder(
                            itemCount: state.selectedImages.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, i) {
                              final file = state.selectedImages[i];
                              return _ImagePreviewCard(
                                key: ValueKey(file.path),
                                file: file,
                                isRemoving:
                                    _removingImagePaths.contains(file.path),
                                onRemove: () => _animateRemoveImage(
                                  file: file,
                                  index: i,
                                  cubit: cubit,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 14),
                        ],
                        if (state.selectedFiles.isNotEmpty) ...[
                          Text(
                            'Files (${state.selectedFiles.length})',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: isDarkMode
                                  ? AppColors.darkTitle
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...List.generate(state.selectedFiles.length, (i) {
                            final file = state.selectedFiles[i];
                            return _SelectedFileTile(
                              key: ValueKey(file.path),
                              file: file,
                              isRemoving:
                                  _removingFilePaths.contains(file.path),
                              onRemove: () => _animateRemoveFile(
                                file: file,
                                index: i,
                                cubit: cubit,
                              ),
                              isDarkMode: isDarkMode,
                            );
                          }),
                        ],
                        if (!state.hasSelection)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 34,
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : Colors.black38,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No images or files selected yet.',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppColors.darkDescription
                                          : Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (state.isSubmitting) ...[
                    _AnalysisProgressCard(
                      stepLabel: state.loadingStep,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 10),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: _AnalyzeActionButton(
                      isDarkMode: isDarkMode,
                      isSubmitting: state.isSubmitting,
                      isEnabled: state.hasSelection,
                      onTap: () => cubit.submit(widget.sectionId),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SelectedFileTile extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;
  final bool isDarkMode;
  final bool isRemoving;

  const _SelectedFileTile({
    super.key,
    required this.file,
    required this.onRemove,
    required this.isDarkMode,
    required this.isRemoving,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = file.path.split(Platform.pathSeparator).last;
    final extension = fileName.contains('.')
        ? fileName.split('.').last.toUpperCase()
        : 'FILE';
    final fileSizeKb = (file.lengthSync() / 1024);
    final fileSizeLabel = fileSizeKb >= 1024
        ? '${(fileSizeKb / 1024).toStringAsFixed(2)} MB'
        : '${fileSizeKb.toStringAsFixed(0)} KB';

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: isRemoving ? 0 : 1,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 220),
            scale: isRemoving ? 0.86 : scale,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDarkMode ? AppColors.darkCardBG : Colors.white,
          border: Border.all(
            color: isDarkMode
                ? AppColors.darkBorder
                : AppColors.primary.withOpacity(0.18),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                extension,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? AppColors.darkTitle : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    fileSizeLabel,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDarkMode
                          ? AppColors.darkDescription
                          : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.close,
                size: 18,
                color: isDarkMode ? AppColors.darkDescription : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePreviewCard extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;
  final bool isRemoving;

  const _ImagePreviewCard({
    super.key,
    required this.file,
    required this.onRemove,
    required this.isRemoving,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.86, end: 1),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: isRemoving ? 0 : 1,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 220),
            scale: isRemoving ? 0.78 : scale,
            child: child,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              file,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.black12,
                child: const Icon(Icons.broken_image_outlined),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  const _PickerButton({
    required this.icon,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class _AnalyzeActionButton extends StatelessWidget {
  final bool isDarkMode;
  final bool isSubmitting;
  final bool isEnabled;
  final VoidCallback onTap;

  const _AnalyzeActionButton({
    required this.isDarkMode,
    required this.isSubmitting,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (!isSubmitting && isEnabled) ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: (!isEnabled || isSubmitting)
                ? [
                    Colors.grey.shade500,
                    Colors.grey.shade400,
                  ]
                : [
                    AppColors.primary,
                    const Color(0xFF5A8BFF),
                  ],
          ),
          boxShadow: (!isEnabled || isSubmitting)
              ? []
              : [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isSubmitting
                ? const Row(
                    key: ValueKey('loading'),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.1,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Analyzing...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                : const Row(
                    key: ValueKey('ready'),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Analyze and Fill Form',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
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

class _AnalysisProgressCard extends StatelessWidget {
  final String stepLabel;
  final bool isDarkMode;

  const _AnalysisProgressCard({
    required this.stepLabel,
    required this.isDarkMode,
  });

  int get _activeStep {
    final s = stepLabel.toLowerCase();
    if (s.contains('fill')) return 3;
    if (s.contains('analyz')) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCardBG : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDarkMode
              ? AppColors.darkBorder
              : AppColors.primary.withOpacity(0.16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  stepLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.darkTitle : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _StepLine(
            title: '1. Uploading files',
            done: _activeStep > 1,
            active: _activeStep == 1,
          ),
          const SizedBox(height: 6),
          _StepLine(
            title: '2. AI analyzing content',
            done: _activeStep > 2,
            active: _activeStep == 2,
          ),
          const SizedBox(height: 6),
          _StepLine(
            title: '3. Filling form fields',
            done: _activeStep > 3,
            active: _activeStep == 3,
          ),
        ],
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  final String title;
  final bool done;
  final bool active;

  const _StepLine({
    required this.title,
    required this.done,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final color = done
        ? Colors.green
        : active
            ? AppColors.primary
            : Colors.grey;
    return Row(
      children: [
        Icon(
          done
              ? Icons.check_circle
              : active
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 12.5,
            fontWeight: active || done ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
