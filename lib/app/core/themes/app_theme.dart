
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/app/core/themes/app_colors.dart';

const mainFont = GoogleFonts.inter;

final ThemeData appLightTheme = ThemeData(
  fontFamily: mainFont().fontFamily,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.primaryBackground,
  disabledColor: AppColors.neutral50,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryText,
    onPrimary: AppColors.primaryText,
    secondary: AppColors.secondary,
    onSecondary: AppColors.primaryText,
    tertiary: AppColors.primaryText,
    onTertiary: AppColors.secondaryText,
    onSurface: AppColors.primaryText,
    error: AppColors.error,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.openSans(
      fontSize: 44,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    displayMedium: mainFont(
      fontSize: 40,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    displaySmall: mainFont(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    headlineLarge: mainFont(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryText,
    ),
    headlineMedium: mainFont(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    headlineSmall: mainFont(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryText,
    ),
    titleLarge: mainFont(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryText,
    ),
    titleMedium: mainFont(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryText,
    ),
    titleSmall: mainFont(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    labelLarge: mainFont(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    labelMedium: mainFont(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
      letterSpacing: 0.46,
    ),
    labelSmall: mainFont(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    bodyLarge: mainFont(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryText,
    ),
    bodyMedium: mainFont(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryText,
    ),
    bodySmall: mainFont(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryText,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith(
            (states) {
          return states.contains(WidgetState.pressed)
              ? AppColors.primary.withOpacity(0.5)
              : null;
        },
      ),
      backgroundColor: WidgetStateProperty.all(AppColors.primary),
      foregroundColor: WidgetStateProperty.all(AppColors.primaryBackground),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
      minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
      iconSize: WidgetStateProperty.all(36),
      iconColor: WidgetStateProperty.all(AppColors.darkBackground),
      textStyle: WidgetStateProperty.all(
        mainFont(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.neutral200;
      } else if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      } else {
        return AppColors.primaryBackground;
      }
    }),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.neutral50;
      } else {
        return AppColors.primaryBackground;
      }
    }),
  ),
  inputDecorationTheme: _inputDecorationTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: AppColors.appBarForeground,
    titleTextStyle: mainFont(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.appBarForeground,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
      foregroundColor: AppColors.primary,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.neutral200;
        } else {
          return AppColors.primary;
        }
      }),
      foregroundColor: WidgetStateProperty.all(AppColors.primaryBackground),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
      minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
      textStyle: WidgetStateProperty.all(
        mainFont(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.neutral200,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.zero,
      ),
      visualDensity: VisualDensity.compact,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.white;
      } else {
        return Colors.white;
      }
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      } else {
        return AppColors.neutral200;
      }
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      return 0;
    }),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.primaryText,
  ),
);

final ThemeData appDarkTheme = ThemeData(
  fontFamily: mainFont().fontFamily,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground, // A darker background
  disabledColor: AppColors.neutral400, // A muted color for disabled items
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryDarkText, // Adjusted for dark theme
    onPrimary: AppColors.primaryDarkText,
    secondary: AppColors.secondary,
    onSecondary: AppColors.primaryDarkText,
    tertiary: AppColors.primaryDarkText,
    onTertiary: AppColors.secondaryDarkText,
    onSurface: AppColors.primaryDarkText,
    error: AppColors.errorDark, // Darker variant for errors
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.openSans(
      fontSize: 44,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkText,
    ),
    displayMedium: mainFont(
      fontSize: 40,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkText,
    ),
    displaySmall: mainFont(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkText,
    ),
    headlineLarge: mainFont(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryDarkText,
    ),
    headlineMedium: mainFont(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkText,
    ),
    headlineSmall: mainFont(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryDarkText,
    ),
    titleLarge: mainFont(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryDarkText,
    ),
    titleMedium: mainFont(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryDarkText,
    ),
    titleSmall: mainFont(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkText,
    ),
    labelLarge: mainFont(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkText,
    ),
    labelMedium: mainFont(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkText,
      letterSpacing: 0.46,
    ),
    labelSmall: mainFont(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkText,
    ),
    bodyLarge: mainFont(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryDarkText,
    ),
    bodyMedium: mainFont(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryDarkText,
    ),
    bodySmall: mainFont(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryDarkText,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith(
            (states) {
          return states.contains(WidgetState.pressed)
              ? AppColors.primaryDark.withOpacity(0.5)
              : null;
        },
      ),
      backgroundColor: WidgetStateProperty.all(AppColors.primaryDark),
      foregroundColor: WidgetStateProperty.all(AppColors.darkBackground),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
      minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
      iconSize: WidgetStateProperty.all(36),
      iconColor: WidgetStateProperty.all(AppColors.primaryDarkText),
      textStyle: WidgetStateProperty.all(
        mainFont(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.neutral600;
      } else if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      } else {
        return AppColors.darkBackground;
      }
    }),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.neutral200;
      } else {
        return AppColors.darkBackground;
      }
    }),
  ),
  inputDecorationTheme: _inputDecorationTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: AppColors.darkBackground, // Adjusted for dark theme
    titleTextStyle: mainFont(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.darkBackground,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryDark,
      ),
      foregroundColor: AppColors.primaryDark,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.neutral600;
        } else {
          return AppColors.primaryDark;
        }
      }),
      foregroundColor: WidgetStateProperty.all(AppColors.darkBackground),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
      minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
      textStyle: WidgetStateProperty.all(
        mainFont(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryDark,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.zero,
      ),
      visualDensity: VisualDensity.compact,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey;
      } else {
        return Colors.white;
      }
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      } else {
        return AppColors.neutral600;
      }
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      return 0;
    }),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.primaryDarkText,
  ),
);



InputDecorationTheme _inputDecorationTheme() {
  final textStyle = mainFont(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );

  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    isDense: true,
    labelStyle: textStyle,
    hintStyle: textStyle.copyWith(
      color: AppColors.neutral400,
    ),
    iconColor: AppColors.neutral400,
    prefixIconColor: AppColors.neutral400,
    suffixIconColor: AppColors.neutral400,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: AppColors.neutral400,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: AppColors.neutral400,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: AppColors.neutral400,
      ),
    ),
    errorStyle: const TextStyle(
      fontSize: 12,
      height: 0,
    ),
  );
}