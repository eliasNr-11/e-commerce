import 'package:flutter/material.dart';

class GlobalThemData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);
  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        useMaterial3: true,
        fontFamily: 'Outfit',
        colorScheme: colorScheme,
        canvasColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.surface,
        highlightColor: Colors.transparent,
        focusColor: focusColor);
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF1A1A1A),
    onPrimary: Colors.white,
    secondary: Color(0xFFEDEDED),
    onSecondary: Colors.black,
    tertiary: Colors.white,
    onTertiary: Color(0xFF1A1A1A),
    error: Color(0xFFCD0000),
    onError: Colors.white,
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1A1A1A),
    brightness: Brightness.light,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF1A1A1A),
    onPrimary: Colors.white,
    secondary: Color(0xFFEDEDED),
    onSecondary: Colors.black,
    tertiary: Colors.white,
    onTertiary: Color(0xFF1A1A1A),
    error: Color(0xFFCD0000),
    onError: Colors.white,
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1A1A1A),
    brightness: Brightness.dark,
  );
}
