import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

abstract class AppTextStyles {
  TextStyle get button;
  TextStyle get titleAppBar;
  TextStyle get titleSplash;
  TextStyle get subtitleSplash;
  TextStyle get textRegister;
  TextStyle get textRegisterBold;
  TextStyle get subTitleAppBar;
  TextStyle get labelButtonGoogle;
  TextStyle get subTitleAuthPage;
  TextStyle get titleAuthPage;
  TextStyle get titleSwipeAction;
  TextStyle get labelRemoveSwipeAction;
  TextStyle get labelReport;
  TextStyle get textoConfirmarData;
  TextStyle get titleHeaderDashBoard;
  TextStyle get subTitleHeaderDashBoard;
  TextStyle get textoSairApp;
  TextStyle get valorCRCP;
  TextStyle get subTitleCRCP;
  TextStyle get saldoClienteCRCP;
  TextStyle get valorResumoVendas;
  TextStyle get totalGeralClienteCRCP;
  TextStyle get titleTotalGeralCRCP;
  TextStyle get titleResumoFp;
  TextStyle get labelButtonLogin;
  TextStyle get titleCards;
  TextStyle get labelMakTub;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get button => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.button,
      );

  @override
  TextStyle get titleAppBar => GoogleFonts.montserrat(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get titleSplash => GoogleFonts.montserrat(
        fontSize: 50,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get subtitleSplash => GoogleFonts.montserrat(
        fontSize: 16,
        color: AppTheme.colors.primary,
      );

  @override
  TextStyle get textRegister => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
      );

  @override
  TextStyle get textRegisterBold => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get subTitleAppBar => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get labelButtonGoogle => GoogleFonts.montserrat(
      fontSize: 12, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  TextStyle get subTitleAuthPage => GoogleFonts.montserrat(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle get titleSwipeAction => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get labelRemoveSwipeAction => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get labelReport => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleHeaderDashBoard => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get subTitleHeaderDashBoard => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get textoConfirmarData => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get textoSairApp => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get valorCRCP => GoogleFonts.montserrat(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get subTitleCRCP => GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.white,
      );

  @override
  TextStyle get saldoClienteCRCP => GoogleFonts.montserrat(
        fontSize: 16,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get totalGeralClienteCRCP => GoogleFonts.montserrat(
        fontSize: 30,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleTotalGeralCRCP => GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get valorResumoVendas => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleAuthPage => GoogleFonts.montserrat(
        fontSize: 30,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get titleResumoFp => GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get labelButtonLogin => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleCards => GoogleFonts.montserrat(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle get labelMakTub => GoogleFonts.montserrat(
        fontSize: 10,
        color: Colors.black,
      );
}
