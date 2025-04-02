import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_state.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/pages/create_poll_screen.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/widgets/build_setting_item.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../../exports.dart';

class CreatePostInCommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final PostCommunityModel? feed;
  final String? groupId;
  final VoidCallback? onPostUploaded;

  const CreatePostInCommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.feed,
    this.groupId,
    this.onPostUploaded,
  });

  @override
  State<CreatePostInCommunityScreen> createState() =>
      _CreatePostInCommunityScreenState();
}

class _CreatePostInCommunityScreenState
    extends State<CreatePostInCommunityScreen> {
  PollModel? _poll;
  @override
  void initState() {
    if (widget.feed != null) {
      context
          .read<CreatePostInCommunityCubit>()
          .emitLoadedStateForEditPost(widget.feed!);
    }
    super.initState();
  }

  void _createPoll() async {
    final poll = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePollScreen(
          onPollCreated: (poll) {
            setState(() {
              _poll = poll;
              // context.read<CreatePostInCommunityCubit>().editFeedPollForEditableFeed(poll);
            });
          },
          initialOptionCount: 2,
          existingPoll: _poll, // Pass the existing poll data
        ),
      ),
    );
  }

  void _deletePoll() {
    // Show a confirmation dialog before deleting
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Poll'),
          content: const Text('Are you sure you want to delete this poll?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform the deletion logic here
                // For example, update the state or call a callback
                setState(() {
                  _poll = null; // Remove the poll
                });
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CreatePostInCommunityCubit cubit =
        CreatePostInCommunityCubit.get(context);

    ValueNotifier<TextDirection> textDirectionNotifier =
        ValueNotifier(TextDirection.ltr);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.feed == null ? 'Create Post' : 'Edit Post',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: BlocConsumer<CreatePostInCommunityCubit,
                CreatePostInCommunityState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (message) {
                    customSnackBar(
                      context: context,
                      message: message,
                    );
                  },
                  loaded: (postLength, changeCounter, isImagePick,
                      isUploadPostLoading, isUploadPostLoaded, message) {
                    if (message != '') {
                      customSnackBar(context: context, message: message);
                    }
                    if (isUploadPostLoaded) {
                      navigatorKey.currentState?.pop();
                      if (widget.groupId != null) {
                        widget.onPostUploaded?.call();
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          navigatorKey.currentState?.pushReplacementNamed(
                              AppRoutes.home,
                              arguments: 0);
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.community,
                            arguments: AppRoutesArgs.communityRouteArgs(
                              homeDataModel: widget.homeDataModel,
                              currentDoctorModel: widget.currentDoctorModel,
                              initialTab: 0,
                            ),
                          );
                        });
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
                        cubit.submitPost(context, widget.groupId, _poll);
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
                                        imageUrl: cubit.editableFeed != null
                                            ? cubit.editableFeed!.doctor!.image
                                                .toString()
                                            : widget.currentDoctorModel.image
                                                .toString(),
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
                                      cubit.editableFeed != null
                                          ? doctorName(
                                              firstName: cubit.editableFeed!
                                                  .doctor!.firstName,
                                              lastName: cubit.editableFeed!
                                                  .doctor!.lastName,
                                              role: cubit.editableFeed!.doctor!
                                                  .isSyndicateCardRequired
                                                  .toString(),
                                            )
                                          : doctorName(
                                              firstName: widget
                                                  .currentDoctorModel.firstName,
                                              lastName: widget
                                                  .currentDoctorModel.lastName,
                                              role: widget.homeDataModel
                                                  .isSyndicateCardRequired
                                                  .toString(),
                                            ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    cubit.editableFeed != null
                                        ? const VerificationIcon(
                                            isPatientCard: false,
                                          )
                                        : widget.currentDoctorModel
                                                    .isSyndicateCardRequired ==
                                                'Verified'
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
                                  return TextFormField(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    initialValue: cubit.editableFeed
                                        ?.content, // Set your initial value here
                                    onTapOutside: (event) =>
                                        FocusScope.of(context).unfocus(),
                                    decoration: const InputDecoration(
                                      hintText: 'What\'s on your mind?',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    textDirection: textDirection,
                                    onChanged: (value) {
                                      if (cubit.editableFeed == null) {
                                        cubit.postContent = value;
                                      } else {
                                        cubit.editFeedContentForEditableFeed(
                                            value);
                                      }
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
                                        cubit.editableFeed == null
                                            ? cubit.postContent.length
                                                .toString()
                                            : cubit
                                                .editableFeed!.content!.length
                                                .toString(),
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
                        //! Poll
                        if (_poll != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Poll Header
                                        const Text(
                                          'Poll',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        // Poll Question
                                        if (_poll?.question?.isNotEmpty ??
                                            false)
                                          Text(
                                            _poll!.question!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        if (_poll?.question?.isNotEmpty ??
                                            false)
                                          const SizedBox(height: 16),

                                        // Poll Options
                                        ...?(_poll?.options?.map((option) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.circle,
                                                  size: 12,
                                                  color: AppColors.primary,
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    option,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        })),

                                        // Poll Settings
                                        if ((_poll?.allowMultipleChoices ??
                                                false) ||
                                            (_poll?.allowAddOptions ?? false))
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 16),
                                              if (_poll?.allowMultipleChoices ??
                                                  false)
                                                buildSettingItem(
                                                  icon:
                                                      Icons.check_box_outlined,
                                                  label:
                                                      'Allow multiple choices',
                                                ),
                                              if (_poll?.allowAddOptions ??
                                                  false)
                                                buildSettingItem(
                                                  icon:
                                                      Icons.add_circle_outline,
                                                  label:
                                                      'Allow members to add options',
                                                ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),

                                  // Edit Icon
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed:
                                          _createPoll, // Call _createPoll to edit the poll
                                    ),
                                  ),

                                  // Delete Icon
                                  Positioned(
                                    top: 8,
                                    right: 40,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: _deletePoll,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),

                        // Picked Images
                        BlocBuilder<CreatePostInCommunityCubit,
                            CreatePostInCommunityState>(
                          builder: (context, state) {
                            final cubit =
                                CreatePostInCommunityCubit.get(context);
                            return Column(
                              children: [
                                if (cubit.imagesPicked.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, // 3 images per row
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemCount: cubit.imagesPicked.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                cubit.imagesPicked[index],
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                cubit.removeImage(
                                                    index); // Remove the image
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Container(
                                                margin: const EdgeInsets.all(4),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      spreadRadius: 1,
                                                      blurRadius: 3,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.grey.shade600,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                if (cubit.editableFeed != null &&
                                    cubit.editableFeed!.mediaPath != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, // 3 images per row
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemCount:
                                          cubit.editableFeed!.mediaPath!.length,
                                      itemBuilder: (context, index) {
                                        final imageUrl = cubit
                                            .editableFeed!.mediaPath![index];
                                        return Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: FadeIn(
                                                child: CachedNetworkImage(
                                                  imageUrl: imageUrl,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                cubit.removeMediaPathInEditableFeed(
                                                    index); // Remove the image at the specified index
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Container(
                                                margin: const EdgeInsets.all(8),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      spreadRadius: 1,
                                                      blurRadius: 3,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.grey.shade600,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                SizedBox(height: 100.h),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Footer Buttons
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: isKeyboardVisible ? 0 : 0),
                    child: BlocBuilder<CreatePostInCommunityCubit,
                        CreatePostInCommunityState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const SizedBox.shrink(),
                          loaded: (
                            postLength,
                            changeCounter,
                            isImagePick,
                            isUploadPostLoading,
                            isUploadPostLoaded,
                            message,
                          ) {
                            final hasPoll = _poll != null ||
                                (cubit.editableFeed?.poll != null);
                            final hasImages = cubit.imagesPicked.isNotEmpty ||
                                (cubit.editableFeed?.mediaPath?.isNotEmpty ??
                                    false);

                            if (widget.feed != null &&
                                widget.feed!.poll != null) {
                              return Center(
                                child: Text(
                                  'Your poll has already been published.',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              );
                            }

                            if (isImagePick) {
                              return Container(
                                color: Colors.grey.shade300,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: isKeyboardVisible ? 0 : 20),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: null,
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.transparent),
                                          shadowColor: MaterialStatePropertyAll(
                                              Colors.transparent),
                                          overlayColor:
                                              MaterialStatePropertyAll(
                                                  Colors.transparent),
                                        ),
                                        child: Text(''),
                                      ),
                                      SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator()),
                                      ElevatedButton(
                                        onPressed: null,
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.transparent),
                                          shadowColor: MaterialStatePropertyAll(
                                              Colors.transparent),
                                          overlayColor:
                                              MaterialStatePropertyAll(
                                                  Colors.transparent),
                                        ),
                                        child: Text(''),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Container(
                              color: Colors.grey.shade200,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                        horizontal: 20)
                                    .add(EdgeInsets.only(
                                        bottom: isKeyboardVisible ? 0 : 20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (!hasPoll) ...[
                                      ElevatedButton.icon(
                                        onPressed: () =>
                                            cubit.pickImageAndShowIt(false),
                                        icon: const Icon(Icons.photo_library),
                                        label: const Text("Gallery"),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton.icon(
                                        onPressed: () =>
                                            cubit.pickImageAndShowIt(true),
                                        icon: const Icon(Icons.camera_alt),
                                        label: const Text("Camera"),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                    if (!hasImages)
                                      ElevatedButton.icon(
                                        onPressed: _createPoll,
                                        icon: const Icon(Icons.poll),
                                        label: const Text("Poll"),
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
