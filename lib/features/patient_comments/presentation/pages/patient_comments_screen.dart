import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/patient_comments/presentation/widgets/patient_comments_header.dart';

import '../../../../exports.dart';

class PatientCommentsScreen extends StatefulWidget {
  final String patientId;
  final DoctorModel currentDoctorModel;
  final String? patientName;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final int currentDoctorPoints;
  final String currentDoctorRole;
  final HomeModelResponse homeDataModel;

  const PatientCommentsScreen({
    super.key,
    required this.patientId,
    required this.currentDoctorModel,
    required this.patientName,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorPoints,
    required this.currentDoctorRole,
    required this.homeDataModel,
  });

  @override
  State<PatientCommentsScreen> createState() => _PatientCommentsScreenState();
}

class _PatientCommentsScreenState extends State<PatientCommentsScreen> {
  PatientCommentsCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PatientCommentsCubit>();
    _cubit!.getPatientComments(widget.patientId);
  }

  @override
  void dispose() {
    final controller = _cubit?.patientCommentsScrollController;
    if (_cubit != null && !_cubit!.isClosed && controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = PatientCommentsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

        return Scaffold(
          backgroundColor: HomeDashboardColors.scaffold(isDark),
          body: Stack(
            children: [
              Positioned(
                top: -40,
                right: -30,
                child: IgnorePointer(
                  child: Container(
                    width: 180.w,
                    height: 180.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          primary.withOpacity(isDark ? 0.16 : 0.1),
                          primary.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                left: -50,
                child: IgnorePointer(
                  child: Container(
                    width: 160.w,
                    height: 160.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          primary.withOpacity(isDark ? 0.1 : 0.06),
                          primary.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<PatientCommentsCubit, PatientCommentsState>(
                builder: (context, state) {
                  final commentCount = state.maybeWhen(
                    loaded: (comments, _, __, ___, ____) => comments.length,
                    orElse: () => 0,
                  );
                  final patientLabel = (widget.patientName ?? '').trim().isEmpty
                      ? context.tr(AppStrings.clinicalDiscussion)
                      : widget.patientName!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Listener(
                          behavior: HitTestBehavior.translucent,
                          onPointerDown: (_) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PatientCommentsHeader(
                                isDark: isDark,
                                title: context.tr(AppStrings.patientComments),
                                subtitle: patientLabel,
                                commentCount: commentCount,
                                onBack: () =>
                                    Navigator.of(context).maybePop(),
                              ),
                              Expanded(
                                child: PatientComments(
                                  cubit: cubit,
                                  isDark: isDark,
                                  currentDoctorModel:
                                      widget.currentDoctorModel,
                                  accountVerification:
                                      widget.accountVerification,
                                  patientId: widget.patientId,
                                  currentDoctorPoints:
                                      widget.currentDoctorPoints,
                                  currentDoctorRole:
                                      widget.currentDoctorRole,
                                  homeDataModel: widget.homeDataModel,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      WriteCommentField(
                        cubit: cubit,
                        accountVerification: widget.accountVerification,
                        currentDoctorModel: widget.currentDoctorModel,
                        patientId: widget.patientId,
                        isSyndicateCardRequired:
                            widget.isSyndicateCardRequired,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
