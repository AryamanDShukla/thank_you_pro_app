import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:thank_you_pro/theme/styles.dart';
import 'package:thank_you_pro/utils/strings/strings.dart';
import 'package:thank_you_pro/utils/widgets/my_header.dart';
import 'package:thank_you_pro/utils/widgets/my_textfield.dart';
import 'dart:math';

class OccasionsScreen extends ConsumerStatefulWidget {
  const OccasionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OccasionsScreenState();
}

List<String> images = [
  "https://www.arcprint.in/assets/media/products_common_imgs/greetings-card/1.jpg?ver=4.3.5",
  "https://printify.com/wp-content/uploads/2023/01/Custom-Greeting-Cards-Print-On-Demand.jpg",
  "https://urbanplatter.in/wp-content/uploads/2022/10/12658-02.jpg",
  "https://files.printo.in/site/20211224_145712214863_4cec86_greeting-card-2.jpg",
  "https://i.etsystatic.com/14746885/r/il/95f95d/4384513755/il_1080xN.4384513755_6pml.jpg",
];
List<String> occasions = [
  "Birthday Greetings",
  "Anniversary Cards",
  "Wedding Cards",
];

class _OccasionsScreenState extends ConsumerState<OccasionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: MyTextField(
          controller: TextEditingController(),
          hintText: "Search",
          prefixIconData: const Icon(Icons.search),
          hasPrefix: true,
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: occasions.length,
          padding: const EdgeInsets.only(bottom: 200),
          itemBuilder: (context, index) {
            // Shuffle images to display them randomly
            List<String> shuffledImages = List.from(images)..shuffle();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyHeader(text: occasions[index]),
                ),
                GridView.custom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: index.isEven
                        ? [
                            const QuiltedGridTile(2, 2),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 1),
                          ]
                        : [
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(2, 2),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 1),
                          ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: shuffledImages.length,
                    (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          shuffledImages[index],
                          fit: BoxFit.cover,
                          width: 160,
                          height: 150,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
