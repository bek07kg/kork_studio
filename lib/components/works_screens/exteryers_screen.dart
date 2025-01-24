import 'package:flutter/material.dart';
import 'package:kork_studio/components/cached_network_image.dart';
import 'package:kork_studio/components/works_screens/detail_image_screen.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/urls/ext_urls.dart';

class ExteryersScreen extends StatelessWidget {
  const ExteryersScreen({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    // Список URL-адресов изображений для отображения в сетке
    final List<String> imageUrls = [
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

      // Добавь сюда все остальные изображения, например, ExtUrls.ext3_1, и так далее
    ];

    // Создаём Map, где ключом будет индекс, а значением список изображений для этого индекса
    final Map<String, List<String>> relatedImagesMap = {
      ExtUrls.ext1_1: ExtUrls.e1, // Список изображений для ext1_1
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
      ExtUrls.ext14_1: ExtUrls.e14,
      ExtUrls.ext15_1: ExtUrls.e15,
      ExtUrls.ext16_1: ExtUrls.e16,
      ExtUrls.ext17_1: ExtUrls.e17,
      ExtUrls.ext18_1: ExtUrls.e18,
      ExtUrls.ext19_1: ExtUrls.e19,
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
