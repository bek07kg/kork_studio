import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/theme/app_texts.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  // Метод для создания кнопки с адаптивным размером и острыми углами
  Widget _buildButton(String label, double width, double height) {
    return _CustomButton(label: label, width: width, height: height);
  }

  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    // Устанавливаем размер кнопок в зависимости от ширины экрана
    double buttonWidth =
        screenWidth > 600 ? 150 : 100; // Размер кнопок на основе экрана
    double buttonHeight =
        screenWidth > 600 ? 50 : 40; // Пропорциональная высота кнопки

    return SliverToBoxAdapter(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(AppTexts.all, buttonWidth, buttonHeight),
              _buildButton(AppTexts.conceps, buttonWidth, buttonHeight),
              _buildButton(AppTexts.exteryers, buttonWidth, buttonHeight),
              _buildButton(AppTexts.interyers, buttonWidth, buttonHeight),
              _buildButton(AppTexts.animations, buttonWidth, buttonHeight),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatefulWidget {
  final String label;
  final double width;
  final double height;

  const _CustomButton({
    required this.label,
    required this.width,
    required this.height,
  });

  @override
  __CustomButtonState createState() => __CustomButtonState();
}

class __CustomButtonState extends State<_CustomButton> {
  // Состояние для отслеживания наведения курсора на кнопку
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Расчёт размера шрифта пропорционально ширине кнопки
    double fontSize = widget.width * 0.1; // Например, 10% от ширины кнопки

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true; // Устанавливаем состояние при наведении
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false; // Возвращаем состояние при уходе курсора
          });
        },
        child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              _isHovered ? AppColors.grey : Colors.transparent,
            ), // Изменение фона при наведении
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: _isHovered
                    ? Colors.white
                    : AppColors.black, // Изменение цвета текста
                fontSize:
                    fontSize, // Размер шрифта пропорционален ширине кнопки
                fontFamily: "LTWave",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
