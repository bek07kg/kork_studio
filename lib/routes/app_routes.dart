import 'package:flutter/material.dart';
import 'package:kork_studio/routes/pages/about_page.dart';
import 'package:kork_studio/routes/pages/contact_page.dart';
import 'package:kork_studio/routes/pages/detail_image_page.dart';
import 'package:kork_studio/routes/pages/home_page.dart';
import 'package:kork_studio/routes/pages/works_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String works = '/works';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String detailImage = '/detailImage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case works:
        return MaterialPageRoute(builder: (_) => const WorksPage());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case contact:
        return MaterialPageRoute(builder: (_) => const ContactPage());
      case detailImage:
        // Передача аргумента (imagePath) в маршрут
        final imagePath = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DetailImagePage(imagePath: imagePath),
        );
      default:
        return MaterialPageRoute(builder: (_) => const WorksPage());
    }
  }
}
