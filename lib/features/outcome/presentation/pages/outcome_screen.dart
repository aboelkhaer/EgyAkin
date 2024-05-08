import 'package:egy_akin/features/outcome/presentation/widgets/if_outcome_not_submitted.dart';
import 'package:egy_akin/features/outcome/presentation/widgets/if_outcome_submitted.dart';

import '../../../../exports.dart';

class OutcomeScreen extends StatefulWidget {
  final bool accountVerification;
  final bool outcomeStatus;
  final String patientName;
  final String patientId;

  const OutcomeScreen({
    super.key,
    required this.outcomeStatus,
    required this.patientName,
    required this.patientId,
    required this.accountVerification,
  });

  @override
  State<OutcomeScreen> createState() => _OutcomeScreenState();
}

class _OutcomeScreenState extends State<OutcomeScreen> {
  @override
  void initState() {
    if (widget.outcomeStatus) {
      context.read<OutcomeCubit>().getOutcome(widget.patientId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OutcomeCubit cubit = OutcomeCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(widget.patientName),
        centerTitle: true,
      ),
      body: widget.outcomeStatus
          ? IfOutcomeSubmitted(cubit: cubit)
          : IfOutcomeNotSubmitted(
              cubit: cubit,
              outcomeStatus: widget.outcomeStatus,
              accountVerification: widget.accountVerification,
              patientId: widget.patientId,
            ),
    );
  }
}
