import 'package:egy_akin/features/about_us/presentation/cubit/about_us_cubit.dart';

import '../../../../exports.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AboutUsCubit cubit = AboutUsCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.all(20.0) + const EdgeInsets.only(bottom: 30),
          child: HtmlWidget(
            '''
              <!DOCTYPE html>
              <html lang="en">
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
        <h1>Welcome to EgyAkin</h1>
        <p>EgyAkin is dedicated to empowering Egypt's fight against kidney failure through cutting-edge data collection, insightful analytics, and robust community support. Our mission is to provide healthcare professionals and patients with the tools they need to effectively manage and monitor kidney health.</p>
        
        <h2>Our Mission</h2>
        <p>Our mission is to improve kidney health outcomes in Egypt by offering a comprehensive platform for managing patient data, calculating key health metrics, and tracking patient progress over time. We strive to provide valuable insights and support to both healthcare providers and patients, fostering a collaborative approach to combating kidney failure.</p>
        
        <h2>Key Features</h2>
        <ul>
            <li><strong>Patient Data Management:</strong> Easily add and manage patient details including name, age, gender, and medical history.</li>
            <li><strong>GFR Calculation:</strong> Utilize accurate CKD-EPI and Sobh equations to calculate the Glomerular Filtration Rate (GFR) for better kidney health management.</li>
            <li><strong>Historical Data Tracking:</strong> Monitor patient progress with detailed historical data tracking.</li>
            <li><strong>Health Insights:</strong> Gain valuable insights to improve kidney health outcomes.</li>
        </ul>
        
        <h2>Disclaimer</h2>
        <p>This app is intended for informational purposes only and should not be used as a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or another qualified health provider with any questions you may have regarding a medical condition.</p>
        
        <h2>Privacy Policy</h2>
        <p>Your privacy is important to us. Please review our <a href="https://egyakin.com/policy">Privacy Policy</a> to understand how we collect, use, and protect your information.</p>
        
        <h2>Contact Us</h2>
        <p>For support, please contact us at: <a href="mailto:support@egyakin.com">support@egyakin.com</a></p>
        
         <h2>Developer Information</h2>
    <p>This application was developed by Mohamed Ibrahiem.</p>
    
        <p>Thank you for choosing EgyAkin as your partner in kidney health management.</p>
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
