import 'package:flutter/material.dart';
import 'package:kork_studio/components/appbar_widgets/onTap_icons.dart';
import 'package:kork_studio/components/appbar_widgets/onTap_texts.dart';
import 'package:kork_studio/theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: screenWidth < 600
          ? AppColors.grey
          : null, // Цвет фона для мобильных экранов
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Отступы для улучшения восприятия
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            OntapTexts(), // Константный виджет
            OntapIcons(), // Константный виджет
          ],
        ),
      ),
    );
  }
}
