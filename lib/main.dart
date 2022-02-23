// @dart=2.9


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tfmsentimentanalisis/src/models/model_cursoforo.dart';
import 'package:tfmsentimentanalisis/src/models/model_discusion.dart';
import 'package:tfmsentimentanalisis/src/share_prefs/preferencias_usuario.dart';

import 'src/pages/cursosforos_page.dart';
import 'src/pages/discusion_page.dart';
import 'src/pages/discusionpost_page.dart';
import 'src/pages/home_page.dart';
import 'src/pages/login_page.dart';
import 'src/pages/start_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();//Sirve para que las Preferencias de Usuario funcionen
  final prefs =  PreferenciasUsuario();
  await prefs.initPrefs();
  //await initializeDateFormatting('es_ES', null);
  //await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey _proKey =  GlobalKey();
  @override
  Widget build(BuildContext context) {
    final prefs =  PreferenciasUsuario();
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
        debugShowCheckedModeBanner: false,
        title: 'TFM',
        initialRoute: prefs.ultimaPagina,
        routes: {
          LoginPage.routeName : (BuildContext context)=> LoginPage(),
          StartPage.routeName : (BuildContext context)=> StartPage(),
          HomePage.routeName : (BuildContext context)=> HomePage(),
          CursoForosPage.routeName : (BuildContext context)=> CursoForosPage(),
          DiscusionPage.routeName : (BuildContext context)=> DiscusionPage(),
          DiscusionPostPage.routeName : (BuildContext context)=> DiscusionPostPage(),
          //AboutPage.routeName : (BuildContext context)=> AboutPage(),

        },
        theme: ThemeData(
          primaryColor: Colors.green,
          //primarySwatch: Color(0xFF1C1428),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      );
  }
}