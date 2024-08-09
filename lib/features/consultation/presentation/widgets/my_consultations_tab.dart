import 'package:egy_akin/features/consultation/presentation/cubit/consultation_cubit.dart';

import '../../../../exports.dart';

class MyConsultationsTab extends StatefulWidget {
  const MyConsultationsTab({super.key});

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
    return const Scaffold();
  }
}
