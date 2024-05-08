import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManger {
  static final ThemeData theme = FlexThemeData.light(
    scheme: FlexScheme.jungle,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      appBarCenterTitle: true,
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: false,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    keyColors: const FlexKeyColors(),
    tones: FlexTones.highContrast(Brightness.light),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.rubik().fontFamily,
  );
  static final ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.jungle,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    subThemesData: const FlexSubThemesData(
      appBarCenterTitle: true,
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: false,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    keyColors: const FlexKeyColors(),
    tones: FlexTones.highContrast(Brightness.dark),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.rubik().fontFamily,
  );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
}
