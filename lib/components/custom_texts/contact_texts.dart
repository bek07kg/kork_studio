import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/theme/app_texts.dart';

class ContactTexts extends StatelessWidget {
  const ContactTexts({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    // Определяем размер шрифта в зависимости от ширины экрана
    double fontSize = screenWidth < 600
        ? screenWidth * 0.040 // Увеличиваем размер шрифта для маленьких экранов
        : screenWidth * 0.016;

    // Общая настройка выравнивания текста
    TextAlign textAlign = TextAlign.center;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0), // Общий отступ для текста
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Центрируем текст
        children: [
          _buildContactText(AppTexts.phone, textAlign, fontSize),
          _buildContactText(AppTexts.email, textAlign, fontSize),
        ],
      ),
    );
  }

  Widget _buildContactText(String text, TextAlign textAlign, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: "LTWave",
          fontSize: fontSize,
          color: AppColors.black2,
        ),
      ),
    );
  }
}
