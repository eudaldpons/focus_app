import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pomodore/core/resources/params/theme_params.dart";

class AppConstant {
  /// dimens
  static const radius = 10.0;
  static const modalPadding = 15.0;
  static const iconSize = 20.0;

  // strings
  static const appName = "Pmodoro";
  static const fontFamily = "inter";

  // Hero tags
  static const splashIconHeroTag = "__splash-appbar__";

  // path
  static String getLogoPath(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? "assets/images/logov2_light_mode.png"
          : "assets/images/logov2.png";

  static String? getFontFamily() => GoogleFonts.poppins().fontFamily;

  static TextStyle getTextStyle({double? fontSize, Color? color}) =>
      TextStyle(color: color, fontSize: fontSize);

  static TextTheme getTextTheme({Color? color}) => TextTheme(
        bodyLarge: getTextStyle(color: color),
        bodyMedium: getTextStyle(color: color),
        bodySmall: getTextStyle(color: color),
        displayLarge: getTextStyle(color: color),
        displayMedium: getTextStyle(color: color),
        displaySmall: getTextStyle(color: color),
        headlineLarge: getTextStyle(color: color),
        headlineMedium: getTextStyle(color: color),
        headlineSmall: getTextStyle(color: color),
        labelLarge: getTextStyle(color: color),
        labelMedium: getTextStyle(color: color),
        labelSmall: getTextStyle(color: color),
        titleLarge: getTextStyle(color: color),
        titleMedium: getTextStyle(color: color),
        titleSmall: getTextStyle(color: color),
      );

  static final defaultLightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: getFontFamily(),
    cardColor: Colors.white,
    cardTheme: const CardTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    textTheme: getTextTheme(color: Colors.black),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Color(0xff01ED64),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    buttonTheme: const ButtonThemeData(),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 10,
    ),
    switchTheme: const SwitchThemeData(),
    inputDecorationTheme:
        const InputDecorationTheme(enabledBorder: UnderlineInputBorder()),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );

  static final defaultDarkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    fontFamily: getFontFamily(),
    cardColor: Colors.white.withOpacity(.1),
    cardTheme: const CardTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    textTheme: getTextTheme(color: Colors.white),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff01ED64),
      onPrimary: Colors.black,
      secondary: Color(0xff01ED64),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
    buttonTheme: const ButtonThemeData(),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xff01ED64),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      elevation: 10,
    ),
    switchTheme: const SwitchThemeData(),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static final polarNightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff2e3440),
    fontFamily: getFontFamily(),
    cardColor: Colors.white.withOpacity(.1),
    cardTheme: const CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    textTheme: getTextTheme(color: Colors.white),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd8dee9),
      onPrimary: Colors.black,
      secondary: Color(0xff8fbcbb),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xff2e3440),
      onSurface: Colors.white,
    ),
    buttonTheme: const ButtonThemeData(),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xff8fbcbb),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff434c5e),
      elevation: 10,
    ),
    switchTheme: const SwitchThemeData(),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static final darkBlueTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff0C134F),
    fontFamily: getFontFamily(),
    cardColor: const Color(0xff1D267D),
    cardTheme: const CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    textTheme: getTextTheme(color: Colors.white),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffD4ADFC),
      onPrimary: Colors.black,
      secondary: Color(0xffD864A9),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xff0C134F),
      onSurface: Colors.white,
    ),
    buttonTheme: const ButtonThemeData(),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xffD4ADFC),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff654E92),
      elevation: 10,
    ),
    switchTheme: const SwitchThemeData(),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static final List<ThemeParams> themes = [
    ThemeParams("light", defaultLightTheme, "Light Minimal"),
    ThemeParams("dark", defaultDarkTheme, "Dark Minimal"),
    ThemeParams("polar", polarNightTheme, "Polar Night"),
    ThemeParams("darkblue", darkBlueTheme, "Dark Blue"),
  ];
}
