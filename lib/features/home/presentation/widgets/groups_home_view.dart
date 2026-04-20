import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class GroupsHomeView extends StatefulWidget {
  const GroupsHomeView({super.key});

  @override
  State<GroupsHomeView> createState() => _GroupsHomeViewState();
}

class _GroupsHomeViewState extends State<GroupsHomeView> {
  @override
  void initState() {
    super.initState();
    PermissionHelper.refreshPermissions().then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _recheckPermission() async {
    await PermissionHelper.refreshPermissions();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (_, __, ___, ____, _____, ______, _______, ________,
              _________, __________) {
            _recheckPermission();
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          if (!PermissionHelper.canPermission(
              AppPermissions.viewGroupsInHome)) {
            return const SizedBox.shrink();
          }
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (
                  homeData,
                  currentDoctorModel,
                  dotsPosition,
                  homeIndex,
                  isUploadingSyndicateCard,
                  isUploadedSyndicateCard,
                  message,
                  checkUpdateMessageCounter,
                  isUserBlocked,
                  changesCounter,
                ) {
                  // if (isVerifiedUser(homeData.isSyndicateCardRequired)) {
                  //   return const SizedBox.shrink();
                  // }

                  return Column(
                    children: [
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          context.read<GroupsCubit>().callGroupsTabTimes = 0;
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.community,
                            arguments: AppRoutesArgs.communityRouteArgs(
                              homeDataModel: homeData,
                              currentDoctorModel: currentDoctorModel,
                              initialTab: 2,
                            ),
                          );
                        },
                        child: Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Image with dual fading effect
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ShaderMask(
                                  shaderCallback: (rect) {
                                    return LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.8),
                                        Colors.black.withOpacity(0.3),
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.5),
                                      ],
                                      stops: const [0.0, 0.2, 0.4, 0.6, 1.0],
                                    ).createShader(rect);
                                  },
                                  blendMode: BlendMode.multiply,
                                  child: Image.asset(
                                    'assets/images/groups.jpg',
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Text with glass morphism effect
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(0.25),
                                      Colors.white.withOpacity(0.15),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    )
                                  ],
                                ),
                                child: Text(
                                  context.tr(AppStrings.joinOurGroups),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 1.8,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 8,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
