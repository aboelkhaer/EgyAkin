import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_cubit.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_state.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../exports.dart';

class CreatePostInCommunityScreen extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const CreatePostInCommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    final CreatePostInCommunityCubit cubit =
        CreatePostInCommunityCubit.get(context);

    ValueNotifier<TextDirection> textDirectionNotifier =
        ValueNotifier(TextDirection.ltr);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: BlocConsumer<CreatePostInCommunityCubit,
                CreatePostInCommunityState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (postLength, changeCounter, isImagePick,
                      isUploadPostLoading, isUploadPostLoaded, message) {
                    if (isUploadPostLoaded) {
                      if (context.read<CommunityCubit>().isClosed == false) {
                        navigatorKey.currentState?.pop();
                        navigatorKey.currentState?.popAndPushNamed(
                            AppRoutes.community,
                            arguments: AppRoutesArgs.communityRouteArgs(
                                homeDataModel: homeDataModel,
                                currentDoctorModel: currentDoctorModel));
                      }
                    }
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const SizedBox.shrink();
                  },
                  loaded: (
                    postLength,
                    changeCounter,
                    isImagePick,
                    isUploadPostLoading,
                    isUploadPostLoaded,
                    message,
                  ) {
                    if (isUploadPostLoading) {
                      return IconButton(
                        color: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                        icon: const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }

                    return IconButton(
                      color: Colors.white,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        cubit.submitPost(context);
                      },
                      icon: const Icon(Icons.send),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return Stack(
                children: [
                  // Main content
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 9,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80.r),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Handle user profile navigation here
                                    },
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor:
                                          AppColors.primary.withOpacity(0.8),
                                      child: CustomCachedNetworkImage(
                                        imageUrl:
                                            currentDoctorModel.image.toString(),
                                        height: 100.h,
                                        width: 100.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      doctorName(
                                        firstName: currentDoctorModel.firstName,
                                        lastName: currentDoctorModel.lastName,
                                        role: '',
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    'Verified' == 'Verified'
                                        ? const VerificationIcon(
                                            isPatientCard: false,
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Text Field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder<TextDirection>(
                                valueListenable: textDirectionNotifier,
                                builder: (context, textDirection, child) {
                                  return TextField(
                                    // controller: _textController,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    onTapOutside: (event) =>
                                        FocusScope.of(context).unfocus(),
                                    decoration: const InputDecoration(
                                      hintText: "What's on your mind?",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        //  color: Colors.transparent,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    textDirection: textDirection,
                                    onChanged: (value) {
                                      cubit.postContent = value;
                                      if (value.isNotEmpty &&
                                          RegExp(r'^[\u0600-\u06FF]')
                                              .hasMatch(value[0])) {
                                        textDirectionNotifier.value =
                                            TextDirection.rtl;
                                      } else {
                                        textDirectionNotifier.value =
                                            TextDirection.ltr;
                                      }
                                      cubit.changePostLength(value.length);
                                    },
                                  );
                                },
                              ),
                              BlocBuilder<CreatePostInCommunityCubit,
                                  CreatePostInCommunityState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        cubit.postContent.length.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              cubit.postContent.length == 3000
                                                  ? Colors.red
                                                  : Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        '/3000',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Picked Image
                        BlocBuilder<CreatePostInCommunityCubit,
                            CreatePostInCommunityState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return const SizedBox.shrink();
                              },
                              loaded: (
                                postLength,
                                changeCounter,
                                isImagePick,
                                isUploadPostLoading,
                                isUploadPostLoaded,
                                message,
                              ) {
                                if (cubit.imagePicked != null) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Stack(
                                      alignment: Alignment
                                          .topRight, // Align the icon in the top-right corner
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            cubit.imagePicked!,
                                            width: double.infinity,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.removePickedImage();
                                          },
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                  0.5), // White background for the icon button
                                              shape: BoxShape
                                                  .circle, // Make the background circular
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(
                                                      0.2), // Optional shadow for better visibility
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.grey
                                                  .shade600, // Adjust color as needed
                                              size: 25, // Adjust size as needed
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            );
                          },
                        ),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),

                  // Footer Buttons
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                      bottom: isKeyboardVisible ? 0 : 0,
                    ),
                    child: BlocBuilder<CreatePostInCommunityCubit,
                        CreatePostInCommunityState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const SizedBox.shrink();
                          },
                          loaded: (
                            postLength,
                            changeCounter,
                            isImagePick,
                            isUploadPostLoading,
                            isUploadPostLoaded,
                            message,
                          ) {
                            if (isImagePick) {
                              return Container(
                                color: Colors.grey.shade300,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: isKeyboardVisible ? 0 : 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          overlayColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.transparent,
                                          shadowColor: Colors
                                              .transparent, // Optional: Makes the shadow transparent
                                        ),
                                        child: const Text(''),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          overlayColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.transparent,
                                          shadowColor: Colors
                                              .transparent, // Optional: Makes the shadow transparent
                                        ),
                                        child: const Text(''),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Container(
                              color: Colors.grey.shade300,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ) +
                                    EdgeInsets.only(
                                        bottom: isKeyboardVisible ? 0 : 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        cubit.pickImageAndShowIt(false);
                                      },
                                      icon: const Icon(Icons.photo_library),
                                      label: const Text("Gallery"),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        cubit.pickImageAndShowIt(true);
                                      },
                                      icon: const Icon(Icons.camera_alt),
                                      label: const Text("Camera"),
                                    ),
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
            },
          );
        },
      ),
    );
  }
}
