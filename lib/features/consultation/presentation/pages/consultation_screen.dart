import '../../../../exports.dart';

class ConsultationScreen extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  const ConsultationScreen(
      {super.key,
      required this.homeDataModel,
      required this.currentDoctorModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ColoredBox(
              color: AppColors.primary.withOpacity(0.2),
              child: TabBar(
                labelColor: AppColors.primary,
                // indicatorColor: Colors.white,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 3,
                  ),
                ),
                isScrollable: false,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey.shade500,
                tabs: const [
                  Tab(
                    text: 'My Consultations',
                  ),
                  Tab(
                    text: 'Received',
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  MyConsultationsTab(),
                  ReceivedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
