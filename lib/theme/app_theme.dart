import 'package:flutter/material.dart';

/// Theme Material 3 — bảng màu rực: tím điện, hồng neon, xanh ngọc, cam đào.
class AppTheme {
  AppTheme._();

  static const Color _primary = Color(0xFF7C3AED);
  static const Color _secondary = Color(0xFF06D6A0);
  static const Color _tertiary = Color(0xFFFF3D9A);
  static const Color _peach = Color(0xFFFF8A5C);

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primary,
        brightness: Brightness.light,
        primary: _primary,
        secondary: _secondary,
        tertiary: _tertiary,
        surface: const Color(0xFFFFF8FE),
        surfaceContainerHighest: const Color(0xFFF3E8FF),
        primaryContainer: const Color(0xFFEDE9FE),
        secondaryContainer: const Color(0xFFD1FAE5),
        tertiaryContainer: const Color(0xFFFFE4F1),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        shadowColor: _primary.withValues(alpha: 0.18),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFFFBFE),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: _primary.withValues(alpha: 0.22)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: _tertiary.withValues(alpha: 0.95), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: _peach.withValues(alpha: 0.95),
        contentTextStyle: const TextStyle(
          color: Color(0xFF1C1022),
          fontWeight: FontWeight.w600,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return _secondary;
          return Colors.grey.shade400;
        }),
        trackColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return _secondary.withValues(alpha: 0.42);
          return Colors.grey.shade300;
        }),
      ),
    );
  }
}
