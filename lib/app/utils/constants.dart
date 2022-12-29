import 'dart:io';

import 'package:flutter/material.dart';

class Constants {
  static String urlVendasDiarias = 'vendas/vendas';
  static String urlVendasLucro = 'vendas/projecao';
  static String urlVendasGrafico = 'vendas/grafico';
  static String urlMovimento = 'movimento/saldo';
  static String urlResumoFP = 'formaspag/resumo';
  static String urlCR = 'contas/cr';
  static String urlCP = 'contas/cp';
  static String urlEstoque = 'mercadorias/estoque';
}

extension ContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  Size get sizeAppbar {
    final height = AppBar().preferredSize.height;

    return Size(
      screenWidth,
      height +
          (Platform.isWindows
              ? 75
              : Platform.isIOS
                  ? 50
                  : 70),
    );
  }
}

const double kPadding = 10;
