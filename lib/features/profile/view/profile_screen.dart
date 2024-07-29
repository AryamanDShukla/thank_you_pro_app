import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thank_you_pro/theme/styles.dart';
import 'package:thank_you_pro/utils/strings/icon_strings.dart';
import 'package:thank_you_pro/utils/strings/strings.dart';
import 'package:thank_you_pro/utils/widgets/my_appbar.dart';
import 'package:thank_you_pro/utils/widgets/my_icon_and_text.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: myAppBar(context: context, title: "Hello Rahul,"),
      body: Column(children: [
        SizedBox(
          width: 100.w,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100.w,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(IconStrings.dummyDp),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 100.w,
                height: 300,
                color: Colors.black.withOpacity(0.3),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  width: 100.w,
                  height: 300,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(30),
                  ClipOval(
                    child: Image.network(
                      IconStrings.dummyDp,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'Shamola Rathod',
                    style: Styles.mediumBoldText(context).copyWith(
                      fontFamily: Strings.appFontSecondary,
                      fontSize: 35,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  Text(
                    'Creative Editor'.toUpperCase(),
                    style: Styles.mediumBoldText(context).copyWith(
                      fontFamily: Strings.appFontThird,
                      fontSize: 10,
                      letterSpacing: 5,
                      color: Colors.white,
                      height: 1,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 100.w,
            // height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        "My Artwork",
                        style: Styles.mediumBoldText(context).copyWith(
                            color:
                                Theme.of(context).canvasColor.withOpacity(0.7),
                            fontSize: 12),
                      ),
                      Text(
                        "32",
                        style: Styles.mediumBoldText(context)
                            .copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      color: Theme.of(context).primaryColor,
                    )),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Text(
                        "Orders",
                        style: Styles.mediumBoldText(context).copyWith(
                            color:
                                Theme.of(context).canvasColor.withOpacity(0.7),
                            fontSize: 12),
                      ),
                      Text(
                        "20",
                        style: Styles.mediumBoldText(context)
                            .copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              MyIconAndText(
                imagePath: IconStrings.profile,
                text: "Profile Information",
                fontSize: 16,
                onTap: () async {
                  // Add your onTap functionality here
                },
              ),
              MyIconAndText(
                imagePath: IconStrings.share,
                text: "Share",
                fontSize: 16,
                onTap: () {
                  Share.share('Look what i found in Card Stand APP!');
                  // Add your onTap functionality here
                },
              ),
              MyIconAndText(
                imagePath: IconStrings.setting,
                text: "Settings",
                fontSize: 16,
                onTap: () async {
                  // Add your onTap functionality here
                },
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red.withOpacity(0.1),
                ),
                child: MyIconAndText(
                  imagePath: IconStrings.logout,
                  text: "Logout",
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  fontSize: 16,
                  onTap: () async {
                    context.go('/');
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
