import '../../../../exports.dart';

class HomeSearchBotton extends StatelessWidget {
  const HomeSearchBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // todo: go to search page
      },
      child: SizedBox(
        height: 55,
        child: TextField(
          // controller: controller.searchController,
          cursorColor: AppColors.primary,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            hintText: '${AppStrings.search}...',
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
