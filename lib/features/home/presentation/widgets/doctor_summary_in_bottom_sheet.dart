// import 'package:flutter/cupertino.dart';

// import '../../../../exports.dart';

// class DoctorSummaryInBottomSheet extends StatelessWidget {
//   final DoctorModel doctor;

//   const DoctorSummaryInBottomSheet({super.key, required this.doctor});

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         // middle: Text('Dr. ${doctor.firstName} ${doctor.lastName}'),
//         leading: CupertinoNavigationBarBackButton(
//           color: Colors.black, // Change the color here
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         trailing: GestureDetector(
//           onTap: () {},
//           child: Tooltip(
//             message: 'Request for consultation',
//             child: IconButton(
//               icon: const Icon(Icons.chat_bubble_outline),
//               onPressed: () {
//                 navigatorKey.currentState
//                     ?.pushNamed(AppRoutes.home, arguments: 2);
//               },
//             ),
//           ),
//         ),
//       ),
//       child: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 3),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.4),
//                         spreadRadius: 5,
//                         blurRadius: 9,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(80.r),
//                     child: CircleAvatar(
//                       radius: 40.r,
//                       backgroundColor: AppColors.primary.withOpacity(0.8),
//                       child: doctor.image == null
//                           ? Text(
//                               doctor.firstName == null
//                                   ? ''
//                                   : doctor.firstName![0].toUpperCase(),
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 16.sp),
//                             )
//                           : CustomCachedNetworkImage(
//                               imageUrl: doctor.image.toString(),
//                             ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Text(
//                   'Dr. ${capitalizeFirstText(doctor.firstName!)} ${doctor.lastName}',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
