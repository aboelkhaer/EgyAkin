import 'package:egy_akin/features/about_us/presentation/widgets/about_us_ui.dart';

import '../../../../exports.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  void _openUrl(BuildContext context, String url) {
    launchURL(
      url: url,
      onError: (error) => showErrorDialog(context, error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffoldBg =
            isDark ? AppColors.darkScaffoldBG : AppColors.scaffoldBG;
        final appBarForeground = isDark ? AppColors.darkTitle : AppColors.title;

        final features = <({IconData icon, String title, String desc})>[
          (
            icon: Icons.folder_shared_outlined,
            title: context.tr(AppStrings.patientDataManagement),
            desc: context.tr(AppStrings.patientDataManagementDesc),
          ),
          (
            icon: Icons.calculate_outlined,
            title: context.tr(AppStrings.gfrCalculation),
            desc: context.tr(AppStrings.gfrCalculationDesc),
          ),
          (
            icon: Icons.timeline_outlined,
            title: context.tr(AppStrings.aboutRepeatableReadings),
            desc: context.tr(AppStrings.aboutRepeatableReadingsDesc),
          ),
          (
            icon: Icons.history_rounded,
            title: context.tr(AppStrings.historicalDataTracking),
            desc: context.tr(AppStrings.historicalDataTrackingDesc),
          ),
          (
            icon: Icons.groups_outlined,
            title: context.tr(AppStrings.aboutMedicalCommunity),
            desc: context.tr(AppStrings.aboutMedicalCommunityDesc),
          ),
          (
            icon: Icons.medical_services_outlined,
            title: context.tr(AppStrings.aboutDoctorConsultations),
            desc: context.tr(AppStrings.aboutDoctorConsultationsDesc),
          ),
          (
            icon: Icons.auto_awesome_outlined,
            title: context.tr(AppStrings.aiPoweredConsultations),
            desc: context.tr(AppStrings.aiPoweredConsultationsDesc),
          ),
          (
            icon: Icons.document_scanner_outlined,
            title: context.tr(AppStrings.aboutAiFormAnalysis),
            desc: context.tr(AppStrings.aboutAiFormAnalysisDesc),
          ),
          (
            icon: Icons.lock_outline_rounded,
            title: context.tr(AppStrings.aboutSecureMessaging),
            desc: context.tr(AppStrings.aboutSecureMessagingDesc),
          ),
        ];

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: scaffoldBg,
            foregroundColor: appBarForeground,
            iconTheme: IconThemeData(color: appBarForeground),
            title: Text(
              context.tr(AppStrings.aboutUs),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
                color: appBarForeground,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AboutHeroBanner(),
                  SizedBox(height: 14.h),
                  AboutSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AboutSectionHeader(
                          icon: Icons.flag_outlined,
                          title: context.tr(AppStrings.ourMission),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          context.tr(AppStrings.ourMissionDescription),
                          style: TextStyle(
                            fontSize: 12.sp,
                            height: 1.5,
                            color: isDark
                                ? AppColors.darkDescription
                                : Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  AboutSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AboutSectionHeader(
                          icon: Icons.star_outline_rounded,
                          title: context.tr(AppStrings.keyFeatures),
                        ),
                        SizedBox(height: 12.h),
                        ...features.asMap().entries.map((entry) {
                          final feature = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  entry.key == features.length - 1 ? 0 : 8.h,
                            ),
                            child: AboutFeatureTile(
                              icon: feature.icon,
                              title: feature.title,
                              description: feature.desc,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  AboutSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AboutSectionHeader(
                          icon: Icons.verified_user_outlined,
                          title:
                              context.tr(AppStrings.supervisorAndResponsible),
                        ),
                        SizedBox(height: 12.h),
                        AboutPersonTile(
                          icon: Icons.medical_information_outlined,
                          name: context.tr(AppStrings.mostafaAbdelsalam),
                          role: context.tr(AppStrings.mostafaAbdelsalamDesc),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  AboutSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AboutSectionHeader(
                          icon: Icons.code_rounded,
                          title: context.tr(AppStrings.developerInformation),
                        ),
                        SizedBox(height: 12.h),
                        AboutPersonTile(
                          name: context.tr(AppStrings.mohamedIbrahiem),
                          role: context.tr(AppStrings.mohamedIbrahiemDesc),
                          email: 'mohamedco215@gmail.com',
                          onEmailTap: () => _openUrl(
                            context,
                            'mailto:mohamedco215@gmail.com',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        AboutPersonTile(
                          name: context.tr(AppStrings.moatzAboElyazed),
                          role: context.tr(AppStrings.moatzAboElyazedDesc),
                          email: 'aboelkhaer@yandex.com',
                          onEmailTap: () => _openUrl(
                            context,
                            'mailto:aboelkhaer@yandex.com',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  AboutSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AboutSectionHeader(
                          icon: Icons.link_rounded,
                          title: context.tr(AppStrings.contactUs),
                          subtitle: context.tr(AppStrings.contactUsText),
                        ),
                        SizedBox(height: 12.h),
                        AboutLinkTile(
                          icon: Icons.privacy_tip_outlined,
                          label: context.tr(AppStrings.privacyPolicy),
                          value: 'egyakin.com/policy',
                          onTap: () => _openUrl(
                            context,
                            'https://egyakin.com/policy',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        AboutLinkTile(
                          icon: Icons.email_outlined,
                          label: context.tr(AppStrings.contactUsEmailSupport),
                          value: context.tr(AppStrings.contactUsSupportEmail),
                          onTap: () => _openUrl(
                            context,
                            'mailto:${AppStrings.contactUsSupportEmail}',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        AboutLinkTile(
                          icon: Icons.language_outlined,
                          label: context.tr(AppStrings.visitOurWebsite),
                          value: 'egyakin.com',
                          onTap: () => _openUrl(
                            context,
                            AppStrings.contactUsWebsiteUrl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  AboutSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AboutSectionHeader(
                          icon: Icons.info_outline_rounded,
                          title: context.tr(AppStrings.disclaimer),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          context.tr(AppStrings.disclaimerText),
                          style: TextStyle(
                            fontSize: 11.sp,
                            height: 1.45,
                            color: isDark
                                ? AppColors.darkDescription
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    context.tr(AppStrings.thankYouForChoosingEgyAkin),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      color: isDark
                          ? AppColors.darkDescription
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
