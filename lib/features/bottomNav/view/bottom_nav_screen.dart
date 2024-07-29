import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:thank_you_pro/features/favourites/view/favourites_screen.dart';
import 'package:thank_you_pro/features/home/view/home_screen.dart';
import 'package:thank_you_pro/features/occasions/view/occasions_screen.dart';
import 'package:thank_you_pro/features/profile/view/profile_screen.dart';
import 'package:thank_you_pro/theme/styles.dart';
import 'package:thank_you_pro/utils/strings/route_strings.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    CupertinoIcons.home,
    CupertinoIcons.calendar,
    CupertinoIcons.heart,
    CupertinoIcons.profile_circled,
  ];
  final navItems = <String>[
    "Home",
    "Occasions",
    "Favourites",
    "Profile",
  ];
  final pages = <Widget>[
    const HomeScreen(),
    const OccasionsScreen(),
    const FavouritesScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_bottomNavIndex],
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Styles.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Image.asset(
          'assets/icons/random-line.png',
          height: 25,
          color: Colors.white,
        ),
        onPressed: () {
          _fabAnimationController.reset();
          _borderRadiusAnimationController.reset();
          _borderRadiusAnimationController.forward();
          _fabAnimationController.forward();
          context.go('/${Routes.bottomNav}/${Routes.drawingBoard}');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: navItems.length,
        tabBuilder: (int index, bool isActive) {
          final color =
              isActive ? Styles.primary : Styles.blackColor.withOpacity(0.2);
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  navItems[index],
                  maxLines: 1,
                  style: Styles.mediumBoldText(context).copyWith(color: color),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        splashColor: Colors.red,
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.softEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 30,
          spreadRadius: 10,
          color: Colors.black26,
        ),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  const NavigationScreen(this.iconData, {super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColorsTheme>()!;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          const SizedBox(height: 64),
          Center(
            child: CircularRevealAnimation(
              animation: animation,
              centerOffset: const Offset(80, 80),
              maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
              child: Icon(
                widget.iconData,
                color: colors.activeNavigationBarColor,
                size: 160,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class CustomColorsTheme extends ThemeExtension<CustomColorsTheme> {
  const CustomColorsTheme({
    required this.bottomNavigationBarBackgroundColor,
    required this.colorLabelColor,
    required this.activeNavigationBarColor,
    required this.notActiveNavigationBarColor,
    required this.shadowNavigationBarColor,
  });

  final Color bottomNavigationBarBackgroundColor;
  final Color colorLabelColor;
  final Color activeNavigationBarColor;
  final Color notActiveNavigationBarColor;
  final Color shadowNavigationBarColor;

  @override
  CustomColorsTheme copyWith({
    Color? bottomNavigationBarBackgroundColor,
    Color? colorLabelColor,
    Color? activeNavigationBarColor,
    Color? notActiveNavigationBarColor,
    Color? shadowNavigationBarColor,
  }) {
    return CustomColorsTheme(
      bottomNavigationBarBackgroundColor: bottomNavigationBarBackgroundColor ??
          this.bottomNavigationBarBackgroundColor,
      colorLabelColor: colorLabelColor ?? this.colorLabelColor,
      activeNavigationBarColor:
          activeNavigationBarColor ?? this.activeNavigationBarColor,
      notActiveNavigationBarColor:
          notActiveNavigationBarColor ?? this.notActiveNavigationBarColor,
      shadowNavigationBarColor:
          shadowNavigationBarColor ?? this.shadowNavigationBarColor,
    );
  }

  @override
  CustomColorsTheme lerp(
    ThemeExtension<CustomColorsTheme>? other,
    double t,
  ) {
    if (other is! CustomColorsTheme) {
      return this;
    }
    return CustomColorsTheme(
      bottomNavigationBarBackgroundColor: Color.lerp(
              bottomNavigationBarBackgroundColor,
              other.bottomNavigationBarBackgroundColor,
              t) ??
          bottomNavigationBarBackgroundColor,
      colorLabelColor: Color.lerp(colorLabelColor, other.colorLabelColor, t) ??
          colorLabelColor,
      activeNavigationBarColor: Color.lerp(
              activeNavigationBarColor, other.activeNavigationBarColor, t) ??
          activeNavigationBarColor,
      notActiveNavigationBarColor: Color.lerp(notActiveNavigationBarColor,
              other.notActiveNavigationBarColor, t) ??
          notActiveNavigationBarColor,
      shadowNavigationBarColor: Color.lerp(
              shadowNavigationBarColor, other.shadowNavigationBarColor, t) ??
          shadowNavigationBarColor,
    );
  }
}
