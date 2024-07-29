import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thank_you_pro/theme/styles.dart';
import 'package:thank_you_pro/utils/strings/strings.dart';
import 'package:thank_you_pro/utils/widgets/my_appbar.dart';
import 'package:thank_you_pro/utils/widgets/my_header.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

List<String> images = [
  "https://www.arcprint.in/assets/media/products_common_imgs/greetings-card/1.jpg?ver=4.3.5",
  "https://printify.com/wp-content/uploads/2023/01/Custom-Greeting-Cards-Print-On-Demand.jpg",
  "https://urbanplatter.in/wp-content/uploads/2022/10/12658-02.jpg",
  "https://files.printo.in/site/20211224_145712214863_4cec86_greeting-card-2.jpg",
  "https://i.etsystatic.com/14746885/r/il/95f95d/4384513755/il_1080xN.4384513755_6pml.jpg",
  Strings.wedding,
  Strings.birthday,
  Strings.anniversary,
];

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Shuffle images for the carousel
    List<String> carouselImages = List.from(images)..shuffle();

    // Shuffle images for each ListView
    List<String> birthdayImages = List.from(images)..shuffle();
    List<String> anniversaryImages = List.from(images)..shuffle();
    List<String> weddingImages = List.from(images)..shuffle();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Card Stand",
              style: TextStyle(
                  fontSize: 40,
                  color: Styles.primary,
                  fontFamily: Strings.appFontSecondary,
                  fontWeight: FontWeight.w600,
                  height: 1),
            ),
            Text(
              "Our Art - Your Occasion".toUpperCase(),
              style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: Styles.primary,
                  fontFamily: Strings.appFontThird,
                  height: 1,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: carouselImages
                  .length, // Adjust the count based on how many items you want to show.
              itemBuilder: (context, index, realIndex) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      // context.go('/bottomNav/videoData');
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            imageUrl: carouselImages[index],
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor:
                                  const Color.fromARGB(255, 90, 50, 50),
                              child: Container(
                                width: 80.w,
                                height: 60.h,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error), // Add an error widget
                            fit: BoxFit.cover,
                            width: 80.w,
                            height: 60.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                padEnds: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                viewportFraction: 0.8,
                autoPlay: true,
                height: 60.h,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOut,
                pauseAutoPlayOnTouch: true,
                enlargeCenterPage: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MyHeader(text: "Happy Birthday"),
            ),
            SizedBox(
              height: 170,
              width: 100.w,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 40,
                        color: Styles.primary.withOpacity(0.3),
                      ),
                    ],
                  );
                },
                shrinkWrap: true,
                itemCount: birthdayImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      birthdayImages[index],
                      fit: BoxFit.cover,
                      width: 160,
                      height: 150,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MyHeader(text: "Anniversary Cards"),
            ),
            SizedBox(
              height: 170,
              width: 100.w,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 40,
                        color: Styles.primary.withOpacity(0.3),
                      ),
                    ],
                  );
                },
                shrinkWrap: true,
                itemCount: anniversaryImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      anniversaryImages[index],
                      fit: BoxFit.cover,
                      width: 160,
                      height: 150,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MyHeader(text: "Wedding Cards"),
            ),
            SizedBox(
              height: 170,
              width: 100.w,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 40,
                        color: Styles.primary.withOpacity(0.3),
                      ),
                    ],
                  );
                },
                shrinkWrap: true,
                itemCount: weddingImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      weddingImages[index],
                      fit: BoxFit.cover,
                      width: 160,
                      height: 150,
                    ),
                  );
                },
              ),
            ),
            const Gap(200),
          ],
        ),
      ),
    );
  }
}
