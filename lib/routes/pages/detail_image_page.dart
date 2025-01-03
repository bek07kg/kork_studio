import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';

class DetailImagePage extends StatelessWidget {
  final String imagePath; // Путь к изображению

  const DetailImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey, // Фон черный для выделения изображения
      body: Stack(
        children: [
          InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(double
                .infinity), // Позволяет двигать изображение без ограничений
            minScale: 1.0, // Минимальный масштаб (обычный размер)
            maxScale: 100.0, // Максимальный масштаб (увеличение до 100х)
            panEnabled: true, // Включает возможность перетаскивания изображения
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // Изображение по центру
              ),
            ),
          ),
          Positioned(
            top: 40, // Отступ сверху
            left: 20, // Отступ слева
            child: InkWell(
              onTap: () {
                Navigator.pop(context); // Возвращаемся на предыдущий экран
              },
              child: Container(
                padding: const EdgeInsets.all(8), // Отступы внутри кнопки
                child: const Icon(
                  Icons.close,
                  color: AppColors.white, // Белый крестик
                  size: 30, // Размер иконки
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
