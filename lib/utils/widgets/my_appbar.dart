import 'package:flutter/material.dart';
import 'package:thank_you_pro/theme/styles.dart';
import 'package:thank_you_pro/utils/strings/strings.dart';

PreferredSize myAppBar(
    {required BuildContext context,
    required final String title,
    final Color? backgroundColor, // Make it nullable
    Color? foregroundColor,
    FontWeight? fontWeight,
    List<Widget>? action,
    PreferredSizeWidget? bottom,
    double? toolbarHeight,
    Widget? leading,
    double? leadingWidth,
    bool automaticallyImplyLeading = true}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leadingWidth: leadingWidth,
      leading: leading,
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor ?? Theme.of(context).canvasColor,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 30,
          color: Styles.primary,
          fontFamily: Strings.appFontSecondary,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
      ),
      actions: action ?? [],
      bottom: bottom,
    ),
  );
}
