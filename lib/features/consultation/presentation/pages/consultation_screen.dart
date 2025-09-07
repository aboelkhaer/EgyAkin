import '../../../../exports.dart';

class ConsultationScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final int initialTab;
  const ConsultationScreen(
      {super.key,
      required this.homeDataModel,
      required this.currentDoctorModel,
      required this.initialTab});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(AppStrings.consultation)),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: widget.initialTab,
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
                tabs: [
                  Tab(
                    text: context.tr(AppStrings.myConsultations),
                  ),
                  Tab(
                    text: context.tr(AppStrings.received),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MyConsultationsTab(
                    currentDoctorModel: widget.currentDoctorModel,
                    homeDataModel: widget.homeDataModel,
                  ),
                  ReceivedTab(
                    currentDoctorModel: widget.currentDoctorModel,
                    homeDataModel: widget.homeDataModel,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
