import '../../../exports.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchHomeController controller = Get.put(SearchHomeController());
  late TextEditingController searchController;
  @override
  void initState() {
    initSearchControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  initSearchControllers() {
    searchController = TextEditingController();
  }

  disposeControllers() {
    searchController.dispose();
  }

  resetSearchForm() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.searchHome(searchText: searchController.text);
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
                  child: TextField(
                    controller: searchController,
                    cursorColor: AppColors.primary,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      hintText: '${AppStrings.search}...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => searchController.clear(),
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
              Obx(
                () => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    controller.patientSearchResult.length.toString(),
                    style: TextStyle(
                      color: controller.patientSearchResult.isEmpty
                          ? AppColors.description
                          : Colors.green,
                    ),
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Obx(
            () => controller.isSearchLoading.value
                ? const Expanded(
                    child: ShimmerLoadingPatientsCards(ishorizontal: false))
                : Expanded(
                    child: controller.patientSearchResult.isEmpty
                        ? Container(
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
                          )
                        : ListView.builder(
                            itemCount: controller.patientSearchResult.length,
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
                              BasePatientModel patient =
                                  controller.patientSearchResult[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: VerticalPatientCard(
                                  patientName: patient.name ?? AppStrings.empty,
                                  updatedAt:
                                      patient.updatedAt ?? AppStrings.empty,
                                  drFirstName: patient.doctorModel!.firstName ??
                                      AppStrings.empty,
                                  drLastName: patient.doctorModel!.lastName ??
                                      AppStrings.empty,
                                  hospital:
                                      patient.hospital ?? AppStrings.empty,
                                  submitStatus: patient.sections == null
                                      ? false
                                      : patient.sections!.submitStatus ?? false,
                                  isOutcomeStatus:
                                      patient.sections!.outcomeStatus!,
                                  onOutcomeTap: () => Get.toNamed(
                                    AppRoutes.outcome,
                                    arguments: [
                                      patient.sections!.outcomeStatus,
                                      patient.id,
                                      patient.name
                                    ],
                                  ),
                                  onAddCommentTap: () {
                                    Get.toNamed(
                                      AppRoutes.comments,
                                      arguments: [
                                        patient.id,
                                        patient.name,
                                      ],
                                    );
                                  },
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.patientSections,
                                      arguments: [
                                        patient.id,
                                        patient.doctorModel!.id,
                                        patient.name,
                                        patient.sections!.submitStatus,
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
