
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario{

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }

  PreferenciasUsuario._internal();
  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  String get token {
    return _prefs!.getString('token') ?? '64f05868715bfd291f7ae07d600b5b27';
  }

  set token( String value ) {
    _prefs!.setString('token', value);
  }


  // GET y SET del apikey
  String get apikey {
    return _prefs!.getString('apikey') ?? '64f05868715bfd291f7ae07d600b5b27';
  }

  set apikey( String value ) {
    _prefs!.setString('apikey', value);
  }

  // GET y SET del url
  String get urlmoodel {
    return _prefs!.getString('urlmoodel') ?? 'https://misitiotfm.moodlecloud.com/webservice';
  }

  set urlmoodel( String value ) {
    _prefs!.setString('urlmoodel', value);
  }

  // GET y SET del UUID
  String get uuid {
    return _prefs!.getString('uuid') ?? '';
  }



  set uuid( String value ) {
    _prefs!.setString('uuid', value);
  }

  // GET y SET del nombre
  String get nombre {
    return _prefs!.getString('nombre') ?? '';
  }

  set nombre( String value ) {
    _prefs!.setString('nombre', value);
  }

  // GET y SET del tipo
  String get tipouser {
    return _prefs!.getString('tipo') ?? '';
  }

  set tipouser( String value ) {
    _prefs!.setString('tipo', value);
  }

  //GET y SET del ultimaPagina
  String get ultimaPagina{
    return _prefs!.getString('ultimaPagina')?? 'login';
  }

  set ultimaPagina(String value){
    _prefs!.setString('ultimaPagina', value);
  }



}