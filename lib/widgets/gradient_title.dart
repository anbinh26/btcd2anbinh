import 'package:flutter/material.dart';

/// Tiêu đề chữ gradient (tím → hồng → xanh) cho AppBar.
class GradientTitle extends StatelessWidget {
  const GradientTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: [cs.primary, cs.tertiary, cs.secondary],
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
              color: Colors.white,
            ),
      ),
    );
  }
}
