import 'package:egy_akin/features/profile/data/models/profile_screens.dart';

import '../../../../exports.dart';

class ProfileFeatures extends StatelessWidget {
  final ProfileCubit cubit;
  const ProfileFeatures({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          _profileScreensData().length,
          (index) => BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (doctorModel, isLoadedImage) async {
                  if (isLoadedImage) {
                    context.read<HomeCubit>().getDoctorDataFromLocal();
                  }
                },
                signOutLoaded: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed(AppRoutes.signIn);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return GestureDetector(
                    onTap: _profileScreensData()[index].onTap,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Icon(
                              _profileScreensData()[index].icon,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment:
                                _profileScreensData()[index].isHaveDescription
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                            children: [
                              Text(
                                _profileScreensData()[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                              _profileScreensData()[index].isHaveDescription
                                  ? Text(
                                      _profileScreensData()[index].description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp,
                                          color: Colors.grey.shade700),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                signOutLoading: () {
                  return GestureDetector(
                    onTap: _profileScreensData()[index].title == 'Sign out'
                        ? () {}
                        : _profileScreensData()[index].onTap,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: _profileScreensData()[index].title == 'Sign out'
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(),
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  child: Icon(
                                    _profileScreensData()[index].icon,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment:
                                      _profileScreensData()[index]
                                              .isHaveDescription
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      _profileScreensData()[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    _profileScreensData()[index]
                                            .isHaveDescription
                                        ? Text(
                                            _profileScreensData()[index]
                                                .description,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                                color: Colors.grey.shade700),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                )
                              ],
                            ),
                    ),
                  );
                },
                loaded: (doctorModel, isLoadedImage) {
                  return GestureDetector(
                    onTap: _profileScreensData()[index].onTap,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Icon(
                              _profileScreensData()[index].icon,
                              color: Colors.grey.shade800,
                              size: 20.r,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment:
                                _profileScreensData()[index].isHaveDescription
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                            children: [
                              Text(
                                _profileScreensData()[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                              _profileScreensData()[index].isHaveDescription
                                  ? Text(
                                      _profileScreensData()[index].description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp,
                                          color: Colors.grey.shade700),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<ProfileScreens> _profileScreensData() {
    return <ProfileScreens>[
      ProfileScreens(
        icon: Icons.person_outline,
        title: 'Account',
        description: 'Manage your personal info.',
        onTap: () {
          navigatorKey.currentState?.pushNamed(AppRoutes.doctorProfile);
        },
      ),
      // ProfileScreens(
      //   icon: Icons.emoji_events_outlined,
      //   title: 'Achievements',
      //   description: 'Explore your accomplishments.',
      //   onTap: () {},
      // ),
      // ProfileScreens(
      //   icon: Icons.chat_bubble_outline,
      //   title: 'Consultation',
      //   description: 'Initiate or view consultations.',
      //   onTap: () {},
      // ),
      ProfileScreens(
          icon: Icons.exit_to_app_outlined,
          title: 'Sign out',
          description: '',
          isHaveDescription: false,
          onTap: () {
            cubit.signOut();
          }),
    ];
  }
}
