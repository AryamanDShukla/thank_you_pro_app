import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thank_you_pro/utils/strings/route_strings.dart';
import 'package:thank_you_pro/utils/strings/strings.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late double _fontSize;

  checkPost() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('auth_token') == null) {
    //   Timer(const Duration(seconds: 4), () {
    //     context.go('/${Routes.langSelection}');
    //   });
    // } else {

    Timer(const Duration(seconds: 3), () {
      context.go('/${Routes.bottomNav}');
    });

    // }
  }

  @override
  void initState() {
    super.initState();
    checkPost();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the font size based on the screen width
    _fontSize = screenWidth / 9; // Adjust the divisor to control font size

    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    Strings.title.toUpperCase(),
                    textStyle: TextStyle(
                      fontSize: _fontSize, // Use calculated font size
                      fontFamily: Strings.appFontPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                    speed: const Duration(seconds: 1),
                  ),
                ],
                isRepeatingAnimation: false,
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
