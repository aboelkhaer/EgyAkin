import '../../../../exports.dart';

class AuthImage extends StatelessWidget {
  final String image;
  const AuthImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          width: double.infinity,
          height: 270.h,
        ),
      ],
    );
  }
}
