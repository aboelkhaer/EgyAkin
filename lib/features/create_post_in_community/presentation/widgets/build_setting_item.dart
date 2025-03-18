import '../../../../exports.dart';

Widget buildSettingItem({required IconData icon, required String label}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary, // Use AppColors.primary
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey, // Muted text color
          ),
        ),
      ],
    ),
  );
}
