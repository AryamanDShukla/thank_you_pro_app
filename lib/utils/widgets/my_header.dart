import 'package:flutter/material.dart';

import 'package:thank_you_pro/theme/styles.dart';

class MyHeader extends StatelessWidget {
  final String text;
  final double dividerWidth;
  final double dividerHeight;
  final bool removeViewAll;
  Function()? onViewAllPressed;

  MyHeader({
    super.key,
    required this.text,
    this.dividerWidth = 15.0,
    this.dividerHeight = 15.0,
    this.removeViewAll = false,
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: dividerWidth,
          height: dividerHeight,
          color: Styles.orangeColor,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: Styles.mediumBoldText(context)
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        removeViewAll
            ? const SizedBox()
            : TextButton(
                onPressed: onViewAllPressed,
                child: Text(
                  'View all',
                  style: Styles.smallBoldText(context),
                ))
      ],
    );
  }
}
