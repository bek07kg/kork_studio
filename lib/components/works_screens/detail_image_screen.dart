import 'package:flutter/material.dart';
import 'package:kork_studio/components/animations/animated_logo_white.dart';
import 'package:kork_studio/components/appbar_widgets/custom_appBar.dart';
import 'package:kork_studio/components/appbar_widgets/custom_drawer.dart';
import 'package:kork_studio/components/cached_network_image.dart';
import 'package:kork_studio/components/custom_texts/end_text.dart';
import 'package:kork_studio/theme/app_colors.dart';

class DetailImageScreen extends StatefulWidget {
  final String imagePath;
  final List<String> relatedImages;

  const DetailImageScreen({
    super.key,
    required this.imagePath,
    required this.relatedImages,
  });

  @override
  State<DetailImageScreen> createState() => _DetailImageScreenState();
}

class _DetailImageScreenState extends State<DetailImageScreen> {
  late ScrollController _scrollController;
  String? _selectedImage;
  int _selectedIndex = 0;
  bool _isLogoVisible = false;

  late List<bool> _isHovered;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
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

    _isHovered = List.filled(widget.relatedImages.length, false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final crossAxisCount = screenWidth > 600 ? 2 : 1;

    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: screenWidth < 600 ? CustomDrawer(screenWidth: screenWidth) : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomAppBar(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final image = widget.relatedImages[index];
                      return MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _isHovered[index] = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isHovered[index] = false;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedImage = image;
                              _selectedIndex = index;
                            });
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedImageWidget(imageUrl: image),
                              if (_isHovered[index])
                                Container(
                                  color: AppColors.appBarIconColor
                                      .withOpacity(0.9),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: widget.relatedImages.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: screenWidth > 600 ? 1.2 : 1,
                  ),
                ),
              ),
              EndText(),
            ],
          ),

          if (_selectedImage != null)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.9),
                child: Stack(
                  children: [
                    Center(
                      child: InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(double.infinity),
                        minScale: 1.0,
                        maxScale: 5.0,
                        panEnabled: true,
                        child: CachedImageWidget(imageUrl: _selectedImage!),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedImage = null;
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: MediaQuery.of(context).size.height / 2 - 25,
                      child: _arrowButton(Icons.arrow_left, () {
                        setState(() {
                          _selectedIndex = (_selectedIndex - 1) %
                              widget.relatedImages.length;
                          _selectedImage = widget.relatedImages[_selectedIndex];
                        });
                      }),
                    ),
                    Positioned(
                      right: 20,
                      top: MediaQuery.of(context).size.height / 2 - 25,
                      child: _arrowButton(Icons.arrow_right, () {
                        setState(() {
                          _selectedIndex = (_selectedIndex + 1) %
                              widget.relatedImages.length;
                          _selectedImage = widget.relatedImages[_selectedIndex];
                        });
                      }),
                    ),
                  ],
                ),
              ),
            ),

          // Показываем BackButton только если изображение не выбрано
          if (_selectedImage == null)
            Positioned(
              top: screenWidth > 600 ? 158 : 150,
              left: 30,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          AnimatedLogoWhite(isLogoVisible: _isLogoVisible),
        ],
      ),
    );
  }

  Widget _arrowButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
