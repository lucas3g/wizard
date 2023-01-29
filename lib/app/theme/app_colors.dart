import 'package:flutter/material.dart';
import 'dart:core';

abstract class AppColors {
  Color get backgroundPrimary;
  Color get button;
  Color get titleAppBar;
  Color get titleSplash;
  Color get titleEstoque;
  Color get titlePontos;
  Color get logadoComSucesso;
  Color get backgroundButton;
  MaterialColor get primary;
  MaterialColor get swatch;

  final String hex = '0xff';
  final String colorFinal = '700391';
  final int hexFinal = 0;

  final String colorSwatch = '700391';
  final int hexSwatch = 0;
}

class AppColorDefault implements AppColors {
  @override
  Color get button => Colors.white;

  @override
  Color get backgroundPrimary => Colors.white;

  @override
  Color get titleAppBar => Colors.white;

  @override
  Color get titleSplash => Colors.white;

  @override
  Color get titleEstoque => Colors.black;

  @override
  Color get titlePontos => const Color(0xffcf1f36);

  @override
  Color get logadoComSucesso => const Color(0xff009342);

  Map<int, Color> color = {
    50: const Color.fromRGBO(0, 44, 77, .1),
    100: const Color.fromRGBO(0, 44, 77, .2),
    200: const Color.fromRGBO(0, 44, 77, .3),
    300: const Color.fromRGBO(0, 44, 77, .4),
    400: const Color.fromRGBO(0, 44, 77, .5),
    500: const Color.fromRGBO(0, 44, 77, .6),
    600: const Color.fromRGBO(0, 44, 77, .7),
    700: const Color.fromRGBO(0, 44, 77, .8),
    800: const Color.fromRGBO(0, 44, 77, .9),
    900: const Color.fromRGBO(0, 44, 77, 1),
  };

  @override
  String get hex => '0xff';

  //009342 - PAPAGAIO - cf1f36 BIO //004357 Cor legal
  //246EE9 Royal Blue //FF2400 Scarlet Red //3EB489 Mint Green
  @override
  String get colorFinal => '002C4D';

  @override
  String get colorSwatch => 'FFFFFF';

  @override
  int get hexFinal => int.parse('$hex$colorFinal');

  @override
  int get hexSwatch => int.parse('$hex$colorSwatch');

  @override
  MaterialColor get primary => MaterialColor(hexFinal, color);

  @override
  MaterialColor get swatch => MaterialColor(hexSwatch, color);

  @override
  Color get backgroundButton => const Color(0xFFFCF3F4);
}
