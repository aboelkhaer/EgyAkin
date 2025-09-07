import '../../../../exports.dart';

class HomeSearchBotton extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final bool verified;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;
  const HomeSearchBotton({
    super.key,
    required this.currentDoctorModel,
    required this.verified,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (isVerifiedUser(isSyndicateCardRequired)) {
          navigatorKey.currentState?.pushNamed(
            AppRoutes.search,
            arguments: AppRoutesArgs.searchRouteArgs(
              currentDoctorModel: currentDoctorModel,
              verified: verified,
              isSyndicateCardRequired: isSyndicateCardRequired,
              currentDoctorRole: currentDoctorRole,
              currentDoctorPoints: currentDoctorPoints,
              homeDataModel: homeDataModel,
            ),
          );
        // } else {
        //   navigatorKey.currentState?.pushNamed(
        //     AppRoutes.communitySearch,
        //     arguments: AppRoutesArgs.communitySearchRouteArgs(
        //       currentDoctorModel: currentDoctorModel,
        //       homeDataModel: homeDataModel,
        //       initialValueInSearch: null,
        //     ),
        //   );
        // }
      },
      child: SizedBox(
        height: 55,
        child: TextField(
          cursorColor: AppColors.primary,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            hintText: '${context.tr(AppStrings.search)}...',
            
            // Add a clear button to the search bar
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {},
            ),
            // Add a search icon or button to the search bar
            prefixIcon: const Icon(
              Icons.search,
              // color: AppColors.primary,
            ),
            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? AppColors.primary
                    : Colors.grey),
            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
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
          enabled: false,
        ),
      ),
    );
  }
}
