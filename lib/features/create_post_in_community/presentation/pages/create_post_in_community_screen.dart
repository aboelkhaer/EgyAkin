import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_cubit.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_state.dart';

import '../../../../exports.dart';

class CreatePostInCommunityScreen extends StatelessWidget {
  final DoctorModel currentDoctorModel;

  const CreatePostInCommunityScreen(
      {super.key, required this.currentDoctorModel});

  @override
  Widget build(BuildContext context) {
    CreatePostInCommunityCubit cubit = CreatePostInCommunityCubit.get(context);

    // TextEditingController to monitor input
    ValueNotifier<TextDirection> textDirectionNotifier =
        ValueNotifier(TextDirection.ltr);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 16, right: 16, bottom: 0),
                child: Row(
                  children: [
                    // Doctor's Profile Image
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
                            backgroundColor: AppColors.primary.withOpacity(0.8),
                            child: CustomCachedNetworkImage(
                              imageUrl: currentDoctorModel.image.toString(),
                              height: 100.h,
                              width: 100.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Doctor's Name
                    Row(
                      children: [
                        Text(
                          doctorName(
                            firstName: currentDoctorModel.firstName,
                            lastName: currentDoctorModel.lastName,
                            role: '',
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.title,
                            fontSize: 14.sp,
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
                  ],
                ),
              ),

              // Text Form Field for Post Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ValueListenableBuilder<TextDirection>(
                    valueListenable: textDirectionNotifier,
                    builder: (context, textDirection, child) {
                      return CustomTextFormField(
                        title: 'What\'s on your mind?',
                        textInputType: TextInputType.multiline,
                        maxLines: null,

                        maxLength: 3000,
                        // controller: textController,
                        textDirectionForCreatePostInCommunity: textDirection,
                        onChanged: (value) {
                          // Check if the first character is Arabic
                          cubit.postContent = value;
                          if (value.isNotEmpty &&
                              RegExp(r'^[\u0600-\u06FF]').hasMatch(value[0])) {
                            textDirectionNotifier.value = TextDirection.rtl;
                          } else {
                            textDirectionNotifier.value = TextDirection.ltr;
                          }
                          cubit.changePostLength(value.length);
                        },
                        isCreatePostInCommunity: true,
                        validator: (value) {
                          return null;
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 26),
                    child: BlocBuilder<CreatePostInCommunityCubit,
                        CreatePostInCommunityState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const SizedBox.shrink();
                          },
                          loaded: (postLength) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '$postLength',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: postLength == 3000
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
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Footer Section for Image Picking
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MediaQuery.of(context).viewInsets.bottom == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add logic to pick an image from the gallery
                            },
                            icon: const Icon(Icons.photo_library),
                            label: const Text("Gallery"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add logic to take an image using the camera
                            },
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Camera"),
                          ),
                        ],
                      )
                    : const SizedBox(), // Hide footer when keyboard appears
              ),
            ],
          );
        },
      ),
    );
  }
}
