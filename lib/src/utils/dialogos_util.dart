import 'package:tfmsentimentanalisis/src/utils/size_config.dart';
import 'package:flutter/material.dart';

class Dialogos {
  mensajeExito(BuildContext context, String titulo, Orientation orientation) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          SizeConfig().init(context, orientation);
          return SimpleDialog(
              contentPadding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                ListTile(
                  title: Text(
                    titulo,
                    style: TextStyle(fontSize: SizeConfig.tamLetraTitulo),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: SizeConfig.tamIconoMensajes,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      children: <Widget>[
                        RaisedButton(
                          elevation: 0.0,
                          color: Colors.white,
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Aceptar',
                            style: TextStyle(
                                fontSize: SizeConfig.tamLetraInformativo),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]);
        });
  }

  mensajeEspera(BuildContext context, String titulo, Orientation orientation) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              contentPadding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  title: Text(
                    titulo,
                    style: TextStyle(fontSize: SizeConfig.tamLetraSubtitulo),
                  ),
                  leading: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ]);
        });
  }

  mensajeError(BuildContext context, String titulo, Orientation orientation) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
              contentPadding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                ListTile(
                  title: Text(
                    titulo,
                    style: TextStyle(
                      fontSize: SizeConfig.tamLetraSubtitulo,
                    ),
                    maxLines: 4,
                  ),
                  leading: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: SizeConfig.tamIconoMensajes,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      children: <Widget>[
                        RaisedButton(
                          elevation: 0.0,
                          color: Colors.white,
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Aceptar',
                            style: TextStyle(
                                fontSize: SizeConfig.tamLetraInformativo),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]);
        });
  }
}
