// import 'dart:developer';

// import 'package:egy_akin/features/doctor_info_view/data/models/get_doctor_profile_score_history_model_response.dart';
// import 'package:egy_akin/features/doctor_info_view/presentation/cubit/doctor_info_view_state.dart';

// import '../../../../exports.dart';

// class ScoreContent extends StatefulWidget {
//   final String doctorId;
//   const ScoreContent({super.key, required this.doctorId});

//   @override
//   State<ScoreContent> createState() => _ScoreContentState();
// }

// class _ScoreContentState extends State<ScoreContent> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<DoctorInfoViewCubit>().getScoreHistory(widget.doctorId);

//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   if (context.read<DoctorInfoViewCubit>().isClosed) {
//     //     context.read<DoctorInfoViewCubit>().scrollController =
//     //         ScrollController();
//     //     context
//     //         .read<DoctorInfoViewCubit>()
//     //         .scrollController!
//     //         .addListener(_onScroll);
//     //   }
//     // });
//   }

//   // @override
//   // void dispose() {
//   //   if (context.read<DoctorInfoViewCubit>().isClosed) {
//   //     context.read<DoctorInfoViewCubit>().scrollController!.dispose();
//   //   }
//   //   super.dispose();
//   // }

//   // void _onScroll() {
//   //   if (context.read<DoctorInfoViewCubit>().isLastPage) {
//   //     return;
//   //   } else {
//   //     final maxScroll = context
//   //         .read<DoctorInfoViewCubit>()
//   //         .scrollController!
//   //         .position
//   //         .maxScrollExtent;
//   //     final currentScroll =
//   //         context.read<DoctorInfoViewCubit>().scrollController!.position.pixels;
//   //     const threshold = 200.0;
//   //     if (context.read<DoctorInfoViewCubit>().isLoadingMoreForScroll == false &&
//   //         maxScroll - currentScroll <= threshold) {
//   //       context.read<DoctorInfoViewCubit>().isLoadingMoreForScroll = true;

//   //       // context.read<DoctorInfoViewCubit>().loadMorePatients();
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     DoctorInfoViewCubit cubit = DoctorInfoViewCubit.get(context);
//     return Container(
//       color: Colors.white,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(height: 5.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 5.h,
//                 width: 60.w,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//               ),
//             ],
//           ),
//           SingleChildScrollView(
//             // controller: cubit.scrollController,
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//                   child: Row(
//                     children: [
//                       Text(
//                         'Score:',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp,
//                             color: Colors.grey.shade800),
//                       ),
//                     ],
//                   ),
//                 ),
//                 BlocConsumer<DoctorInfoViewCubit, DoctorInfoViewState>(
//                   listener: (context, state) {},
//                   builder: (context, state) {
//                     return state.maybeWhen(
//                       orElse: () {
//                         return const CircularProgressIndicator();
//                       },
//                       loaded: (doctorInfo, isLoadingScoreHistory,
//                           isLoadedScoreHistory, message, scoreHistory) {
//                         if (isLoadingScoreHistory) {
//                           return const CircularProgressIndicator();
//                         }
//                         if (isLoadedScoreHistory) {
//                           return ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: scoreHistory!.data!.data!.length,
//                             itemBuilder: (context, index) {
//                               ScoreModel scoreModel =
//                                   scoreHistory.data!.data![index];
//                               // return Container(
//                               //   padding: const EdgeInsets.all(20),
//                               //   child: Card(
//                               //     color: Colors.white,
//                               //     elevation: 0.8,
//                               //     shape: RoundedRectangleBorder(
//                               //       borderRadius: BorderRadius.circular(10),
//                               //     ),
//                               //     child: Container(
//                               //       padding: EdgeInsets.symmetric(
//                               //           horizontal: 16.w, vertical: 12.h),
//                               //       decoration: BoxDecoration(
//                               //         borderRadius: BorderRadius.circular(10),
//                               //         color: AppColors.primary.withOpacity(0.8),
//                               //       ),
//                               //       child: Column(
//                               //         mainAxisSize: MainAxisSize.min,
//                               //         children: [
//                               //           Row(
//                               //             children: [
//                               //               Text(
//                               //                 scoreModel.action.toString(),
//                               //                 style: const TextStyle(
//                               //                   fontWeight: FontWeight.bold,
//                               //                   color: Colors.white,
//                               //                 ),
//                               //               ),
//                               //             ],
//                               //           ),
//                               //         ],
//                               //       ),
//                               //     ),
//                               //   ),
//                               // );
//                               return const Text('hello');
//                             },
//                           );
//                         }
//                         return const SizedBox.shrink();
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
