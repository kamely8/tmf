
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfmsentimentanalisis/src/providers/app_provider.dart';
import 'package:tfmsentimentanalisis/src/share_prefs/preferencias_usuario.dart';
import 'package:tfmsentimentanalisis/src/utils/utils.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final _prefs = PreferenciasUsuario();
  String? user='';
  String? pass='';

  //final appProvider = Provider();

  @override
  Widget build(BuildContext context) {
    //appProvider.getCursos();
    //appProvider.getSentimiento('mal curso no me gusta');
    //appProvider.getDiscuciones();
    //appProvider.getForo();
    //appProvider.getPostDiscusiones();
    _prefs.ultimaPagina = LoginPage.routeName;
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
              _crearEmail(),
              SizedBox(height: _size.height*0.012),
              _crearPassword(),
              SizedBox(height: _size.height*0.046),
              _crearBoton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearEmail(){

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.green),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',

                focusColor: Colors.tealAccent,
                labelStyle: TextStyle(color: Colors.white70),
                hintStyle: TextStyle(color: Colors.white30),
                helperStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
              onChanged: (value){
                user=value;
              },
              cursorColor: Colors.tealAccent,
              style: TextStyle(fontSize: 20.0, color: Colors.green),
            ),
          );
  }

  Widget _crearPassword(){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.green),
                labelText: 'Contraseña',
                //counterText: snapshot.data,
                //errorText: snapshot.error ==null ? '' : snapshot.error.toString(),
                labelStyle: TextStyle(color: Colors.white70),
                hintStyle: TextStyle(color: Colors.white54),
                helperStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
              onChanged: (value){
                pass=value;
              },
              cursorColor: Colors.white70,
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
              label: Text("Ingresar", style: TextStyle(
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
    //admin admin
    if(user!.compareTo('admin')==0 && pass!.compareTo('admin')==0){
      _prefs.uuid=user!;

      await pr1.hide();
      Navigator.pushReplacementNamed(context, 'start');
    }else{
      await pr1.hide();
      utils.mostrarAlerta(context, 'El usuario no existe!',1);
    }
  }
}