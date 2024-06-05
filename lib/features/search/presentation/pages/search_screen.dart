import '../../../../exports.dart';

class SearchScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;

  const SearchScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void dispose() {
    final cubit = context.read<SearchCubit>();
    if (!cubit.isClosed) {
      cubit.scrollController!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SearchCubit>();
    if (!cubit.isClosed) {
      cubit.scrollController = ScrollController();
      cubit.scrollController!.addListener(_onScroll);
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<SearchCubit>().scrollController.addListener(_onScroll);
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final cubit = context.read<SearchCubit>();
  //   if (!cubit.isClosed && cubit.scrollController.hasClients) {
  //     cubit.scrollController.dispose();
  //   }
  // }

  void _onScroll() {
    if (context.read<SearchCubit>().isLastPage) {
      return;
    } else {
      final maxScroll = context
          .read<SearchCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll =
          context.read<SearchCubit>().scrollController!.position.pixels;
      const threshold = 200.0;
      if (context.read<SearchCubit>().isLoadingMoreForScroll == false &&
          maxScroll - currentScroll <= threshold) {
        context.read<SearchCubit>().isLoadingMoreForScroll = true;

        context.read<SearchCubit>().loadMorePatients();
      }
    }
  }

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
                      loaded: (response, isSeeMore) {
                        return Text(
                          response!.data!.data!.length.toString(),
                          style: TextStyle(
                            color: response.data!.data!.isEmpty
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
                  loaded: (response, isSeeMore) {
                    return ListView.builder(
                      controller: cubit.scrollController,
                      itemCount: response!.data!.data!.length,
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
                        PatientHomeDataModel patient =
                            response.data!.data![index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: PatientCard(
                            patientName: patient.name ?? AppStrings.empty,
                            updatedAt: patient.updatedAt ?? AppStrings.empty,
                            doctorId: patient.doctor!.id.toString(),
                            drFirstName:
                                patient.doctor!.firstName ?? AppStrings.empty,
                            drLastName:
                                patient.doctor!.lastName ?? AppStrings.empty,
                            currnetDoctorId:
                                widget.currentDoctorModel.id.toString(),
                            hospital: patient.hospital ?? AppStrings.empty,
                            doctorImage: patient.doctor!.image,
                            submitStatus: patient.sections == null
                                ? false
                                : patient.sections!.submitStatus ?? false,
                            isOutcomeStatus: patient.sections!.outcomeStatus!,
                            onOutcomeTap: () {},
                            onAddCommentTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.comments,
                                arguments:
                                    AppRoutesArgs.patientCommentsRouteArgs(
                                  patientId: patient.id.toString(),
                                  currentDoctorModel: widget.currentDoctorModel,
                                  verified: widget.accountVerification,
                                  patientName: patient.name.toString(),
                                ),
                              );
                            },
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.patientSections,
                                arguments:
                                    AppRoutesArgs.patientSectionsRouteArguments(
                                  patientId: patient.id.toString(),
                                  currentDoctorModel: widget.currentDoctorModel,
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
          SizedBox(height: 10.h),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (data, isSeeMore) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isSeeMore
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                cubit.loadMorePatients();
                              },
                              child: const Text(
                                '',
                              ),
                            ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
