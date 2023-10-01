import '../../../app/shared_widgets/custom_loading.dart';
import '../../../exports.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primary,
      ),
      body: const ShimmerLoadingPatientsCards(),
    );
  }
}
