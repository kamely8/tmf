

import 'dart:async';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tfmsentimentanalisis/src/models/model_curso.dart';
import 'package:tfmsentimentanalisis/src/models/model_cursoforo.dart';
import 'package:tfmsentimentanalisis/src/models/model_discusion.dart';
import 'package:tfmsentimentanalisis/src/models/model_postdiscusion.dart';
import 'package:tfmsentimentanalisis/src/share_prefs/preferencias_usuario.dart';

class Provider{

  bool _cargando= false;
  bool _cargando1= false;

  static final _prefs = PreferenciasUsuario();


  Future<List<Cursos>> getCursos() async {

    //excluir el curso id: 1
    //print('getCursos');
    if(_cargando) return [];

    _cargando=true;

    String respuesta='';
    String url=_prefs.urlmoodel;
    String token=_prefs.token;
    print('TOKENNNNNNN');
    print(url);
    print(token);
    var request = http.Request('POST', Uri.parse('$url/rest/server.php?wstoken=$token&wsfunction=core_course_get_courses&moodlewsrestformat=json'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      respuesta=await response.stream.bytesToString();
      List<dynamic> decodeResp= json.decode(respuesta);
      //print(decodeResp);
      
      List<Cursos> lista= CursosModel().fromJsonList(decodeResp);
      return lista;
    }
    else {
      print(response.reasonPhrase);
    }
    _cargando=false;

    return[];

  }

  Future<List<Cursoforo>> getCursosForos(String idCurso) async {
    //print('getCursos');
    if(_cargando) return [];

    _cargando=true;
    String respuesta='';
    var request = http.MultipartRequest('POST', Uri.parse('${_prefs.urlmoodel}/rest/server.php?moodlewsrestformat=json'));
    request.fields.addAll({
      'wstoken': _prefs.token,
      'wsfunction': 'mod_forum_get_forums_by_courses',
      'courseids[0]': idCurso
    });

    //print(request);


    http.StreamedResponse response1 = await request.send();

    if (response1.statusCode == 200) {
      respuesta=await response1.stream.bytesToString();
      List<dynamic> decodeResp= json.decode(respuesta);
      //print(decodeResp);

      List<Cursoforo> lista= CursoForoModel().fromJsonList(decodeResp);
      return lista;
    }
    else {
      //print('error getCursosForos');
      print(response1.reasonPhrase);
    }

    _cargando=false;

    return [];
  }



  Future<List<Discussion>> getDiscuciones(String idCursoForo) async {
    //print('getDiscuciones');
    if(_cargando) return [];
    _cargando=true;

    String respuesta='';
    var request = http.MultipartRequest('POST', Uri.parse('${_prefs.urlmoodel}/rest/server.php?moodlewsrestformat=json'));
    request.fields.addAll({
      'wstoken': _prefs.token,
      'wsfunction': 'mod_forum_get_forum_discussions',
      'forumid': idCursoForo
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      respuesta=await response.stream.bytesToString();
      //List<dynamic> decodeResp= json.decode(respuesta);
      Map<String, dynamic> decodeResp= json.decode(respuesta);
      //print(decodeResp);

      List<Discussion> lista= DiscusionModel().fromJsonList(decodeResp['discussions']);
      return lista;
    }
    else {
      print(response.reasonPhrase);
    }

    _cargando=false;
    return [];
  }

  Future<List<Post>> getPostDiscusiones(String idDiscusion) async {
   /* {
          "posts": [
            {
            "id": 5,
            "message": "<div class=\"text_to_html\">yo creo que faltaba agregar algo mas interesante</div>"
            }

          ]
    }*/
    //condiderar quitar el etiquete html en el texto
    //print('getPostDiscusiones');
    if(_cargando) return [];
    _cargando=true;
    String respuesta='';
    var request = http.MultipartRequest('POST', Uri.parse('${_prefs.urlmoodel}/rest/server.php?moodlewsrestformat=json'));
    request.fields.addAll({
      'wstoken': _prefs.token,
      'wsfunction': 'mod_forum_get_discussion_posts',
      'discussionid': idDiscusion
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      respuesta=await response.stream.bytesToString();
      //List<dynamic> decodeResp= json.decode(respuesta);
      Map<String, dynamic> decodeResp= json.decode(respuesta);
      //print(decodeResp);

      List<Post> lista= DiscusionPostModel().fromJsonList(decodeResp['posts']);


      List<Post> listaaux=[];

      for(var itmes in lista){
        Post pitems=Post();
        pitems.id=itmes.id;
        pitems.message=itmes.message;
        String sentim= await getSentimiento(itmes.message.toString()) as String;
        //print('SENTIMIENTO');
        //print(sentim);
        pitems.sentiment= sentim;

        listaaux.add(pitems);
      }

      return listaaux;
    }
    else {
      print(response.reasonPhrase);
    }

    _cargando=false;
    return [];
  }

  Future<String> getSentimiento(String msjpostDiscusion) async {
    String respuesta='';
    var headers = {
      'Accept': 'application/json',
      'Content-Type': "application/x-www-form-urlencoded"
    };
    var request = http.Request('POST', Uri.parse('http://35.196.171.128:5000/sentiment'));
    request.body = json.encode({
      "data": msjpostDiscusion
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      respuesta=await response.stream.bytesToString();
      Map<String, dynamic> decodeResp= json.decode(respuesta);
      print(decodeResp);

      String sentimi=decodeResp['sentiment'];
      return sentimi;
    }
    else {
      respuesta=response.reasonPhrase.toString();
      print(respuesta);
    }
    return '';
  }

}