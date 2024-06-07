import 'package:egy_akin/app/shared/widgets/custom_cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../exports.dart';

class CommentCard extends StatelessWidget {
  final CommentModel commentModel;
  final DoctorModel currentDoctorModel;
  final Function() onDelete;
  const CommentCard({
    super.key,
    required this.commentModel,
    required this.currentDoctorModel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      // Backgrond color
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0.8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: AppColors.subBG, // Splash color
        onLongPress: () {
          if (commentModel.doctor!.id.toString() ==
              currentDoctorModel.id.toString()) {
            showCustomDialog(
                context: context,
                title: 'Delete',
                description: 'Are you sure to delete comment?',
                noColoredButtonOnTap: () {
                  Navigator.of(context).pop();

                  onDelete();
                },
                coloredButtonText: 'Cancel',
                noColoredButtonText: 'Delete',
                isNoColorShow: true,
                coloredButtonOnTap: () => Navigator.of(context).pop());
          }
        },
        onTap: () {},
        child: Container(
          width: 300.w,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  //   backgroundColor: AppColors.subBG,
                  //   radius: 20,
                  //   child: Text(
                  //     '${capitalizeFirstText(commentModel.doctor!.firstName![0])}${capitalizeFirstText(commentModel.doctor!.lastName![0])}',
                  //     style: const TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: AppColors.primary,
                  //         fontSize: 14),
                  //   ),
                  // ),
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
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.primary.withOpacity(0.8),
                        child: commentModel.doctor!.id == null
                            ? Text(
                                commentModel.doctor!.firstName![0]
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              )
                            : CustomCachedNetworkImage(
                                imageUrl: commentModel.doctor!.image.toString(),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Dr.${capitalizeFirstText(commentModel.doctor!.firstName!)} ${capitalizeFirstText(commentModel.doctor!.lastName!)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.title,
                                        fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      commentModel.content!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.6,
                        wordSpacing: 2,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeago.format(
                        DateTime.parse(commentModel.updatedAt.toString())),
                    style: const TextStyle(
                      color: AppColors.description,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // IconButton(
                  //   highlightColor:
                  //       Colors.transparent,
                  //   splashColor:
                  //       Colors.transparent,
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.favorite_border,
                  //     size: 30,
                  //     color: Colors.black45,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
