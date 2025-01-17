import 'package:flutter/material.dart';
import 'package:kork_studio/urls/ext_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class Panorama360Screen extends StatefulWidget {
  const Panorama360Screen({Key? key}) : super(key: key);

  @override
  State<Panorama360Screen> createState() => _Panorama360ScreenState();
}

class _Panorama360ScreenState extends State<Panorama360Screen> {
  // Пример ссылки на 360 панораму
  final String panoramaUrl = 'https://kuula.co/post/h5R5w/collection/7ZM69';

  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    // Устанавливаем размер контейнера в зависимости от ширины экрана
    double containerWidth = screenWidth > 1200
        ? screenWidth * 0.6
        : screenWidth -
            80; // Для больших экранов - 60% от ширины экрана, для маленьких - с отступами
    double containerHeight =
        screenWidth < 600 ? 250 : 500; // Высота остается фиксированной

    // Определяем BoxFit в зависимости от ширины экрана
    BoxFit imageFit = screenWidth < 600 ? BoxFit.contain : BoxFit.cover;

    // Функция для открытия ссылки
    Future<void> _launchURL() async {
      if (await canLaunch(panoramaUrl)) {
        await launch(panoramaUrl);
      } else {
        throw 'Не удалось открыть ссылку: $panoramaUrl';
      }
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: InkWell(
          onTap: _launchURL, // Обработчик нажатия
          child: Container(
            width: containerWidth,
            height: containerHeight,
            child: Image.network(
              ExtUrls.ext1_1,
              fit: imageFit,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: progress.expectedTotalBytes != null
                        ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  'Ошибка загрузки изображения',
                  style: TextStyle(color: Colors.red),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
