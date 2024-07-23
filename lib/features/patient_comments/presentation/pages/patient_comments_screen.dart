
import '../../../../exports.dart';

class PatientCommentsScreen extends StatefulWidget {
  final String patientId;
  final DoctorModel currentDoctorModel;
  final String? patientName;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final int currentDoctorPoints;
  final String currentDoctorRole;

  const PatientCommentsScreen({
    super.key,
    required this.patientId,
    required this.currentDoctorModel,
    required this.patientName,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorPoints,
    required this.currentDoctorRole,
  });

  @override
  State<PatientCommentsScreen> createState() => _PatientCommentsScreenState();
}

class _PatientCommentsScreenState extends State<PatientCommentsScreen> {
  @override
  void initState() {
    context.read<PatientCommentsCubit>().getPatientComments(widget.patientId);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = context.read<PatientCommentsCubit>();
    if (!cubit.isClosed && cubit.scrollController.hasClients) {
      cubit.scrollController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    PatientCommentsCubit cubit = PatientCommentsCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patientName ?? ''),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            controller: cubit.scrollController,
            child: PatientComments(
              cubit: cubit,
              currentDoctorModel: widget.currentDoctorModel,
              accountVerification: widget.accountVerification,
              patientId: widget.patientId,
              currentDoctorPoints: widget.currentDoctorPoints,
              currentDoctorRole: widget.currentDoctorRole,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: WriteCommentField(
              cubit: cubit,
              accountVerification: widget.accountVerification,
              currentDoctorModel: widget.currentDoctorModel,
              patientId: widget.patientId,
              isSyndicateCardRequired: widget.isSyndicateCardRequired,
            ),
          ),
        ],
      ),
    );
  }
}
