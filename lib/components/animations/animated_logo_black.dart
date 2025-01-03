import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';

class AnimatedLogoBlack extends StatelessWidget {
  final bool isLogoVisible;

  const AnimatedLogoBlack({
    super.key,
    required this.isLogoVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80, // Расположение логотипа
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300), // Время для анимации
        opacity: isLogoVisible ? 1.0 : 0.0, // Управляем видимостью
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              "assets/images/KORK.png",
              height: 50,
              color: AppColors.black, // Цвет логотипа
            ),
          ),
        ),
      ),
    );
  }
}
