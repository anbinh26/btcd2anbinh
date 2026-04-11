import 'package:flutter/material.dart';

/// Nền gradient nhẹ cho toàn màn hình — tái sử dụng cho home & create.
class GradientScaffold extends StatelessWidget {
  const GradientScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.floatingActionButton,
  });

  final PreferredSizeWidget? appBar;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.28, 0.55, 0.78, 1.0],
          colors: [
            cs.surface,
            Color.lerp(cs.primaryContainer, cs.surface, 0.35)!,
            Color.lerp(cs.tertiaryContainer, cs.secondaryContainer, 0.5)!,
            cs.secondaryContainer.withValues(alpha: 0.65),
            cs.primary.withValues(alpha: 0.12),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: child,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
