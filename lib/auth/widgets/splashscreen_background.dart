import 'package:flutter/material.dart';

class MovieGradientBackground extends StatelessWidget {
  final Widget child;

  const MovieGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Gradient backgroundGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark
          ? [
              const Color(0xFF0B0F14), // Fondo oscuro superior
              const Color(0xFF12151A), // Surface dark
              const Color(0xFF1E1E1E), // Ligeramente más claro
            ]
          : [
              const Color(0xFFF8F9FB), // Fondo claro superior
              const Color(0xFFFFFFFF), // Surface light
              const Color(0xFFEFEFEF), // Suave gris claro
            ],
    );

    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: child,
    );
  }
}
