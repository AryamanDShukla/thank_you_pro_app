import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thank_you_pro/utils/strings/strings.dart';
import 'package:thank_you_pro/utils/widgets/my_appbar.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavouritesScreenState();
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

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: "My Favourites"),
      body: GridView.builder(
        itemCount: images.length,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
              width: 160,
              height: 150,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
