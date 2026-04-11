import 'package:flutter/material.dart';

import 'screens/diary_home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const DiaryApp());
}

class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nhật ký',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const DiaryHomeScreen(),
    );
  }
}
