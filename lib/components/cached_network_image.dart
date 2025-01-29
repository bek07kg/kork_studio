import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;

  const CachedImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        imageUrl,
        fit: BoxFit
            .cover, // Масштабирует изображение, чтобы оно заполнило пространство
        filterQuality: FilterQuality
            .high, // Улучшение качества изображения при его растягивании
      ),
    );
  }
}
