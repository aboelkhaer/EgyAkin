import '../../../../exports.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AboutUsCubit cubit = AboutUsCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(AppStrings.aboutUs)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.all(20.0) + const EdgeInsets.only(bottom: 30),
          child: HtmlWidget(
            '''
              <!DOCTYPE html>
              <html lang="${context.currentLocale?.languageCode ?? 'en'}">
              <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f7f7f7;
        }
        h1, h2, h3 {
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .container a {
            color: #1e90ff;
            text-decoration: none;
        }
        .container a:hover {
            text-decoration: underline;
        }
          </style>
              </head>
              <body>
          <div class="container">
        <h1>${context.tr(AppStrings.welcomeToEgyAkin)}</h1>
        <p>${context.tr(AppStrings.egyAkinDescription)}</p>
        
        <h2>${context.tr(AppStrings.ourMission)}</h2>
        <p>${context.tr(AppStrings.ourMissionDescription)}</p>
        
        <h2>${context.tr(AppStrings.keyFeatures)}</h2>
        <ul>
            <li><strong>${context.tr(AppStrings.patientDataManagement)}:</strong> ${context.tr(AppStrings.patientDataManagementDesc)}</li>
            <li><strong>${context.tr(AppStrings.gfrCalculation)}:</strong> ${context.tr(AppStrings.gfrCalculationDesc)}</li>
            <li><strong>${context.tr(AppStrings.aboutRepeatableReadings)}:</strong> ${context.tr(AppStrings.aboutRepeatableReadingsDesc)}</li>
            <li><strong>${context.tr(AppStrings.historicalDataTracking)}:</strong> ${context.tr(AppStrings.historicalDataTrackingDesc)}</li>
            <li><strong>${context.tr(AppStrings.aboutMedicalCommunity)}:</strong> ${context.tr(AppStrings.aboutMedicalCommunityDesc)}</li>
            <li><strong>${context.tr(AppStrings.aboutDoctorConsultations)}:</strong> ${context.tr(AppStrings.aboutDoctorConsultationsDesc)}</li>
            <li><strong>${context.tr(AppStrings.aiPoweredConsultations)}:</strong> ${context.tr(AppStrings.aiPoweredConsultationsDesc)}</li>
            <li><strong>${context.tr(AppStrings.aboutAiFormAnalysis)}:</strong> ${context.tr(AppStrings.aboutAiFormAnalysisDesc)}</li>
            <li><strong>${context.tr(AppStrings.aboutSecureMessaging)}:</strong> ${context.tr(AppStrings.aboutSecureMessagingDesc)}</li>
        </ul>
        
        <h2>${context.tr(AppStrings.disclaimer)}</h2>
        <p>${context.tr(AppStrings.disclaimerText)}</p>
        
        <h2>${context.tr(AppStrings.privacyPolicy)}</h2>
        <p>${context.tr(AppStrings.privacyPolicyText)} <a href="https://egyakin.com/policy">${context.tr(AppStrings.privacyPolicy)}</a></p>
        
        <h2>${context.tr(AppStrings.contactUs)}</h2>
        <p>${context.tr(AppStrings.contactUsText)} <a href="mailto:support@egyakin.com">support@egyakin.com</a></p>
        <p>${context.tr(AppStrings.visitOurWebsite)} <a href="https://egyakin.com">https://egyakin.com</a></p>
        
         <h2>${context.tr(AppStrings.supervisorAndResponsible)}</h2>
          <ul>
            <li><strong>${context.tr(AppStrings.mostafaAbdelsalam)}:</strong> ${context.tr(AppStrings.mostafaAbdelsalamDesc)}</li>
          
        </ul>
         


         <h2>${context.tr(AppStrings.developerInformation)}</h2>
     <ul>
            <li><strong>${context.tr(AppStrings.mohamedIbrahiem)}:</strong> ${context.tr(AppStrings.mohamedIbrahiemDesc)} <a href="mailto:mohamedco215@gmail.com">mohamedco215@gmail.com</a></li>
            
        </ul>
          <ul>
            <li><strong>${context.tr(AppStrings.moatzAboElyazed)}:</strong> ${context.tr(AppStrings.moatzAboElyazedDesc)} <a href="mailto:aboelkhaer@yandex.com">aboelkhaer@yandex.com</a></li>
         </ul>
        <p>${context.tr(AppStrings.thankYouForChoosingEgyAkin)}</p>
          </div>
              </body>
              </html>
              
              
              ''',
            onTapUrl: (url) {
              launchURL(
                  url: url,
                  onError: (error) {
                    showErrorDialog(context, error);
                  });
              return true;
            },
          ),
        ),
      ),
    );
  }
}
