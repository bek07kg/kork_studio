import 'package:flutter/material.dart';
import 'package:kork_studio/components/animations/animated_logo_white.dart';
import 'package:kork_studio/components/appbar_widgets/custom_appBar.dart';
import 'package:kork_studio/components/appbar_widgets/custom_drawer.dart';
import 'package:kork_studio/components/tabbar_widgets/custom_tabBar.dart';
import 'package:kork_studio/components/custom_texts/end_text.dart';
import 'package:kork_studio/components/works_screens/all_screens.dart';
import 'package:kork_studio/components/works_screens/exteryers_screen.dart';
import 'package:kork_studio/components/works_screens/interyers_screen.dart';
import 'package:kork_studio/components/works_screens/panorama360_screen.dart';
import 'package:kork_studio/constants/app_texts.dart';
import 'package:kork_studio/urls/main_urls.dart';

class WorksPage extends StatefulWidget {
  const WorksPage({super.key});

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorksPage> {
  late ScrollController _scrollController;
  bool _isLogoVisible = false;

  // Индекс активной вкладки
  int _selectedTabIndex = 0;

  final List<String> imageUrls = [
    MainUrls.m1,
    MainUrls.m2,
    MainUrls.m3,
    MainUrls.m4,
    MainUrls.m5,
    MainUrls.m6,
    MainUrls.m7,
    MainUrls.m8,
    MainUrls.m9,
    MainUrls.m10,
    MainUrls.m11,
    MainUrls.m12,
    MainUrls.m13,
    MainUrls.m14,
    MainUrls.m15,
    MainUrls.m16,
  ];

  final List<String> tabLabels = [
    AppTexts.all,
    AppTexts.conceps,
    AppTexts.exteryers,
    AppTexts.interyers,
    AppTexts.animations,
    AppTexts.panorama360,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
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

  // Метод для отображения контента в зависимости от выбранной вкладки
  Widget _getContentForSelectedTab() {
    switch (_selectedTabIndex) {
      case 0:
        return AllScreens(
            screenWidth: MediaQuery.of(context).size.width,
            imagePaths: imageUrls); // Контент для первой вкладки
      case 1:
        return AllScreens(
            screenWidth: MediaQuery.of(context).size.width,
            imagePaths:
                imageUrls); // Замените на свой виджет для второй вкладки
      case 2:
        return ExteryersScreen(
          screenWidth: MediaQuery.of(context).size.width,
        ); // Замените на свой виджет для третьей вкладки
      case 3:
        return InteryersScreen(
          screenWidth: MediaQuery.of(context).size.width,
        ); // Замените на свой виджет для четвертой вкладки
      case 4:
        return AllScreens(
            screenWidth: MediaQuery.of(context).size.width,
            imagePaths: imageUrls);
      case 5:
        return Panorama360Screen(); // Замените на свой виджет для шестой вкладки
      default:
        return SizedBox(); // Пустой виджет по умолчанию
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: screenWidth < 600 ? CustomDrawer(screenWidth: screenWidth) : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomAppBar(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              SliverToBoxAdapter(
                child: SizedBox(height: screenWidth < 600 ? 25 : 40),
              ),
              CustomTabBar(
                selectedIndex: _selectedTabIndex, // передаем выбранный индекс
                tabLabels: tabLabels, // передаем список текстов
                onTabChanged: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
              // Отображение контента в зависимости от выбранного индекса
              _getContentForSelectedTab(),
              EndText(),
            ],
          ),
          AnimatedLogoWhite(isLogoVisible: _isLogoVisible),
        ],
      ),
    );
  }
}
