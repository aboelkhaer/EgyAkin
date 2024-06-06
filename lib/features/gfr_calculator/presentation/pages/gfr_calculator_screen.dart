import '../../../../exports.dart';

class GfrCalculatorScreen extends StatelessWidget {
  const GfrCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GfrCalculatorCubit cubit = GfrCalculatorCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GFR Calculator'),
      ),
      body: const Center(
        child: Icon(
          Icons.medical_services,
          size: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}
