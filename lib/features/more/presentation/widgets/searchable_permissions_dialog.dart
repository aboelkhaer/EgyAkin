import '../../../../exports.dart';

Future<void> showSearchablePermissionsDialog(
  BuildContext context, {
  required List<String> permissions,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return _SearchablePermissionsDialog(permissions: permissions);
    },
  );
}

class _SearchablePermissionsDialog extends StatefulWidget {
  final List<String> permissions;

  const _SearchablePermissionsDialog({required this.permissions});

  @override
  State<_SearchablePermissionsDialog> createState() =>
      _SearchablePermissionsDialogState();
}

class _SearchablePermissionsDialogState
    extends State<_SearchablePermissionsDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _filteredPermissions {
    if (_query.isEmpty) return widget.permissions;
    return widget.permissions
        .where((p) => p.toLowerCase().contains(_query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final surfaceColor =
            isDarkMode ? AppColors.darkCardBG : Colors.white;
        final titleColor =
            isDarkMode ? AppColors.darkTitle : AppColors.title;
        final subtitleColor =
            isDarkMode ? AppColors.darkDescription : Colors.grey.shade600;
        final filtered = _filteredPermissions;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          backgroundColor: surfaceColor,
          title: Text(
            context.tr(AppStrings.currentUserPermissions),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: titleColor,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  title: context.tr(AppStrings.searchPermissions),
                  textFormFieldController: _searchController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  validator: (_) => null,
                  onChanged: (_) {},
                ),
                SizedBox(height: 8.h),
                Text(
                  _query.isEmpty
                      ? '${widget.permissions.length} ${context.tr(AppStrings.permissionsTotal)}'
                      : '${filtered.length} / ${widget.permissions.length}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: subtitleColor,
                  ),
                ),
                SizedBox(height: 10.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.45,
                  ),
                  child: filtered.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Text(
                              context.tr(AppStrings.noPermissionsMatchSearch),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: subtitleColor,
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => SizedBox(height: 6.h),
                          itemBuilder: (context, index) {
                            return Text(
                              '${index + 1}. ${filtered[index]}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                height: 1.35,
                                color: titleColor,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                title: context.tr(AppStrings.close),
              ),
            ),
          ],
          actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        );
      },
    );
  }
}
