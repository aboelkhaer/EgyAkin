import 'package:egy_akin/features/consultation/presentation/widgets/consultation_list.dart';

import '../../../../exports.dart';

class MyConsultationsTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const MyConsultationsTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<MyConsultationsTab> createState() => _MyConsultationsTabState();
}

class _MyConsultationsTabState extends State<MyConsultationsTab> {
  @override
  void initState() {
    super.initState();
    context.read<ConsultationCubit>().getCurrentDoctorConsultations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultationCubit, ConsultationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox.shrink();
          },
          myConsultationsLoading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          myConsultationsLoaded: (consultations) {
            return ConsultationList(
              consultations: consultations,
              currentDoctorModel: widget.currentDoctorModel,
              homeDataModel: widget.homeDataModel,
              isReceivedConsultation: false,
            );
          },
        );
      },
    );
  }
}
