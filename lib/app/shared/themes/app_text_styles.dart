import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final titleHome = GoogleFonts.lato(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static final textButtonUnderline = GoogleFonts.lato(
    fontSize: 16,
    decoration: TextDecoration.underline,
    color: AppColors.primary,
  );

  static final textError = GoogleFonts.lato(
    fontSize: 16,
    color: AppColors.red,
  );

  static final textPrimary = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static final textGreyd = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
  );

  static final textInput = GoogleFonts.lato(
    fontSize: 16,
    color: AppColors.darkGrey,
  );

  static final smallContentWhite = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final smallerContentWhite = GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final whiteTitle = GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final cardContentBig = GoogleFonts.lato(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final cardContentBigLight = GoogleFonts.lato(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}
