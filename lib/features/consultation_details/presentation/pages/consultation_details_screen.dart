import 'package:egy_akin/features/consultation_details/presentation/cubit/consultation_details_cubit.dart';

import '../../../../exports.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  final String consultationId;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const ConsultationDetailsScreen(
      {super.key,
      required this.consultationId,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  State<ConsultationDetailsScreen> createState() =>
      _ConsultationDetailsScreenState();
}

class _ConsultationDetailsScreenState extends State<ConsultationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ConsultationDetailsCubit>()
        .getConsultationDetails(widget.consultationId);
  }

  @override
  Widget build(BuildContext context) {
    ConsultationDetailsCubit cubit = ConsultationDetailsCubit.get(context);

    return const Scaffold();
  }
}
