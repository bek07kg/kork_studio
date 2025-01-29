import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kork_studio/components/cached_network_image.dart';
import 'package:kork_studio/components/works_screens/detail_image_screen.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/urls/con_urls.dart';
import 'package:kork_studio/urls/ext_urls.dart';
import 'package:kork_studio/urls/int_urls.dart';

class AllScreens extends StatefulWidget {
  const AllScreens({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<AllScreens> createState() => _AllScreensState();
}

class _AllScreensState extends State<AllScreens> {
  final List<String> imageUrls = [
    ConUrls.con1_1,
    ConUrls.con2_1,
    ExtUrls.ext1_1,
    ExtUrls.ext2_1,
    ExtUrls.ext3_1,
    ExtUrls.ext4_1,
    ExtUrls.ext5_1,
    ExtUrls.ext6_1,
    ExtUrls.ext7_1,
    ExtUrls.ext8_1,
    ExtUrls.ext9_1,
    ExtUrls.ext10_1,
    ExtUrls.ext11_1,
    ExtUrls.ext12_1,
    ExtUrls.ext13_1,
    ExtUrls.ext14_1,
    ExtUrls.ext15_1,
    ExtUrls.ext16_1,
    ExtUrls.ext17_1,
    ExtUrls.ext18_1,
    ExtUrls.ext19_1,
    IntUrls.int1_1,
    IntUrls.int2_1,
    IntUrls.int3_1,
    IntUrls.int4_1,
    IntUrls.int5_1,
    IntUrls.int6_1,
    IntUrls.int7_1,
    IntUrls.int8_1,
    IntUrls.int9_1,
  ];

  final Map<String, List<String>> relatedImagesMap = {
    ConUrls.con1_1: ConUrls.c1,
    ConUrls.con2_1: ConUrls.c2,
    ExtUrls.ext1_1: ExtUrls.e1,
    ExtUrls.ext2_1: ExtUrls.e2,
    ExtUrls.ext3_1: ExtUrls.e3,
    ExtUrls.ext4_1: ExtUrls.e4,
    ExtUrls.ext5_1: ExtUrls.e5,
    ExtUrls.ext6_1: ExtUrls.e6,
    ExtUrls.ext7_1: ExtUrls.e7,
    ExtUrls.ext8_1: ExtUrls.e8,
    ExtUrls.ext9_1: ExtUrls.e9,
    ExtUrls.ext10_1: ExtUrls.e10,
    ExtUrls.ext11_1: ExtUrls.e11,
    ExtUrls.ext12_1: ExtUrls.e12,
    ExtUrls.ext13_1: ExtUrls.e13,
    ExtUrls.ext16_1: ExtUrls.e16,
    ExtUrls.ext17_1: ExtUrls.e17,
    ExtUrls.ext18_1: ExtUrls.e18,
    ExtUrls.ext19_1: ExtUrls.e19,
    IntUrls.int1_1: IntUrls.i1,
    IntUrls.int2_1: IntUrls.i2,
    IntUrls.int3_1: IntUrls.i3,
    IntUrls.int4_1: IntUrls.i4,
    IntUrls.int5_1: IntUrls.i5,
    IntUrls.int6_1: IntUrls.i6,
    IntUrls.int7_1: IntUrls.i7,
    IntUrls.int8_1: IntUrls.i8,
    IntUrls.int9_1: IntUrls.i9,
  };

  void _preloadImages(List<String> imageUrls) async {
    final futures = imageUrls.map((url) async {
      try {
        await CachedNetworkImageProvider(url)
            .evict(); // Эвикация изображения из кэша
      } catch (error) {
        print("Ошибка при эвикации изображения: $url");
      }
    }).toList();

    await Future.wait(futures); // Загружаем все изображения параллельно
  }

  @override
  void initState() {
    super.initState();
    _preloadImages(imageUrls); // Передаём список всех URL картинок
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: widget.screenWidth < 600
          ? const EdgeInsets.symmetric(horizontal: 5, vertical: 30)
          : const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.screenWidth < 600 ? 1 : 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 3 / 2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            String imageUrl = imageUrls[index];
            List<String> relatedImages = relatedImagesMap[imageUrl] ?? [];
            bool isHovered = false;

            return StatefulBuilder(
              builder: (context, setState) => MouseRegion(
                onEnter: (_) {
                  setState(() => isHovered = true);
                },
                onExit: (_) {
                  setState(() => isHovered = false);
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailImageScreen(
                          imagePath: imageUrl,
                          relatedImages: relatedImages,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedImageWidget(imageUrl: imageUrl),
                      if (isHovered)
                        Container(
                          color: AppColors.appBarIconColor.withOpacity(0.9),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: imageUrls.length,
        ),
      ),
    );
  }
}
