import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:thank_you_pro/routes/routes.dart';
import 'package:thank_you_pro/theme/my_theme.dart';
import 'package:thank_you_pro/utils/strings/strings.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

const Color kCanvasColor = Color(0xfff2f3f7);

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

final themeProvider = StateProvider<bool>((ref) => false);

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(themeProvider);
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        routerConfig: myRoutes,
        title: Strings.title,
        theme: isDarkTheme ? MyThemes.darkTheme : MyThemes.lightThemes,
      );
    });
  }
}
