import 'package:egy_akin/exports.dart';

class ProfileNameAndJob extends StatelessWidget {
  final ProfileCubit cubit;
  const ProfileNameAndJob({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            customSnackBar(message: message, context: context);
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            if (cubit.currentDoctor.firstName == null ||
                cubit.currentDoctor.lastName == null) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                Text(
                  'Dr.${capitalizeFirstText(cubit.currentDoctor.firstName!)} ${capitalizeFirstText(cubit.currentDoctor.lastName!)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  cubit.currentDoctor.job.toString(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            );
          },
          loaded: (doctorModel) {
            return Column(
              children: [
                Text(
                  'Dr.${capitalizeFirstText(doctorModel.firstName!)} ${capitalizeFirstText(doctorModel.lastName!)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  doctorModel.job.toString(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
