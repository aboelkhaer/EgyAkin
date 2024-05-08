import 'package:egy_akin/app/shared/section_status_text.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../exports.dart';

class SectionCard extends StatelessWidget {
  final VoidCallback onTap;
  final String? updatedAt;
  final bool isSubmitStatus;
  final int index;
  final String sectionName;
  const SectionCard({
    super.key,
    required this.onTap,
    required this.updatedAt,
    required this.isSubmitStatus,
    required this.index,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Card(
          color: Colors.white, // Backgrond color
          elevation: 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: AppColors.subBG, // Splash color
            onTap: onTap,
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.subBG,
                        radius: 20,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 14),
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
                                      // Text(
                                      //   isSubmitStatus
                                      //       ? 'Completed'
                                      //       : 'Binding...',
                                      //   style: TextStyle(
                                      //     color: isSubmitStatus
                                      //         ? AppColors.primary
                                      //             .withOpacity(0.7)
                                      //         : Colors.amber,
                                      //     fontSize: 13,
                                      //   ),
                                      //   maxLines: 1,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                      SectionStatusText(
                                          isSubmitStatus: isSubmitStatus),
                                      Text(
                                        updatedAt == null
                                            ? ''
                                            : timeago
                                                .format(
                                                    DateTime.parse(updatedAt!))
                                                .toString(),
                                        style: const TextStyle(
                                          color: AppColors.description,
                                          fontSize: 10,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '',
                                    style: TextStyle(
                                      color: AppColors.description,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        sectionName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.title,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   child: Icon(
        //     isSubmitStatus ? AppIcons.isFinalSubmit : AppIcons.isFinalNotSubmit,
        //     color: isSubmitStatus
        //         ? AppColors.primary.withOpacity(0.7)
        //         : Colors.amber,
        //   ),
        // ),
      ],
    );
  }
}
