import 'package:egy_akin/features/consultation/presentation/cubit/consultation_cubit.dart';

import '../../../../exports.dart';

class ReceivedTab extends StatefulWidget {
  const ReceivedTab({super.key});

  @override
  State<ReceivedTab> createState() => _ReceivedTabState();
}

class _ReceivedTabState extends State<ReceivedTab> {
  @override
  void initState() {
    super.initState();
    context.read<ConsultationCubit>().getReceivedConsultations();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
