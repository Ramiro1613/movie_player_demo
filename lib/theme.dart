import 'package:flutter/material.dart';

/// Light
final ColorScheme _lightScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFD4AF37), // dorado
  brightness: Brightness.light,
  surface: const Color(0xFFFFFFFF),
  onSurface: const Color(0xFF1C1C1C), // Texto e íconos sobre surface
);

/// Dark
final ColorScheme _darkScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFE50914), // rojo
  brightness: Brightness.dark,
  surface: const Color(0xFF12151A),
  onSurface: const Color(0xFFE0E0E0), // Texto e íconos sobre surface
);

final ThemeData lightMovieTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: _lightScheme,
  scaffoldBackgroundColor: _lightScheme.surface,
  // fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
    backgroundColor: _lightScheme.surface,
    foregroundColor: _lightScheme.onSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: _lightScheme.onSurface,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 40,
      letterSpacing: -0.5,
      color: _lightScheme.onSurface,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: _lightScheme.onSurface,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: _lightScheme.onSurfaceVariant,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      height: 1.4,
      color: _lightScheme.onSurface,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
      color: _lightScheme.onPrimary,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: _lightScheme.surface, // caja clara
    hintStyle: TextStyle(color: _lightScheme.outline),
    labelStyle: TextStyle(color: _lightScheme.onSurfaceVariant),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _lightScheme.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _lightScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _lightScheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _lightScheme.error, width: 2),
    ),
    prefixIconColor: _lightScheme.outline,
    suffixIconColor: _lightScheme.outline,
  ),
  cardTheme: CardThemeData(
    color: _lightScheme.surface,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
  ),
);

final ThemeData darkMovieTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: _darkScheme,
  scaffoldBackgroundColor: _darkScheme.surface,
  // fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
    backgroundColor: _darkScheme.surface,
    foregroundColor: _darkScheme.onSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: _darkScheme.onSurface,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 40,
      letterSpacing: -0.5,
      color: _darkScheme.onSurface,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: _darkScheme.onSurface,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: _darkScheme.onSurfaceVariant,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      height: 1.45,
      color: _darkScheme.onSurface,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
      color: _darkScheme.onPrimary,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: _darkScheme.surface, // caja oscura
    hintStyle: TextStyle(color: _darkScheme.outline),
    labelStyle: TextStyle(color: _darkScheme.onSurfaceVariant),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _darkScheme.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _darkScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _darkScheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _darkScheme.error, width: 2),
    ),
    prefixIconColor: _darkScheme.outline,
    suffixIconColor: _darkScheme.outline,
  ),
  cardTheme: CardThemeData(
    color: _darkScheme.surface,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
  ),
);
