import 'dart:ui';

import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/presentation/cubit/create_group_in_community_cubit.dart';
import 'package:egy_akin/features/create_group_in_community/presentation/cubit/create_group_in_community_state.dart';

import '../../../../exports.dart';

class CreateGroupInCommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final bool isCreateNewGroup;
  final GroupModel? groupModel;
  const CreateGroupInCommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.isCreateNewGroup,
    this.groupModel,
  });

  @override
  State<CreateGroupInCommunityScreen> createState() =>
      _CreateGroupInCommunityScreenState();
}

class _CreateGroupInCommunityScreenState
    extends State<CreateGroupInCommunityScreen> {
  @override
  void initState() {
    if (widget.isCreateNewGroup == false) {
      context
          .read<CreateGroupInCommunityCubit>()
          .addEditableGroupModel(widget.groupModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CreateGroupInCommunityCubit cubit =
        CreateGroupInCommunityCubit.get(context);

    if (widget.isCreateNewGroup == false) {
      _parseGroupPrivacy(widget.groupModel!.privacy, context);
      cubit.groupHeaderText = widget.groupModel!.name.toString();
      cubit.groupDescriptionText = widget.groupModel!.description.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isCreateNewGroup
              ? context.tr(AppStrings.createGroup)
              : context.tr(AppStrings.updateGroup),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  cubit.pickGroupHeaderImage();
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.3),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: BlocConsumer<CreateGroupInCommunityCubit,
                          CreateGroupInCommunityState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () {},
                            loaded: (snackBarMessage,
                                dialogMessage,
                                isPickGroupHeaderLoading,
                                isPickGroupImageLoading,
                                counterChanges,
                                isCreateGroupLoading,
                                isCreateGroupLoaded) {
                              if (snackBarMessage.isNotEmpty) {
                                customSnackBar(
                                    context: context, message: snackBarMessage);
                              }
                              if (isCreateGroupLoaded) {
                                navigatorKey.currentState?.pushReplacementNamed(
                                    AppRoutes.home,
                                    arguments: 0);
                                Future.delayed(Duration.zero, () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.community,
                                    arguments: AppRoutesArgs.communityRouteArgs(
                                      homeDataModel: widget.homeDataModel,
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      initialTab: 2,
                                    ),
                                  );
                                });
                                Future.delayed(Duration.zero, () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.allGroupsInCommunity,
                                    arguments: AppRoutesArgs
                                        .allGroupsInCommunityRouteArgs(
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      homeDataModel: widget.homeDataModel,
                                    ),
                                  );
                                });
                              }
                            },
                          );
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const SizedBox.shrink(),
                            loaded: (snackBarMessage,
                                dialogMessage,
                                isPickGroupHeaderLoading,
                                isPickGroupImageLoading,
                                counterChanges,
                                isCreateGroupLoading,
                                isCreateGroupLoaded) {
                              if (!widget.isCreateNewGroup &&
                                  cubit.imagePickedForGroupHeader == null) {
                                return CustomCachedNetworkImage(
                                  imageUrl: widget.groupModel!.headerPicture
                                      .toString(),
                                  width: double.infinity,
                                );
                              }
                              return cubit.imagePickedForGroupHeader == null
                                  ? const SizedBox.shrink()
                                  : Image.file(
                                      cubit.imagePickedForGroupHeader!,
                                      fit: BoxFit.cover,
                                    );
                            },
                          );
                        },
                      ),
                    ),

                    // Glass-like Circular Background with Icon
                    Positioned(
                      child: BlocBuilder<CreateGroupInCommunityCubit,
                          CreateGroupInCommunityState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const SizedBox.shrink(),
                            loaded: (snackBarMessage,
                                dialogMessage,
                                isPickGroupHeaderLoading,
                                isPickGroupImageLoading,
                                counterChanges,
                                isCreateGroupLoading,
                                isCreateGroupLoaded) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        40), // Circular shape
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withOpacity(0.2), // Glass effect
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  isPickGroupHeaderLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.camera_alt_outlined,
                                          size: 28,
                                          color: Colors.white,
                                        ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r, // hidden widget to add stack raduis size
                        backgroundColor: AppColors.transparent,
                        child: Container(
                          margin: const EdgeInsets.only(top: 3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 27
                                .r, // border size which contain profile picture
                            backgroundColor: AppColors.primary.withOpacity(0.4),
                            child: CircleAvatar(
                              radius: 25.r,
                              backgroundColor: AppColors.white,
                              child: BlocBuilder<CreateGroupInCommunityCubit,
                                  CreateGroupInCommunityState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(80.r),
                                        child: Container(
                                          width: 100.w,
                                          height: 100.h,
                                          color: AppColors.primary
                                              .withOpacity(0.3),
                                        ),
                                      );
                                    },
                                    loaded: (
                                      snackBarMessage,
                                      dialogMessage,
                                      isPickGroupHeaderLoading,
                                      isPickGroupImageLoading,
                                      counterChanges,
                                      isCreateGroupLoading,
                                      isCreateGroupLoaded,
                                    ) {
                                      if (widget.isCreateNewGroup == false &&
                                          cubit.imagePickedForGroupImage ==
                                              null) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(80.r),
                                          child: CustomCachedNetworkImage(
                                            imageUrl: widget
                                                .groupModel!.groupImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                            width: 100.w,
                                            height: 100.h,
                                          ),
                                        );
                                      }
                                      return cubit.imagePickedForGroupImage !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(80.r),
                                              child: Image.file(
                                                cubit.imagePickedForGroupImage!,
                                                fit: BoxFit.cover,
                                                width: 100.w,
                                                height: 100.h,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(80.r),
                                              child: Container(
                                                width: 100.w,
                                                height: 100.h,
                                                color: AppColors.primary
                                                    .withOpacity(0.3),
                                              ),
                                            );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // left: 0,
                        right: 20.w,
                        bottom: 12.h,
                        child: GestureDetector(
                          onTap: () async {
                            // cubit.uploadProfileImage();
                          },
                          child: CircleAvatar(
                            radius: 15.r, // white border for camera icon
                            backgroundColor: AppColors.white,
                            child: CircleAvatar(
                              radius: 13.r, // camera background
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.6),
                              child: BlocBuilder<CreateGroupInCommunityCubit,
                                  CreateGroupInCommunityState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return const SizedBox.shrink();
                                    },
                                    loaded: (
                                      snackBarMessage,
                                      dialogMessage,
                                      isPickGroupHeaderLoading,
                                      isPickGroupImageLoading,
                                      counterChanges,
                                      isCreateGroupLoading,
                                      isCreateGroupLoaded,
                                    ) {
                                      return isPickGroupImageLoading
                                          ? const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                  width: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : InkWell(
                                              onTap: () {
                                                cubit.pickGroupImage();
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 16.r,
                                                color: AppColors.white,
                                              ),
                                            );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      title: context.tr(AppStrings.title),
                      textInputType: TextInputType.text,
                      initialValue: widget.isCreateNewGroup
                          ? null
                          : widget.groupModel!.name,
                      validator: (value) {
                        return null;
                      },
                      onChanged: (value) {
                        cubit.groupHeaderText = value;
                      },
                    ),
                  ),
                  SizedBox(width: 40.w),
                ],
              ),
              Container(
                height: 100.h,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFormField(
                  title: context.tr(AppStrings.description),
                  textInputType: TextInputType.text,
                  initialValue: widget.isCreateNewGroup
                      ? null
                      : widget.groupModel!.description,
                  validator: (value) {
                    return null;
                  },
                  maxLines: 4,
                  onChanged: (value) {
                    cubit.groupDescriptionText = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Privacy Radio Buttons
                     Text(
                      context.tr(AppStrings.privacy),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary, // Use AppColors.primary
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<CreateGroupInCommunityCubit,
                            CreateGroupInCommunityState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return Radio<GroupPrivacy>(
                                  value: GroupPrivacy.public,
                                  groupValue: cubit.privacy,
                                  onChanged: (value) {
                                    cubit.setPrivacy(value!);
                                  },
                                  activeColor: AppColors
                                      .primary, // Use AppColors.primary
                                );
                              },
                            );
                          },
                        ),
                        Text(
                          context.tr(AppStrings.public),
                          style: TextStyle(
                            color: AppColors.primary, // Use AppColors.primary
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        BlocBuilder<CreateGroupInCommunityCubit,
                            CreateGroupInCommunityState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return Radio<GroupPrivacy>(
                                  value: GroupPrivacy.private,
                                  groupValue: cubit.privacy,
                                  onChanged: (value) {
                                    cubit.setPrivacy(value!);
                                  },
                                  activeColor: AppColors
                                      .primary, // Use AppColors.primary
                                );
                              },
                            );
                          },
                        ),
                        Text(
                          context.tr(AppStrings.private),
                          style: TextStyle(
                            color: AppColors.primary, // Use AppColors.primary
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Other UI elements (e.g., image pickers)
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<CreateGroupInCommunityCubit,
                    CreateGroupInCommunityState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox.shrink();
                      },
                      loaded: (snackBarMessage,
                          dialogMessage,
                          isPickGroupHeaderLoading,
                          isPickGroupImageLoading,
                          counterChanges,
                          isCreateGroupLoading,
                          isCreateGroupLoaded) {
                        return isCreateGroupLoading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              )
                            : CustomElevatedButton(
                                onPressed: () {
                                  if (cubit.editableGroupModel == null) {
                                    cubit.createGroup();
                                  } else {
                                    // cubit.updateGroup(cubit
                                    //     .editableGroupModel!.id
                                    //     .toString());
                                    if (cubit.imagePickedForGroupHeader ==
                                            null &&
                                        cubit.imagePickedForGroupImage ==
                                            null) {
                                      cubit.updateGroupTexts(cubit
                                          .editableGroupModel!.id
                                          .toString());
                                      return;
                                    }
                                    if (cubit.imagePickedForGroupHeader !=
                                            null &&
                                        cubit.imagePickedForGroupImage ==
                                            null) {
                                      cubit.updateGroupHeaderImage(cubit
                                          .editableGroupModel!.id
                                          .toString());
                                      return;
                                    }
                                    if (cubit.imagePickedForGroupHeader ==
                                            null &&
                                        cubit.imagePickedForGroupImage !=
                                            null) {
                                      cubit.updateGroupImage(cubit
                                          .editableGroupModel!.id
                                          .toString());
                                      return;
                                    }
                                    if (cubit.imagePickedForGroupHeader !=
                                            null &&
                                        cubit.imagePickedForGroupImage !=
                                            null) {
                                      cubit.updateGroupHeaderImageAndGroupImage(
                                          cubit.editableGroupModel!.id
                                              .toString());
                                      return;
                                    }
                                  }
                                },
                                title: widget.isCreateNewGroup
                                    ? context.tr(AppStrings.create)
                                    : context.tr(AppStrings.update),
                              );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _parseGroupPrivacy(String? privacy, BuildContext context) {
    if (privacy == 'public') {
      context.read<CreateGroupInCommunityCubit>().privacySetValue =
          GroupPrivacy.public;
      return;
    } else if (privacy == 'private') {
      context.read<CreateGroupInCommunityCubit>().privacySetValue =
          GroupPrivacy.private;
      return;
    }
  }
}
