import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../exports.dart';

void showCustomeBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    bounce: true,
    expand: true,
    duration: const Duration(milliseconds: 300),
    builder: (context) => builder(context),
  );
}
