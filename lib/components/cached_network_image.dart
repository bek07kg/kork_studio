import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kork_studio/components/animations/shining_logo.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          Center(child: ShiningLogo()), // Анимация во время загрузки
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red), // Иконка при ошибке
    );
  }
}
