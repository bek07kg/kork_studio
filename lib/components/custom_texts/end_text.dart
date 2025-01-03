import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:kork_studio/theme/app_texts.dart';

class EndText extends StatelessWidget {
  const EndText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20), // Универсальные отступы
        child: Text(
          AppTexts.end,
          style: TextStyle(
            fontFamily: "LTWave",
            fontSize: 16,
            color: AppColors.appBarIconColor,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
