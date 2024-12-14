
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
  bottomAppBarTheme: const BottomAppBarTheme(
    color: AppColors.navbarBackground,
    elevation: 0,
    height: 70,
    shape: CircularNotchedRectangle(),
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
      textStyle: WidgetStateProperty.all(
        mainFont(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(AppColors.primary),
      textStyle: WidgetStateProperty.all(
        mainFont(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(0),
      ),
      minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
      iconSize: WidgetStateProperty.all(36),
      side: WidgetStateProperty.all(
        const BorderSide(
          color: AppColors.primary,
          width: 2,
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
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.neutral200;
      } else if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      } else {
        return AppColors.primary;
      }
    }),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.secondary100,
    disabledColor: AppColors.neutral50,
    selectedColor: AppColors.secondary,
    secondarySelectedColor: AppColors.secondary,
    labelStyle: TextStyle(
      fontFamily: mainFont().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.secondary,
    ),
    showCheckmark: false,
    elevation: 0,
    padding: const EdgeInsets.all(0),
    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    side: BorderSide.none,
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
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
  datePickerTheme: DatePickerThemeData(
    dayStyle: TextStyle(
      fontFamily: mainFont().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryText,
    ),
    yearForegroundColor:
    WidgetStateColor.resolveWith((states) => AppColors.primary),
    dayBackgroundColor: WidgetStateColor.resolveWith(
          (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        } else {
          return Colors.transparent;
        }
      },
    ),
    dayForegroundColor: WidgetStateColor.resolveWith(
          (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryBackground;
        } else if (states.contains(WidgetState.disabled)) {
          return AppColors.neutral200;
        } else {
          return AppColors.primaryText;
        }
      },
    ),
    todayBackgroundColor: WidgetStateColor.resolveWith(
          (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        } else {
          return Colors.transparent;
        }
      },
    ),
    todayForegroundColor: WidgetStateColor.resolveWith(
          (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryBackground;
        } else {
          return AppColors.primary;
        }
      },
    ),
    todayBorder: const BorderSide(
      color: AppColors.primary,
    ),
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: AppColors.primaryBackground,
    hourMinuteColor: AppColors.neutral25,
    dialHandColor: AppColors.primary,
    dialBackgroundColor: AppColors.neutral25,
    dayPeriodTextColor: WidgetStateColor.resolveWith(
          (states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        } else {
          return AppColors.neutral500;
        }
      },
    ),
    dialTextColor: Colors.black,
    hourMinuteTextStyle: const TextStyle(
      fontFamily: 'DMSans',
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.46,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
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