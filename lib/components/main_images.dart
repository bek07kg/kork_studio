import 'package:flutter/material.dart';
import 'package:kork_studio/components/cached_network_image.dart';
import 'package:kork_studio/components/works_screens/detail_image_screen.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/urls/con_urls.dart';
import 'package:kork_studio/urls/ext_urls.dart';
import 'package:kork_studio/urls/int_urls.dart';

class MainImages extends StatefulWidget {
  MainImages({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<MainImages> createState() => _MainImagesState();
}

class _MainImagesState extends State<MainImages> {
  final List<String> imageUrls = [
    ConUrls.con1_1,
    ExtUrls.ext11_1,
    IntUrls.int3_1,
    ExtUrls.ext2_1,
    ExtUrls.ext12_1,
    ExtUrls.ext17_1,
    ExtUrls.ext16_1,
    IntUrls.int9_1,
    IntUrls.int4_1,
    ExtUrls.ext8_1,
  ];

  final Map<String, List<String>> relatedImagesMap = {
    ConUrls.con1_1: ConUrls.c1,
    ExtUrls.ext11_1: ExtUrls.e11,
    IntUrls.int3_1: IntUrls.i3,
    ExtUrls.ext2_1: ExtUrls.e2,
    ExtUrls.ext12_1: ExtUrls.e12,
    ExtUrls.ext17_1: ExtUrls.e17,
    ExtUrls.ext16_1: ExtUrls.e16,
    IntUrls.int9_1: IntUrls.i9,
    IntUrls.int4_1: IntUrls.i4,
    ExtUrls.ext8_1: ExtUrls.e8,
  };

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: widget.screenWidth < 600
          ? const EdgeInsets.symmetric(horizontal: 5, vertical: 30)
          : const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.screenWidth < 600 ? 1 : 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 3 / 2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            String imageUrl = imageUrls[index];
            List<String> relatedImages = relatedImagesMap[imageUrl] ?? [];
            ValueNotifier<bool> isHovered = ValueNotifier(false);

            return MouseRegion(
              onEnter: (_) => isHovered.value = true,
              onExit: (_) => isHovered.value = false,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailImageScreen(
                        imagePath: imageUrl,
                        relatedImages: relatedImages,
                      ),
                    ),
                  );
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: isHovered,
                  builder: (context, hover, child) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedImageWidget(
                          imageUrl: imageUrl,
                        ),
                        if (hover)
                          Container(
                            color: AppColors.appBarIconColor.withOpacity(0.9),
                          ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
          childCount: imageUrls.length,
        ),
      ),
    );
  }
}
