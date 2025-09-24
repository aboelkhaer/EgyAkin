import 'package:webview_flutter/webview_flutter.dart';
import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white) // Will be updated in build method
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading progress if needed
            if (progress == 100) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource errors
            debugPrint('WebView error: ${error.description}');
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _updateWebViewBackground(bool isDarkMode) {
    controller.setBackgroundColor(
      isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        // Update WebView background color based on theme
        _updateWebViewBackground(isDarkMode);

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16.sp,
                color: isDarkMode ? AppColors.darkTitle : Colors.white,
              ),
            ),
            backgroundColor:
                isDarkMode ? AppColors.darkCardBG : AppColors.primary,
            foregroundColor: isDarkMode ? AppColors.darkTitle : Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode ? AppColors.darkTitle : Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: isDarkMode ? AppColors.darkTitle : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  controller.reload();
                },
              ),
            ],
          ),
          body: Container(
            color: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
            child: Stack(
              children: [
                // WebView with proper background
                Container(
                  color: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
                  child: WebViewWidget(controller: controller),
                ),
                // Loading indicator
                if (isLoading)
                  Container(
                    color: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDarkMode
                                  ? AppColors.darkPrimary
                                  : AppColors.primary,
                            ),
                            strokeWidth: 3.0,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            '${context.tr(AppStrings.loading)}...',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDarkMode
                                  ? AppColors.darkDescription
                                  : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
