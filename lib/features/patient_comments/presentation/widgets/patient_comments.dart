import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/patient_comments/presentation/widgets/patient_comment_card.dart';
import 'package:egy_akin/features/patient_comments/presentation/widgets/patient_comments_loading.dart';

import '../../../../exports.dart';

class PatientComments extends StatefulWidget {
  final PatientCommentsCubit cubit;
  final bool isDark;
  final bool accountVerification;
  final String patientId;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const PatientComments({
    super.key,
    required this.cubit,
    required this.isDark,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.patientId,
    required this.currentDoctorPoints,
    required this.currentDoctorRole,
    required this.homeDataModel,
  });

  @override
  State<PatientComments> createState() => _PatientCommentsState();
}

class _PatientCommentsState extends State<PatientComments> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<CommentModel> _items = [];
  bool _seeded = false;

  static const _animDuration = Duration(milliseconds: 340);

  void _syncComments(List<CommentModel> next) {
    final listState = _listKey.currentState;
    final nextIds = next.map((e) => e.id).toSet();

    for (var i = _items.length - 1; i >= 0; i--) {
      if (!nextIds.contains(_items[i].id)) {
        final removed = _items.removeAt(i);
        if (listState != null) {
          listState.removeItem(
            i,
            (context, animation) => _buildAnimatedTile(
              comment: removed,
              index: i,
              animation: animation,
              removing: true,
              totalCount: _items.length,
            ),
            duration: _animDuration,
          );
        }
      }
    }

    for (var i = 0; i < next.length; i++) {
      final comment = next[i];
      final existingIndex = _items.indexWhere((e) => e.id == comment.id);
      if (existingIndex == -1) {
        final insertAt = i.clamp(0, _items.length);
        _items.insert(insertAt, comment);
        listState?.insertItem(insertAt, duration: _animDuration);
      }
    }
  }

  Widget _buildAnimatedTile({
    required CommentModel comment,
    required int index,
    required Animation<double> animation,
    required bool removing,
    required int totalCount,
  }) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: removing ? Curves.easeInCubic : Curves.easeOutCubic,
    );
    final isMine = comment.doctor?.id?.toString() ==
        widget.currentDoctorModel.id.toString();

    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ),
      axisAlignment: -1,
      child: FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: removing ? const Offset(0.12, 0) : const Offset(0, 0.18),
            end: Offset.zero,
          ).animate(curved),
          child: ScaleTransition(
            scale: Tween<double>(begin: removing ? 0.96 : 0.92, end: 1)
                .animate(curved),
            child: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: PatientCommentCard(
                isDark: widget.isDark,
                commentModel: comment,
                currentDoctorModel: widget.currentDoctorModel,
                currentDoctorRole: widget.currentDoctorRole,
                homeDataModel: widget.homeDataModel,
                isMine: isMine,
                showConnector: index < totalCount - 1,
                onDelete: () {
                  widget.cubit.deletePatientComment(comment.id.toString());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCommentsCubit, PatientCommentsState>(
      listenWhen: (previous, current) {
        final prevIds = previous.maybeWhen(
          loaded: (comments, _, __, ___, ____) =>
              comments.map((e) => e.id).join(','),
          orElse: () => '',
        );
        final nextIds = current.maybeWhen(
          loaded: (comments, _, __, ___, ____) =>
              comments.map((e) => e.id).join(','),
          orElse: () => '',
        );
        return prevIds != nextIds ||
            current.maybeWhen(error: (_) => true, orElse: () => false);
      },
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            customSnackBar(context: context, message: message);
          },
          loaded: (comments, _, __, ___, ____) {
            if (!_seeded) return;
            _syncComments(comments);
            if (mounted) setState(() {});
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => PatientCommentsLoadingList(isDark: widget.isDark),
          error: (message) => Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 36.sp,
                    color: HomeDashboardColors.danger,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    context.tr(AppStrings.somethingWentWrong),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: HomeDashboardColors.title(widget.isDark),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: HomeDashboardColors.subtitle(widget.isDark),
                    ),
                  ),
                ],
              ),
            ),
          ),
          loaded: (
            comments,
            newCommentValue,
            isLoading,
            isCommentSuccess,
            message,
          ) {
            if (!_seeded) {
              _items
                ..clear()
                ..addAll(comments);
              _seeded = true;
            }

            return PermissionGuard(
              permission: AppPermissions.viewPatientComments,
              fallback: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Text(
                    context.tr(
                      AppStrings.youDontHavePermissionToViewPatientComments,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: HomeDashboardColors.subtitle(widget.isDark),
                    ),
                  ),
                ),
              ),
              child: Stack(
                children: [
                  AnimatedList(
                    key: _listKey,
                    controller: widget.cubit.patientCommentsScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 20.h),
                    initialItemCount: _items.length,
                    itemBuilder: (context, index, animation) {
                      if (index < 0 || index >= _items.length) {
                        return const SizedBox.shrink();
                      }
                      return _buildAnimatedTile(
                        comment: _items[index],
                        index: index,
                        animation: animation,
                        removing: false,
                        totalCount: _items.length,
                      );
                    },
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 220),
                    opacity: _items.isEmpty ? 1 : 0,
                    child: IgnorePointer(
                      ignoring: _items.isNotEmpty,
                      child: PatientCommentsEmptyState(isDark: widget.isDark),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
