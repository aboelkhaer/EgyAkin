import 'package:egy_akin/features/outcome/presentation/widgets/if_outcome_not_submitted.dart';
import 'package:egy_akin/features/outcome/presentation/widgets/if_outcome_submitted.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';
import 'dart:ui' as ui;

import '../../../../exports.dart';

class OutcomeScreen extends StatefulWidget {
  final bool accountVerification;
  final bool outcomeStatus;
  final String patientName;
  final String patientId;
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;

  const OutcomeScreen({
    super.key,
    required this.outcomeStatus,
    required this.patientName,
    required this.patientId,
    required this.accountVerification,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<OutcomeScreen> createState() => _OutcomeScreenState();
}

class _OutcomeScreenState extends State<OutcomeScreen> {
  @override
  void initState() {
    context.read<OutcomeCubit>().getOutcome(widget.patientId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        OutcomeCubit cubit = OutcomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: context.currentLocale?.languageCode == 'ar'
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Tooltip(
                      message: widget.patientName,
                      child: Text(
                        (widget.currentDoctorModel.id.toString() ==
                                    widget.doctorId.toString() ||
                                widget.homeDataModel.role ==
                                    AppStrings.roleAdmin)
                            ? widget.patientName.toString()
                            : convertTextToSymbols(widget.patientName),
                        style: TextStyle(fontSize: 14.sp),
                        overflow: TextOverflow.ellipsis,
                        textDirection: RegExp(r'[\u0600-\u06FF]')
                                .hasMatch(widget.patientName)
                            ? ui.TextDirection.rtl
                            : ui.TextDirection.ltr,
                      ),
                    ),
                  ),
                  Text(
                    LocalizationService.instance.translate(AppStrings.sOutcome),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            centerTitle: true,
          ),
          body: widget.outcomeStatus
              ? IfOutcomeSubmitted(
                  cubit: cubit,
                  currentDoctorModel: widget.currentDoctorModel,
                  doctorId: widget.doctorId,
                  accountVerification: widget.accountVerification,
                  isSyndicateCardRequired: widget.isSyndicateCardRequired,
                  currentDoctorRole: widget.currentDoctorRole,
                  currentDoctorPoints: widget.currentDoctorPoints,
                  homeDataModel: widget.homeDataModel,
                )
              : IfOutcomeNotSubmitted(
                  cubit: cubit,
                  outcomeStatus: widget.outcomeStatus,
                  accountVerification: widget.accountVerification,
                  patientId: widget.patientId,
                  isSyndicateCardRequired: widget.isSyndicateCardRequired,
                  currentDoctorModel: widget.currentDoctorModel,
                  doctorId: widget.doctorId,
                  homeDataModel: widget.homeDataModel,
                ),
        );
      },
    );
  }
}
