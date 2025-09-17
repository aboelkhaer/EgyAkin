import '../../../../app/services/theme_bloc.dart';
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: AppBar(
            backgroundColor:
                isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
            iconTheme: IconThemeData(
              color: isDarkMode ? AppColors.darkTitle : Colors.black,
            ),
            title: Text(
              context.tr(AppStrings.consultation),
              style: TextStyle(
                color: isDarkMode ? AppColors.darkTitle : Colors.black,
              ),
            ),
          ),
          body: DefaultTabController(
            length: 2,
            initialIndex: widget.initialTab,
            child: Column(
              children: [
                ColoredBox(
                  color: isDarkMode
                      ? AppColors.darkBorder
                      : AppColors.primary.withOpacity(0.2),
                  child: TabBar(
                    labelColor:
                        isDarkMode ? AppColors.darkTitle : AppColors.primary,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? AppColors.darkTitle
                            : AppColors.primary,
                        width: 3,
                      ),
                    ),
                    isScrollable: false,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelColor: isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey.shade500,
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
      },
    );
  }
}
