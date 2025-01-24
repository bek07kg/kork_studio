import 'package:flutter/material.dart';
import 'package:kork_studio/components/cached_network_image.dart';
import 'package:kork_studio/components/works_screens/detail_image_screen.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/urls/int_urls.dart';

class InteryersScreen extends StatelessWidget {
  const InteryersScreen({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    // Список URL-адресов изображений для отображения в сетке
    final List<String> imageUrls = [
      IntUrls.int1_1,
      IntUrls.int2_1,

      IntUrls.int3_1,
      IntUrls.int4_1,
      IntUrls.int5_1,
      IntUrls.int6_1,
      IntUrls.int7_1,
      IntUrls.int8_1,
      IntUrls.int9_1,

      // Добавь сюда все остальные изображения, например, ExtUrls.ext3_1, и так далее
    ];

    // Создаём Map, где ключом будет индекс, а значением список изображений для этого индекса
    final Map<String, List<String>> relatedImagesMap = {
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

    return SliverPadding(
      padding: screenWidth < 600
          ? const EdgeInsets.symmetric(horizontal: 5, vertical: 30)
          : const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth < 600 ? 1 : 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 3 / 2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            String imageUrl = imageUrls[index];

            // Получаем список связанных изображений по ключу (индексу)
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
                    // Передаем в DetailImagePage нужный список изображений
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailImageScreen(
                          imagePath: imageUrl, // Передаем первое изображение
                          relatedImages:
                              relatedImages, // Передаем список остальных изображений
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
