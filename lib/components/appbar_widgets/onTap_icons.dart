import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class OntapIcons extends StatelessWidget {
  const OntapIcons({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Показываем Snackbar при ошибке
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize =
        screenWidth < 600 ? screenWidth * 0.06 : screenWidth * 0.02;

    Color iconColor =
        screenWidth < 600 ? AppColors.white : AppColors.appBarIconColor;

    // Иконки и ссылки
    final icons = [
      {
        "path": "assets/images/behance_icon.png",
        "url": "https://www.behance.net/eriksadirov"
      },
      {
        "path": "assets/images/whatsapp_icon.png",
        "url":
            "https://api.whatsapp.com/send/?phone=996505459505&text&type=phone_number&app_absent=0"
      },
      {
        "path": "assets/images/instagram_icon.png",
        "url": "https://www.instagram.com/kork_studio/"
      },
      {
        "path": "assets/images/email_icon.png",
        "url": "mailto:ernazbekjar@gmail.com"
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: icons
          .map((icon) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () => _launchUrl(icon["url"]!),
                  icon: Image.asset(
                    icon["path"]!,
                    height: iconSize,
                    color: iconColor,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
