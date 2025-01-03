import 'package:flutter/material.dart';
import 'package:kork_studio/components/animations/animated_logo_white.dart';
import 'package:kork_studio/components/appbar_widgets/custom_appBar.dart';
import 'package:kork_studio/components/appbar_widgets/custom_drawer.dart';
import 'package:kork_studio/components/custom_texts/end_text.dart';
import 'package:kork_studio/routes/pages/detail_image_page.dart';
import 'package:kork_studio/theme/app_colors.dart';

class WorksPage extends StatefulWidget {
  const WorksPage({super.key});

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorksPage> {
  late ScrollController _scrollController;
  bool _isLogoVisible = false;

  final List<String> imagePaths = [
    "assets/images/foto1.jpg",
    "assets/images/foto2.jpg",
    "assets/images/foto3.jpg",
    "assets/images/foto4.jpg",
    "assets/images/foto5.jpg",
    "assets/images/foto6.jpg",
    "assets/images/foto7.jpg",
    "assets/images/foto8.jpg",
    "assets/images/foto9.jpg",
    "assets/images/foto10.jpg",
    "assets/images/foto11.jpg",
    "assets/images/foto12.jpg",
    "assets/images/foto13.jpg",
    "assets/images/foto14.jpg",
    "assets/images/foto15.jpg",
    "assets/images/foto16.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // Следим за состоянием прокрутки
      if (_scrollController.offset > 150 && !_isLogoVisible) {
        setState(() {
          _isLogoVisible = true; // Логотип становится видимым
        });
      } else if (_scrollController.offset <= 150 && _isLogoVisible) {
        setState(() {
          _isLogoVisible = false; // Логотип исчезает
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
              SliverPadding(
                padding: screenWidth < 600
                    ? const EdgeInsets.symmetric(horizontal: 5, vertical: 30)
                    : const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth < 600 ? 1 : 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 3 / 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      String imagePath = imagePaths[index];
                      bool isHovered = false; // Флаг для отслеживания наведения

                      return StatefulBuilder(
                        builder: (context, setState) => MouseRegion(
                          onEnter: (_) {
                            setState(() => isHovered = true);
                          },
                          onExit: (_) {
                            setState(() => isHovered = false);
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailImagePage(imagePath: imagePath),
                                ),
                              );
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                                if (isHovered)
                                  Container(
                                    color: AppColors.appBarIconColor
                                        .withOpacity(0.9),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: imagePaths.length,
                  ),
                ),
              ),
              EndText(),
            ],
          ),
          AnimatedLogoWhite(isLogoVisible: _isLogoVisible),
        ],
      ),
    );
  }
}
