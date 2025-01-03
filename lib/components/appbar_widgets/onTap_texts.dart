import 'package:flutter/material.dart';
import 'package:kork_studio/routes/pages/about_page.dart';
import 'package:kork_studio/routes/pages/contact_page.dart';
import 'package:kork_studio/routes/pages/home_page.dart';
import 'package:kork_studio/routes/pages/works_page.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/theme/app_texts.dart';

class OntapTexts extends StatelessWidget {
  const OntapTexts({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth > 600 ? 16 : 24;

    // Если экран узкий, увеличиваем отступы между элементами
    return screenWidth > 600
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildTextButtons(context, fontSize),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, // Распределяем элементы равномерно
            children: _addSpacingToColumn(_buildTextButtons(context, fontSize)),
          );
  }

  // Добавление кнопок с текстом
  List<Widget> _buildTextButtons(BuildContext context, double fontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textColor =
        screenWidth < 600 ? AppColors.white : AppColors.appBarIconColor;

    final List<Map<String, dynamic>> buttons = [
      {"label": AppTexts.home, "page": MyHomePage()},
      {"label": AppTexts.ourWorks, "page": WorksPage()},
      {"label": AppTexts.aboutUs, "page": AboutPage()},
      {"label": AppTexts.contacts, "page": ContactPage()},
    ];

    return buttons
        .map(
          (button) => TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => button["page"]),
            ),
            child: Text(
              button["label"],
              style: TextStyle(
                fontFamily: 'LTWave',
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        )
        .toList();
  }

  // Добавление промежутков между элементами в Column
  List<Widget> _addSpacingToColumn(List<Widget> children) {
    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i != children.length - 1) {
        spacedChildren
            .add(SizedBox(height: 32)); // Задаём расстояние между кнопками
      }
    }
    return spacedChildren;
  }
}
