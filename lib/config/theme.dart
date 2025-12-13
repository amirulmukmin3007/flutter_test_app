import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData flutterTestAppTheme() {
  return ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    useMaterial3: true,

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFAF3E1),
      primary: const Color(0xFFFAF3E1),
      secondary: const Color(0xFFFF6D1F),
      tertiary: const Color(0xFF222222),
      surface: Colors.white,
      error: const Color(0xFFEF4444),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6D1F),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ).copyWith(
            // Hover effect
            overlayColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.white.withOpacity(0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return Colors.white.withOpacity(0.2);
              }
              return null;
            }),
            // Elevation on hover
            elevation: WidgetStateProperty.resolveWith<double>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.hovered)) {
                return 2;
              }
              if (states.contains(WidgetState.pressed)) {
                return 0;
              }
              return 0;
            }),
          ),
    ),

    // Outlined Button Theme (for secondary actions)
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFFF6D1F),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: Color(0xFFFF6D1F), width: 1.5),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Text Button Theme (for tertiary actions)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFFF6D1F),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Input Field Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

      // Border styling
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),

      // Enabled border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),

      // Focused border
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6D1F), width: 2),
      ),

      // Error border
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1),
      ),

      // Focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
      ),

      // Label style
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w500,
      ),

      // Floating label style
      floatingLabelStyle: GoogleFonts.poppins(
        fontSize: 16,
        color: const Color(0xFFFF6D1F),
        fontWeight: FontWeight.w600,
      ),

      // Hint style
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w400,
      ),

      // Error style
      errorStyle: GoogleFonts.poppins(
        fontSize: 12,
        color: const Color(0xFFEF4444),
        fontWeight: FontWeight.w500,
      ),

      // Prefix icon styling
      prefixIconColor: Colors.grey.shade500,
      suffixIconColor: Colors.grey.shade500,
    ),

    // Card Theme (for product cards)
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      color: Colors.white,
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: Colors.grey.shade700, size: 24),
  );
}
