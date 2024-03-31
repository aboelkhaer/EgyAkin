import '../../../../exports.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => cubit.tabsController.jumpToTab(2),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 9,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppColors.primary.withOpacity(0.8),
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Text(
                            cubit.currentDoctorModel.firstName == null
                                ? ''
                                : cubit.currentDoctorModel.firstName![0]
                                    .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Text(
                            cubit.currentDoctorModel.firstName == null
                                ? ''
                                : 'Dr.${capitalizeFirstText(cubit.currentDoctorModel.firstName!)} ${capitalizeFirstText(cubit.currentDoctorModel.lastName!)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontSize: 14.sp,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Text(
                            cubit.currentDoctorModel.workingplace ??
                                AppStrings.empty,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                                color: Colors.grey.shade600),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Tooltip(
          message: 'Add patient',
          child: IconButton(
            onPressed: () {
              // Handle notification button press
            },
            icon: Icon(
              Icons.add,
              color: AppColors.description,
              size: 30.r,
            ),
          ),
        ),
      ],
    );
  }
}
