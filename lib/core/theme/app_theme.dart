import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final base = ThemeData(brightness: Brightness.light, useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(primary: const Color(0xFF1363DF)),
    cardTheme: const CardThemeData(elevation: 0.5),
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
