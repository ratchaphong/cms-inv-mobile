import 'package:flutter/material.dart';

enum LogoSize { lg, base, sm }

class BStoreLogo extends StatelessWidget {
  final LogoSize size;
  final Color color;

  const BStoreLogo(
      {super.key, this.size = LogoSize.lg, this.color = Colors.black});

  double getFontSize() {
    switch (size) {
      case LogoSize.lg:
        return 48; // 3rem
      case LogoSize.base:
        return 32; // 2rem
      case LogoSize.sm:
        return 20; // 1.2rem
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: getFontSize(),
          letterSpacing: 4,
          color: color,
        ),
        children: const [
          TextSpan(
            text: 'B',
            style: TextStyle(
              color: Color(0xFFFFCC00), // var(--primary-color)
              fontSize: 72,
            ),
          ),
          TextSpan(
            text: 'store',
          ),
        ],
      ),
    );
  }
}
