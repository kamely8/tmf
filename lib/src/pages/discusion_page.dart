import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:tfmsentimentanalisis/src/models/model_curso.dart';
import 'package:tfmsentimentanalisis/src/models/model_cursoforo.dart';
import 'package:tfmsentimentanalisis/src/models/model_discusion.dart';
import 'package:tfmsentimentanalisis/src/providers/app_provider.dart';
import 'package:tfmsentimentanalisis/src/share_prefs/preferencias_usuario.dart';



class DiscusionPage extends StatefulWidget{
  static const String routeName = 'discusion';

  @override
  State<DiscusionPage> createState() => _DiscusionPageState();
}

class _DiscusionPageState extends State<DiscusionPage> {
  List<Discussion> _listItems= [];
  String _busqueda='';
  final _apiProvider = Provider();
  num countCall=0;

  _callme(String bus) async {

    if(_busqueda.compareTo('')!=0) {
      _listItems = await _apiProvider.getDiscuciones(bus);
      setState(() {

      });
    }
        //print('$buq, ${_opcionSeleccionada.toString()}, ${_prefs.uuid}');
        //return await _apiProvider.getCursos();

    }

  @override
  void initState() {
    _callme(_busqueda);
  }
  static final _prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    _prefs.ultimaPagina = 'home';
    _busqueda = (ModalRoute.of(context)!.settings.arguments as String?)!;
  if(countCall==0) {
    _callme(_busqueda);
    countCall=1;
  }
    //_callme();
    return Scaffold(
      //backgroundColor: Colors.black26,
      appBar: AppBar(
        centerTitle: false,
        title: Text('TFM App Discusion'),
        backgroundColor: Colors.black,
      ),
      body:
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child:
                _listItems.isNotEmpty ?
                       ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listItems.length,
                          itemBuilder: (context, int index) =>
                              _buildListItem(_listItems[index], context)
                      )

                 :
                Column(
                  children: const [
                    Text(
                      'Por favor Espere . . .',
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.brown,),
                    ),
                    SizedBox(
                      height: 200.0,
                      child: Center(child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFae957d)),
                      )),
                    ),
                  ],
                )
        ),
      ),

    );
  }

  Widget _buildListItem(Discussion items, BuildContext context) {
    final _size = MediaQuery.of(context).size;


    return
      Card(
        shadowColor: Colors.black,
        semanticContainer: true,
        borderOnForeground: true,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
            padding: const EdgeInsets.only(top:1.0, bottom: 4.0, left: 0.0),
            child: GestureDetector(
                child: Column(
                  children: [
                    ListTile(
                      selected: true,
                      // title:  Text(' ${items.numHD} ',style: TextStyle(color: Colors.brown,fontSize: 14.8,fontWeight: FontWeight.bold)),

                      subtitle: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Discusion ID: ${items.id} ',style: const TextStyle(color: Colors.brown,fontSize: 18,fontWeight: FontWeight.bold)),
                          Text('Nombre: ${items.name}',style: const TextStyle(color: Colors.brown,fontSize: 18,fontWeight: FontWeight.bold)),
                          //Text('Curso ID: ${items.course}',style: const TextStyle(color: Colors.brown,fontSize: 18,fontWeight: FontWeight.bold)),

                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.pushNamed(context,'discusionpost', arguments: items.id.toString());
                  //if (noc != null) {
                  //_mostrarNavegacion(context, items.pedido.toString());
                  // }
                  // if (pref.rol == 'APP_SUPERUSUARIO' || pref.rol == 'APP_LIDER') {

                  // } else {
                  //   Dialogos().mensajeError(
                  //       context, 'No tiene permisos suficientes', orientation);
                  // }
                  ////print('hola');
                }
            )
        ),
      );
  }
}