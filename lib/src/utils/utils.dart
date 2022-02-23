
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool isNoEmpty(String s){
  return (s.isEmpty) ? false : true;
}

bool isNumeric(String s){
  if(s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;

}

bool isNumericHora(String s){
  if(s.isEmpty) return false;
  final n = num.tryParse(s);
  if(n == null) return false;
  return (n >= 0 && n<=23) ? true : false;
}

bool isNumericMinutos(String s){
  if(s.isEmpty) return false;
  final n = num.tryParse(s);
  if(n == null) return false;
  return (n >= 0 && n<=60) ? true : false;

}

 void mostrarAlerta(BuildContext context, String msj, int typeMsj){
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Row(
            children: [
              Text(' Sistema'),
            ],
          ),
          content: Row(
            children: [
              typeMsj==1 ?
                Image.asset('assets/ic_info_tri.png',width: 32.0,height: 32.0,)
              :
               Image.asset('assets/ic_error.png',width: 32.0,height: 32.0,),
              SizedBox(width: 6.0,),
              Expanded(child: Text(msj)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: ()=> Navigator.of(context).pop(),
            )
          ],
        );
      }
  );
 }

void mostrarMensaje(BuildContext context, String msj){
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Row(
            children: [
              Text(' Sistema'),
            ],
          ),
          content: Row(
            children: [
              Image.asset('assets/ic_informativo.png',width: 32.0,height: 32.0,color: Colors.green,),
              SizedBox(width: 6.0,),
              Expanded(child: Text(msj)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: ()=> Navigator.of(context).pop(),
            )
          ],
        );
      }
  );
}

void msjErrorToast(String msj){
  Fluttertoast.showToast(
      msg: msj,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 22.0
  );
}

void msjAlertToast(String msj){
  Fluttertoast.showToast(
      msg: msj,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 22.0
  );
}