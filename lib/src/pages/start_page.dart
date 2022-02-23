
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfmsentimentanalisis/src/providers/app_provider.dart';
import 'package:tfmsentimentanalisis/src/share_prefs/preferencias_usuario.dart';
import 'package:tfmsentimentanalisis/src/utils/utils.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

class StartPage extends StatefulWidget {
  static const String routeName = 'start';
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  static final _prefs = PreferenciasUsuario();
  String? url='';
  String? token='';

  //final appProvider = Provider();

  @override
  Widget build(BuildContext context) {
    //appProvider.getCursos();
    //appProvider.getSentimiento('mal curso no me gusta');
    //appProvider.getDiscuciones();
    //appProvider.getForo();
    //appProvider.getPostDiscusiones();
    _prefs.ultimaPagina = 'login';
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black87,
      body: Stack(
        children: <Widget>[
          _loginForm(context),
        ],
      ) ,
    );
  }


  Widget _loginForm(BuildContext context){
    final _size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Image.asset(
                  "assets/ic_icon_app.png",
                  height: 160,
                  width:160,
                  fit: BoxFit.contain,
                ),
              ),
              // Text('Ingreso', style: TextStyle(fontSize: 20.0)),
              // SizedBox(height: _size.height*0.016),
              SizedBox(height: _size.height*0.038),
              Text('TFM', style: TextStyle(fontSize: 18.0 ,color: Colors.green, fontWeight: FontWeight.w300)),
              SizedBox(height: _size.height*0.018),
              _crearUrl(),
              SizedBox(height: _size.height*0.012),
              _crearToken(),
              SizedBox(height: _size.height*0.046),
              _crearBoton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearUrl(){

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.green),
                hintText: 'URL Moodel',
                labelText: 'URL Moodle',

                focusColor: Colors.tealAccent,
                labelStyle: TextStyle(color: Colors.white70),
                hintStyle: TextStyle(color: Colors.white30),
                helperStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
              onChanged: (value){
                url=value;
              },
              cursorColor: Colors.tealAccent,
              style: TextStyle(fontSize: 20.0, color: Colors.green),
            ),
          );
  }

  Widget _crearToken(){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.green),
          hintText: 'Token',
          labelText: 'Token',

          focusColor: Colors.tealAccent,
          labelStyle: TextStyle(color: Colors.white70),
          hintStyle: TextStyle(color: Colors.white30),
          helperStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
        ),
        onChanged: (value){
          token=value;
        },
        cursorColor: Colors.tealAccent,
        style: TextStyle(fontSize: 20.0, color: Colors.green),
      ),
    );
  }

  Widget _crearBoton() {

          return Container(
            width: 280,
            height: 54,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrangeAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.white),
                ),
                elevation: 0.0,
                //textStyle: TextStyle(fontSize: 16, color: Colors.white ),
              ),
              onPressed: (){
                _login(context);
              },
              label: Text("Actualizar", style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12.8,
                fontWeight: FontWeight.normal,
                color:Colors.white,
              ),),
              icon: Icon(
                Icons.person,
                color: Colors.white,size: 26.0,),
            ),
          );
  }

  _login(BuildContext context) async{
    ProgressDialog pr1 = ProgressDialog(context);

    pr1.style(
        message: 'Iniciando, Por favor espere...',
        borderRadius: 20.0,
        backgroundColor: Colors.white,
        progressWidget: CupertinoActivityIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black87, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black87, fontSize: 13.8, fontWeight: FontWeight.w400)
    );

    //pr1 =  ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    await pr1.show();
    print('${_prefs.urlmoodel} uuuu');
    print('${_prefs.token} tttt');

    if(url!.isNotEmpty && token!.isNotEmpty) {
      _prefs.urlmoodel = url!;
      _prefs.token = token!;
    }

      await pr1.hide();
      Navigator.pushNamed(context, 'home');
    /*}else{
      await pr1.hide();
      utils.mostrarAlerta(context, 'Existen Campos Vacios!',1);
    }*/
  }
}