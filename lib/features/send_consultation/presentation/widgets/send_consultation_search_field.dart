import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class SendConsultationSearchField extends StatelessWidget {
  final bool isDark;
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onClear;

  const SendConsultationSearchField({
    super.key,
    required this.isDark,
    required this.controller,
    required this.onSubmit,
    required this.onClear,
  });

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final border = HomeDashboardColors.border(isDark);
    final fill = HomeDashboardColors.cardBg(isDark);
    final subtitle = HomeDashboardColors.subtitle(isDark);
    final radius = BorderRadius.circular(14.r);

    OutlineInputBorder outline(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return SizedBox(
      height: 46.h,
      child: TextField(
        controller: controller,
        cursorColor: primary,
        style: TextStyle(
          fontSize: 13.sp,
          color: HomeDashboardColors.title(isDark),
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => _submit(),
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: fill,
          hintText: context.tr(AppStrings.searchByDoctorNameOrEmail),
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: subtitle,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 12.h,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20.sp,
            color: subtitle,
          ),
          suffixIconConstraints: BoxConstraints(
            minHeight: 46.h,
            minWidth: 46.w,
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) {
                return IconButton(
                  tooltip: context.tr(AppStrings.search),
                  onPressed: _submit,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    size: 18.sp,
                    color: primary,
                    textDirection: Directionality.of(context),
                  ),
                );
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: context.tr(AppStrings.clear),
                    onPressed: onClear,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.close_rounded,
                      size: 18.sp,
                      color: subtitle,
                    ),
                  ),
                  IconButton(
                    tooltip: context.tr(AppStrings.search),
                    onPressed: _submit,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.search_rounded,
                      size: 20.sp,
                      color: primary,
                    ),
                  ),
                ],
              );
            },
          ),
          border: outline(border),
          enabledBorder: outline(border),
          focusedBorder: outline(primary, width: 1.4),
          disabledBorder: outline(border),
          errorBorder: outline(border),
          focusedErrorBorder: outline(primary, width: 1.4),
        ),
      ),
    );
  }
}
