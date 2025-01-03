import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/theme/app_texts.dart';

class AboutTexts extends StatelessWidget {
  const AboutTexts({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    // Определяем размер шрифта в зависимости от ширины экрана
    double fontSize = screenWidth < 600
        ? screenWidth * 0.030 // Увеличиваем размер шрифта для маленьких экранов
        : screenWidth * 0.016;

    // Определяем выравнивание текста
    TextAlign textAlign = screenWidth < 600 ? TextAlign.center : TextAlign.left;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0), // Общий отступ для текста
      child: Column(
        crossAxisAlignment: screenWidth < 600
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          _buildText(
            AppTexts.mainText1,
            textAlign,
            fontSize,
          ),
          _buildText(
            AppTexts.mainText2,
            textAlign,
            fontSize,
          ),
          _buildText(
            AppTexts.mainText3,
            textAlign,
            fontSize,
          ),
          _buildText(
            AppTexts.mainText4,
            textAlign,
            fontSize,
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text, TextAlign textAlign, double fontSize) {
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
