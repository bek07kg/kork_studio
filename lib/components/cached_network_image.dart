import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kork_studio/components/animations/shining_logo.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
  });

  // Метод для предзагрузки изображения в кэш
  Future<void> _loadImage(BuildContext context) async {
    await precacheImage(CachedNetworkImageProvider(imageUrl), context);
  }

  @override
  Widget build(BuildContext context) {
    // Используем FutureBuilder для асинхронной предзагрузки изображения
    return FutureBuilder(
      future: _loadImage(context), // Предзагружаем изображение
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Плейсхолдер, пока изображение загружается
          return Center(child: ShiningLogo());
        } else if (snapshot.hasError) {
          // Ошибка при загрузке изображения
          return Icon(Icons.error, color: Colors.red);
        } else {
          // Изображение загружено или уже в кэше
          return CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: ShiningLogo()),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: Colors.red),
          );
        }
      },
    );
  }
}
