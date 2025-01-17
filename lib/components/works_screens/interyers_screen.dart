import 'package:flutter/material.dart';
import 'package:kork_studio/routes/pages/detail_image_page.dart';
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
    ];

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

            // Определяем список изображений для этого проекта
            List<String> relatedImages = [];
            if (imageUrl == IntUrls.int1_1) {
              relatedImages = IntUrls.i1; // Список изображений для int1_1
            } else if (imageUrl == IntUrls.int2_1) {
              relatedImages = IntUrls.i2; // Список изображений для int2_1
            }

            return GestureDetector(
              onTap: () {
                // Передаем в DetailImagePage нужный список изображений
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailImagePage(
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
                  Image.network(
                    imageUrl, // Загружаем изображение по URL
                    fit: BoxFit.cover,
                  ),

                  // Показать затемнение при наведении (если нужно)
                  // можно добавить эффект при наведении
                ],
              ),
            );
          },
          childCount: imageUrls.length,
        ),
      ),
    );
  }
}
