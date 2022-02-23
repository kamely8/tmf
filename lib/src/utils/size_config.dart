import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? ancho;
  static double? alto;
  static double? espacioHorizontal;
  static double? espacioVertical;
  static double? tamLetraInformativo;
  static double? tamLetraTitulo;
  static double? tamLetraSubtitulo;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  static double? tamIconoMensajes;

  void init(BuildContext context, Orientation orientation) {
    _mediaQueryData = MediaQuery.of(context);
    if (orientation == Orientation.portrait) {
      ancho = _mediaQueryData!.size.width;
      alto = _mediaQueryData!.size.height;
    } else {
      ancho = _mediaQueryData!.size.height;
      alto = _mediaQueryData!.size.width;
    }

    espacioHorizontal = (ancho! / 100);
    espacioVertical = (alto! / 100);

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (ancho! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (alto! - _safeAreaVertical!) / 100;
    tamLetraInformativo = safeBlockHorizontal! * 3;
    tamLetraTitulo = espacioVertical! * 2.35;
    tamLetraSubtitulo = espacioVertical! * 2.25;
    tamIconoMensajes = ancho! * 0.175;
  }
}
