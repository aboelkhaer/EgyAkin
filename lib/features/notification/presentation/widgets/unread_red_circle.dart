import 'package:egy_akin/exports.dart';

class UnreadRedCircle extends StatelessWidget {
  final bool isRead;
  const UnreadRedCircle({super.key, required this.isRead});

  @override
  Widget build(BuildContext context) {
    if (isRead) {
      return const SizedBox.shrink();
    }
    return  Positioned(
                          left: context.currentLocale?.languageCode == 'ar' ? null : 0,
                          right: context.currentLocale?.languageCode == 'ar' ? 0 : null,
                          // top: 2.h,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5.r,
                          ),
                        );
  }
}