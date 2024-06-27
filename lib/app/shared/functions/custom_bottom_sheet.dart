import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true, // Allow full height control
    builder: (context) {
      final mediaQuery = MediaQuery.of(context);
      final screenHeight = mediaQuery.size.height;
      final desiredHeight = screenHeight * 0.5; // Adjust the height as needed

      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.transparent,
          child: GestureDetector(
            onTap:
                () {}, // Prevents the bottom sheet from closing when tapping inside it
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Container(
                  width: double.infinity, // Full width
                  height: desiredHeight,
                  color: Colors.white,
                  child: builder(context),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
