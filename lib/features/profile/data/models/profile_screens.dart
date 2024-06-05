import 'package:egy_akin/exports.dart';

class ProfileScreens {
  final IconData icon;
  final String title;
  final String description;
  final bool isHaveDescription;
  final Function() onTap;

  ProfileScreens({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.isHaveDescription = true,
  });
}
