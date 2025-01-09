import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';


class CustomTabBar extends StatefulWidget {
  CustomTabBar(
      {super.key,
      required this.selectedIndex,
      required this.tabLabels,
      required this.onTabChanged});

  final int selectedIndex;
  final List<String> tabLabels;
  final ValueChanged<int> onTabChanged; // Колбэк для изменения вкладки

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Инициализация с текущим индексом
  }

  Widget _buildButton(String label, double width, double height, int index) {
    return _CustomButton(
      label: label,
      width: width,
      height: height,
      isSelected: _selectedIndex == index,
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
        widget.onTabChanged(index); // Вызываем колбэк
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth > 600 ? 150 : 100;
    double buttonHeight = screenWidth > 600 ? 50 : 40;

    return SliverToBoxAdapter(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(widget.tabLabels.length, (index) {
              return _buildButton(
                  widget.tabLabels[index], buttonWidth, buttonHeight, index);
            }),
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final bool isSelected;
  final VoidCallback onPressed;

  const _CustomButton({
    required this.label,
    required this.width,
    required this.height,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Расчет размера шрифта пропорционально ширине кнопки
    double fontSize = width * 0.1;

    return SizedBox(
      width: width,
      height: height,
      child: MouseRegion(
        onEnter: (_) {},
        onExit: (_) {},
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              isSelected
                  ? AppColors.grey // Цвет фона для выбранной вкладки
                  : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : AppColors.black, // Цвет текста для выбранной вкладки
                fontSize: fontSize, // Размер шрифта
                fontFamily: "LTWave",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
