import 'package:flutter/material.dart';
import 'package:kork_studio/components/appbar_widgets/onTap_icons.dart';
import 'package:kork_studio/components/appbar_widgets/onTap_texts.dart';
import 'package:kork_studio/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      foregroundColor:
          screenWidth < 600 ? AppColors.black : AppColors.appBarbgColor,
      backgroundColor: AppColors.appBarbgColor,
      expandedHeight: screenHeight * 0.3, // Меньшая высота AppBar
      floating: false,
      pinned: false,
      snap: false, // Полностью скрывается при прокрутке
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center, // Центрирование логотипа
          children: [
            // Боковые виджеты
            if (screenWidth >= 600)
              Positioned(
                left: 25,
                child: const OntapTexts(), // Текстовые кнопки слева
              ),
            if (screenWidth >= 600)
              Positioned(
                right: 25,
                child: const OntapIcons(), // Иконки справа
              ),
            // Логотип
            Center(
              child: Image.asset(
                "assets/images/KORK.png",
                height: screenWidth < 600
                    ? screenHeight *
                        0.1 // Уменьшенный логотип для маленьких экранов
                    : screenHeight * 0.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
