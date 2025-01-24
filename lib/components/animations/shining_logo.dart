import 'package:flutter/material.dart';

class ShiningLogo extends StatefulWidget {
  @override
  _ShiningLogoState createState() => _ShiningLogoState();
}

class _ShiningLogoState extends State<ShiningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Длительность анимации
      vsync: this,
    )..repeat(reverse: true); // Повторяется с обратной анимацией

    _animation = Tween<double>(begin: 0.3, end: 1.0)
        .animate(_controller); // Прозрачность от 0.3 до 1.0
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value, // Меняем прозрачность
          child: child,
        );
      },
      child: Image.asset(
        'assets/images/KORK.png', // Ваш логотип
        width: 80,
        height: 80,
      ),
    );
  }
}
