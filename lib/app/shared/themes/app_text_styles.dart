import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final titleHome = GoogleFonts.lato(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.lightGrey,
  );

  static final titleHomeDark = GoogleFonts.lato(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
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

  static final textInput = GoogleFonts.lato(
    fontSize: 16,
    color: AppColors.lightGrey,
  );

  static final textInputDark = GoogleFonts.lato(
    fontSize: 16,
    color: AppColors.darkGrey,
  );

  static final smallContentWhite = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final smallerContent = GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.lightGrey,
  );

  static final smallerContentDark = GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
  );

  static final titleSecondary = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.lightGrey,
  );

  static final titleSecondaryDark = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
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
