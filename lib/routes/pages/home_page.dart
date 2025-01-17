import 'package:flutter/material.dart';
import 'package:kork_studio/components/animations/animated_logo_white.dart';
import 'package:kork_studio/components/appbar_widgets/custom_appBar.dart';
import 'package:kork_studio/components/appbar_widgets/custom_drawer.dart';
import 'package:kork_studio/components/main_images.dart';
import 'package:kork_studio/components/custom_texts/end_text.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/constants/app_texts.dart';
import 'package:kork_studio/urls/main_urls.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  bool _isLogoVisible = false; // Логотип
  bool _isTextVisible = true; // Текст

  List<String> imageUrls = [
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
  ]; // Список для хранения URL-ов изображений

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

      if (_scrollController.offset > 200 && _isTextVisible) {
        setState(() {
          _isTextVisible = false;
        });
      } else if (_scrollController.offset <= 200 && !_isTextVisible) {
        setState(() {
          _isTextVisible = true;
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
      drawer: screenWidth < 600 ? CustomDrawer(screenWidth: screenWidth) : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomAppBar(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 100),
                        opacity: _isTextVisible ? 1.0 : 0.0,
                        child: Text(
                          AppTexts.kork,
                          style: TextStyle(
                            fontFamily: "LTWave",
                            fontSize: screenWidth < 600 ? 30 : 60,
                            color: AppColors.black2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 100),
                        opacity: _isTextVisible ? 1.0 : 0.0,
                        child: Text(
                          AppTexts.korkMain,
                          style: TextStyle(
                            fontFamily: "LTWave",
                            fontSize: screenWidth < 600 ? 10 : 20,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              MainImages(screenWidth: screenWidth, imageUrls: imageUrls),
              EndText(),
            ],
          ),
          AnimatedLogoWhite(isLogoVisible: _isLogoVisible),
        ],
      ),
    );
  }
}
