import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;

  const CachedImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.none, // Ускоряет загрузку
    );
  }
}

// Функция для предзагрузки изображений
void preloadImages(BuildContext context, List<String> imagePaths) {
  for (var imagePath in imagePaths) {
    precacheImage(AssetImage(imagePath), context);
  }
}
