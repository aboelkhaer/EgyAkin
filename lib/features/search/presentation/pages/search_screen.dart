import '../../../../exports.dart';

class SearchScreen extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;

  const SearchScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
  });

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = SearchCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cubit.getSearchHome();
        },
        child: const Icon(
          Icons.search,
        ),
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
                      cubit.getSearchHome();
                    },
                    decoration: InputDecoration(
                      hintText: '${AppStrings.search}...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => cubit.searchController.clear(),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      prefixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
                              ? AppColors.primary
                              : Colors.grey),
                      suffixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
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
              ],
            ),
          ),
          Row(
            children: [
              const Expanded(child: Divider()),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const Text(
                          '0',
                          style: TextStyle(
                            color: AppColors.description,
                          ),
                        );
                      },
                      loaded: (patients) {
                        return Text(
                          patients!.length.toString(),
                          style: TextStyle(
                            color: patients.isEmpty
                                ? AppColors.description
                                : Colors.green,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_off_outlined,
                            size: 40,
                            color: AppColors.primary,
                          ),
                          SizedBox(
                            height: size.height * 0.2,
                          )
                        ],
                      ),
                    );
                  },
                  loading: () {
                    return const ShimmerLoadingPatientsCards(
                        ishorizontal: false);
                  },
                  loaded: (patients) {
                    return ListView.builder(
                      itemCount: patients!.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(
                        left: 30,
                        top: 8,
                        right: size.width * 0.09,
                        bottom: 50,
                      ),
                      itemBuilder: (context, index) {
                        PatientHomeDataModel patient = patients[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: VerticalPatientCard(
                            patientName: patient.name ?? AppStrings.empty,
                            updatedAt: patient.updatedAt ?? AppStrings.empty,
                            drFirstName:
                                patient.doctor!.firstName ?? AppStrings.empty,
                            drLastName:
                                patient.doctor!.lastName ?? AppStrings.empty,
                            hospital: patient.hospital ?? AppStrings.empty,
                            submitStatus: patient.sections == null
                                ? false
                                : patient.sections!.submitStatus ?? false,
                            isOutcomeStatus: patient.sections!.outcomeStatus!,
                            onOutcomeTap: () {
                              //   Get.toNamed(
                              //   AppRoutes.outcome,
                              //   arguments: [
                              //     patient.sections!.outcomeStatus,
                              //     patient.id,
                              //     patient.name
                              //   ],
                              // ),
                            },
                            onAddCommentTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.comments,
                                arguments:
                                    AppRoutesArgs.patientCommentsRouteArgs(
                                  patientId: patient.id.toString(),
                                  currentDoctorModel: currentDoctorModel,
                                  verified: accountVerification,
                                ),
                              );
                            },
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.patientSections,
                                arguments:
                                    AppRoutesArgs.patientSectionsRouteArguments(
                                  patientId: patient.id.toString(),
                                  currentDoctorId:
                                      currentDoctorModel.id.toString(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
