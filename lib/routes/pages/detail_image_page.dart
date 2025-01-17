import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';

class DetailImagePage extends StatelessWidget {
  final String imagePath; // Путь к изображению
  final List<String>
      relatedImages; // Список других изображений, связанных с текущим

  const DetailImagePage({
    super.key,
    required this.imagePath,
    required this.relatedImages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Вертикальная прокрутка всех изображений
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                child: Column(
                  children: [
                    // Основное изображение с возможностью увеличения
                    InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(double.infinity),
                      minScale: 1.0,
                      maxScale: 5.0,
                      panEnabled: true,
                      child: Center(
                        child: Image.network(
                          imagePath,
                          width: double.infinity, // Растягиваем на весь экран
                          height: 300, // Устанавливаем фиксированную высоту
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Галерея с другими изображениями
                    ...relatedImages.map((relatedImage) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Когда пользователь нажимает на изображение, открывается его в полный размер
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailImagePage(
                                  imagePath: relatedImage,
                                  relatedImages: relatedImages,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            relatedImage,
                            width: double.infinity, // Растягиваем на весь экран
                            height: 300, // Все изображения одинакового размера
                            fit: BoxFit
                                .cover, // Обеспечиваем обрезку по пропорциям
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
          // Кнопка для закрытия страницы
          Positioned(
            top: 40,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.close,
                  color: AppColors.black,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
