import 'package:egy_akin/features/outcome/presentation/widgets/if_outcome_not_submitted.dart';
import 'package:egy_akin/features/outcome/presentation/widgets/if_outcome_submitted.dart';

import '../../../../exports.dart';

class OutcomeScreen extends StatefulWidget {
  final bool accountVerification;
  final bool outcomeStatus;
  final String patientName;
  final String patientId;
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final String isSyndicateCardRequired;

  const OutcomeScreen({
    super.key,
    required this.outcomeStatus,
    required this.patientName,
    required this.patientId,
    required this.accountVerification,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.isSyndicateCardRequired,
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
    OutcomeCubit cubit = OutcomeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            Flexible(
              child: Text(
                widget.patientName,
                style: TextStyle(fontSize: 14.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '\'s Outcome',
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: widget.outcomeStatus
          ? IfOutcomeSubmitted(
              cubit: cubit,
              currentDoctorId: widget.currentDoctorModel.id.toString(),
              doctorId: widget.doctorId,
            )
          : IfOutcomeNotSubmitted(
              cubit: cubit,
              outcomeStatus: widget.outcomeStatus,
              accountVerification: widget.accountVerification,
              patientId: widget.patientId,
              isSyndicateCardRequired: widget.isSyndicateCardRequired,
              currentDoctorModel: widget.currentDoctorModel,
            ),
    );
  }
}
