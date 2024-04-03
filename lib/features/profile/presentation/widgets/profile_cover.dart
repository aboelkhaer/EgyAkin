import '../../../../exports.dart';

class ProfileCover extends StatelessWidget {
  const ProfileCover({
    super.key,
    required this.cubit,
  });

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 25.h,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: 1.4,
                    child: Image.asset(
                      AppImages.whiteEgyAkin,
                      color: Colors.black.withOpacity(0.04),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImage(cubit: cubit),
                    SizedBox(height: 5.h),
                    ProfileNameAndJob(cubit: cubit),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
