import 'package:flutter/material.dart';
import 'package:kork_studio/components/animations/animated_logo_black.dart';
import 'package:kork_studio/components/appbar_widgets/custom_appBar.dart';
import 'package:kork_studio/components/appbar_widgets/custom_drawer.dart';
import 'package:kork_studio/components/custom_texts/contact_texts.dart';
import 'package:kork_studio/components/custom_texts/end_text.dart';
import 'package:kork_studio/components/text_form_fields.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late ScrollController _scrollController;
  bool _isLogoVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // Логика видимости логотипа при прокрутке
      if (_scrollController.offset > 150 && !_isLogoVisible) {
        setState(() {
          _isLogoVisible = true;
        });
      } else if (_scrollController.offset <= 150 && _isLogoVisible) {
        setState(() {
          _isLogoVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: screenWidth < 600
          ? CustomDrawer(screenWidth: screenWidth)
          : null, // Для мобильных экранов
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomAppBar(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight), // Заголовок
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Адаптация макета в зависимости от ширины экрана
                      if (constraints.maxWidth < 600) {
                        // Для маленьких экранов используем Column
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: ContactTexts()), // Тексты для контактов
                            SizedBox(height: 20),
                            TextFormFields(), // Поля для ввода
                          ],
                        );
                      } else {
                        // Для больших экранов используем Row
                        return Row(
                          children: [
                            Expanded(child: ContactTexts()),
                            SizedBox(width: 20),
                            Expanded(child: TextFormFields()),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              EndText(), // Конечный текст или блок
            ],
          ),
          // Анимация логотипа при прокрутке
          AnimatedLogoBlack(isLogoVisible: _isLogoVisible),
        ],
      ),
    );
  }
}
