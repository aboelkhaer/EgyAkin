import 'package:egy_akin/exports.dart';

class ProfileNameAndJob extends StatelessWidget {
  final ProfileCubit cubit;

  const ProfileNameAndJob({
    super.key,
    required this.cubit,
  });

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
                  capitalizeFirstText(
                      cubit.currentDoctor.specialty ?? AppStrings.empty),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 3.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(context
                                .read<HomeCubit>()
                                .doctorPatientCount
                                .toString()),
                            SizedBox(width: 3.w),
                            const Text('Patient'),
                            SizedBox(width: 10.w),
                          ],
                        ),
                        const Text('|'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Text(
                              context.read<HomeCubit>().doctorScore.toString(),
                            ),
                            SizedBox(width: 3.w),
                            const Text('Score'),
                            // SizedBox(width: 5.w),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
          loaded: (doctorModel, isLoadedImage) {
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
                  capitalizeFirstText(
                      doctorModel.specialty ?? AppStrings.empty),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 3.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(context
                                .read<HomeCubit>()
                                .doctorPatientCount
                                .toString()),
                            SizedBox(width: 3.w),
                            const Text('Patient'),
                            SizedBox(width: 10.w),
                          ],
                        ),
                        const Text('|'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Text(
                              context.read<HomeCubit>().doctorScore.toString(),
                            ),
                            SizedBox(width: 3.w),
                            const Text('Score'),
                            // SizedBox(width: 5.w),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
