import 'package:egy_akin/app/shared/functions/doctor_name.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';

import '../../../../exports.dart';

class SendConsultationScreen extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  const SendConsultationScreen(
      {super.key,
      required this.homeDataModel,
      required this.currentDoctorModel});

  @override
  Widget build(BuildContext context) {
    SendConsultationCubit cubit = SendConsultationCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Consultation',
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50.w,
            width: 50.w,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: () {
                cubit.getConsultationSearch();
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 25.r,
              ),
            ),
          ),
          // BlocBuilder<SendConsultationCubit, SendConsultationState>(
          //   builder: (context, state) {
          //     return state.maybeWhen(
          //       orElse: () {
          //         return const SizedBox.shrink();
          //       },
          //       loaded: (isSearching, isSearched, message, response) {
          //         if (cubit.doctorsIds.isNotEmpty) {
          //           return Column(
          //             children: [
          //               SizedBox(height: 10.h),
          //               FadeIn(
          //                 duration: const Duration(milliseconds: 800),
          //                 child: SizedBox(
          //                   height: 50.w,
          //                   width: 50.w,
          //                   child: FloatingActionButton(
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(50.0),
          //                     ),
          //                     onPressed: () {
          //                       // Action for second FAB
          //                     },
          //                     child: Icon(
          //                       Icons.send,
          //                       color: Colors.white,
          //                       size: 20.r,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           );
          //         }
          //         return const SizedBox.shrink();
          //       },
          //     );
          //   },
          // ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: cubit.searchController,
                    cursorColor: AppColors.primary,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onFieldSubmitted: (value) {
                      // cubit.getSearchHome();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search with doctor name or email...',
                      hintStyle: TextStyle(fontSize: 11.sp),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => cubit.searchController.clear(),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? AppColors.primary
                              : Colors.grey),
                      suffixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? AppColors.primary
                              : Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                    autofocus: true,
                  ),
                ),
                SizedBox(height: 16.h),
                // Column(
                //   children: [
                //     const Row(
                //       children: [
                //         Expanded(child: Divider()),
                //       ],
                //     ),
                //     SizedBox(height: 5.h),
                //     SizedBox(height: 5.h),
                //     const Row(
                //       children: [
                //         Expanded(child: Divider()),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          BlocBuilder<SendConsultationCubit, SendConsultationState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Expanded(
                    child: SingleChildScrollView(
                      child: ShimmerLoadingPatientsCards(ishorizontal: false),
                    ),
                  );
                },
                loaded: (isSearching, isSearched, message, response) {
                  if (isSearching) {
                    return const Expanded(
                      child: SingleChildScrollView(
                        child: ShimmerLoadingPatientsCards(ishorizontal: false),
                      ),
                    );
                  }
                  if (isSearched) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: response!.data!.length,
                        itemBuilder: (context, index) {
                          var doctorModel = response.data![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 8),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    spreadRadius: 2,
                                                    blurRadius: 9,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80.r),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    navigatorKey.currentState
                                                        ?.pushNamed(
                                                      AppRoutes.doctorInfoView,
                                                      arguments: AppRoutesArgs
                                                          .doctorInfoViewRouteArgs(
                                                        doctorId: doctorModel.id
                                                            .toString(),
                                                        currentDoctorModel:
                                                            currentDoctorModel,
                                                        isSyndicateCardRequired:
                                                            homeDataModel
                                                                .isSyndicateCardRequired!,
                                                        homeDataModel:
                                                            homeDataModel,
                                                        accountVerification:
                                                            homeDataModel
                                                                    .verified ??
                                                                true,
                                                        currentDoctorRole:
                                                            homeDataModel.role!,
                                                        currentDoctorPoints: int
                                                            .parse(homeDataModel
                                                                .scoreValue!),
                                                      ),
                                                    );
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 20.r,
                                                    backgroundColor: AppColors
                                                        .primary
                                                        .withOpacity(0.8),
                                                    child: doctorModel.image ==
                                                            null
                                                        ? Text(
                                                            doctorModel
                                                                .firstName![0]
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    16.sp),
                                                          )
                                                        : CustomCachedNetworkImage(
                                                            imageUrl:
                                                                doctorModel
                                                                    .image
                                                                    .toString(),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      doctorName(
                                                        firstName: doctorModel
                                                            .firstName,
                                                        lastName: doctorModel
                                                            .lastName,
                                                        role: '',
                                                      ),
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      doctorModel.email ?? '',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
