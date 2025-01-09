import 'package:flutter/material.dart';
import 'package:kork_studio/routes/pages/detail_image_page.dart';
import 'package:kork_studio/theme/app_colors.dart';

class AllScreens extends StatelessWidget {
  const AllScreens({
    super.key,
    required this.screenWidth,
    required this.imagePaths,
  });

  final double screenWidth;
  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
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
                          color: AppColors.appBarIconColor.withOpacity(0.9),
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
    );
  }
}
