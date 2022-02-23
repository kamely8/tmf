import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tfmsentimentanalisis/src/models/model_curso.dart';
import 'package:tfmsentimentanalisis/src/models/model_cursoforo.dart';
import 'package:tfmsentimentanalisis/src/models/model_discusion.dart';
import 'package:tfmsentimentanalisis/src/models/model_postdiscusion.dart';
import 'package:tfmsentimentanalisis/src/providers/app_provider.dart';
import 'package:tfmsentimentanalisis/src/share_prefs/preferencias_usuario.dart';



class DiscusionPostPage extends StatefulWidget{
  static const String routeName = 'discusionpost';

  @override
  State<DiscusionPostPage> createState() => _DiscusionPostPageState();
}

class _DiscusionPostPageState extends State<DiscusionPostPage> {
  List<Post> _listItems= [];
  String _busqueda='1';
  final _apiProvider = Provider();
  num countCall=0;

  num positivos=0;
  num negativos=0;
  num neutrales=0;

  _callme(String bus) async {
    if(_busqueda.compareTo('')!=0) {
      _listItems = await _apiProvider.getPostDiscusiones(bus);
      setState(() {

      });
    }

  }

  @override
  void initState() {
    _callme(_busqueda);
   // _callme2('');
  }

  static final _prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    _prefs.ultimaPagina = 'home';
    //_busqueda = (ModalRoute.of(context)!.settings.arguments as String?)!;
    if(_busqueda.isEmpty){
      _busqueda='1';
      _callme(_busqueda);
    }
  if(countCall==0) {
    _callme(_busqueda);
    countCall=1;
  }
    //_callme();
    return Scaffold(
      //backgroundColor: Colors.black26,
      appBar: AppBar(
        centerTitle: false,
        title: Text('TFM App Discusion Post'),
        backgroundColor: Colors.black,
      ),
      body:
      Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0),
        child:
              _listItems.isNotEmpty ?
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Text(
                           'Dashboard TFM Resumen',
                           style: TextStyle(fontFamily: 'Montserrat',fontSize: 22.0, fontWeight: FontWeight.w900, color: Colors.black45,),
                         ),
                         SizedBox(height: 1.0,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,

                           children: [
                             Flexible(child: _positivos()),
                             Flexible(child: _neutrales()),
                             Flexible(child: _negativos()),
                           ],
                         ),
                         SizedBox(height: 2.0,),
                         Text(
                           'Total ${positivos+neutrales+negativos}',
                           style: TextStyle(fontFamily: 'Montserrat',fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black45,),
                         ),
                         Text(
                           '100%',
                           style: TextStyle(fontFamily: 'Montserrat',fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black45,),
                         ),
                         SizedBox(height: 3.0,),
                         Flexible(
                           child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _listItems.length,
                              itemBuilder: (context, int index) =>
                                  _buildListItem(_listItems[index], context)
                    ),
                         ),
                       ],
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

    );
  }

  Widget _buildListItem(Post items, BuildContext context) {
    final _size = MediaQuery.of(context).size;
    String msj=_parseHtmlString(items.message.toString());
    print(msj);

    if(items.sentiment!.compareTo('POSITIVO')==0){
      positivos++;
    }else if(items.sentiment!.compareTo('NEUTRAL')==0){
      neutrales++;
    }else if(items.sentiment!.compareTo('NEGATIVO')==0){
      negativos++;
    }
    print('POSITIVOS $positivos');
    print('NEUTR $neutrales');
    print('NEGAT $negativos');

    //print(sentimiento);
    return
      Card(
        shadowColor: Colors.black,
        semanticContainer: true,
        borderOnForeground: true,
        elevation: 15.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
            padding: const EdgeInsets.only(top:3.0, bottom: 8.0, left: 16.0, right: 16.0),
            child: GestureDetector(
                child: Column(
                  children: [
                    ListTile(
                      trailing: Text('Resultado ${items.sentiment.toString()}',
                      style: const TextStyle(fontFamily: 'Montserrat',fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.purple,),),


                      /*Flexible(
                        child: FutureBuilder(
                          future: _apiProvider.getSentimiento(items.message.toString()),
                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              return Flexible(
                                child: Text(snapshot.data.toString(),
                                  style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.brown,),),
                              );
                            }
                            else{
                              return
                                  const SizedBox(
                                    height: 10.0,
                                    child: Center(child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFae957d)),
                                    )),
                                  );

                            }
                          }
                        ),
                      ),*/
                      selected: true,
                      // title:  Text(' ${items.numHD} ',style: TextStyle(color: Colors.brown,fontSize: 14.8,fontWeight: FontWeight.bold)),

                      subtitle: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Discusion Post ID: ${items.id} ',style: const TextStyle(fontFamily: 'Montserrat',color: Colors.brown,fontSize: 19,fontWeight: FontWeight.w900)),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0, left: 8.0, right: 8.0),
                            child: Text('Mensaje: $msj',style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.brown
                            ),),
                          ),
                          //Text('Curso ID: ${items.course}',style: const TextStyle(color: Colors.brown,fontSize: 18,fontWeight: FontWeight.bold)),

                        ],
                      ),

                    ),
                  ],
                ),
                onTap: () async {
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
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  Widget _positivos(){
    double aux= positivos==0? 0: ((positivos*100)/(positivos+negativos+neutrales))/100;
    double aux1= aux==0? 0: aux*100;
    return Card(
      shadowColor: Colors.black,
      semanticContainer: true,
      borderOnForeground: true,
      elevation: 15.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
          padding: const EdgeInsets.only(top:24.0, bottom: 24.0, left: 24.0, right: 24.0),
          child: GestureDetector(
              child: CircularPercentIndicator(
                radius: 98.0,
                lineWidth: 11.0,
                //animation: true,
                percent: aux,
                center: Text('${aux1.toStringAsFixed(2)}%', style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.brown,
                    fontWeight: FontWeight.w900,
                    fontSize: 30.5)),
                footer: Column(
                  children: <Widget>[
                    const Text(
                      "Resultados",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown
                      ),
                    ),
                    Text('Positivos $positivos',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xff2CAF4A),
                            fontWeight: FontWeight.w200,
                            fontSize: 17.5)),
                    SizedBox(width: 10.0),

                  ],
                ),
                progressColor: Colors.green,
                backgroundColor:Colors.black12,
              ),

              onTap: () async {

              }
          )
      ),
    );
  }

  Widget _neutrales(){
    double aux= neutrales==0? 0: ((neutrales*100)/(positivos+negativos+neutrales))/100;
    double aux1= aux==0? 0: aux*100;
    return Card(
      shadowColor: Colors.black,
      semanticContainer: true,
      borderOnForeground: true,
      elevation: 15.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
          padding: const EdgeInsets.only(top:24.0, bottom: 24.0, left: 24.0, right: 24.0),
          child: GestureDetector(
              child: CircularPercentIndicator(
                radius: 98.0,
                lineWidth: 11.0,
                //animation: true,
                percent: aux,
                center: Text('${aux1.toStringAsFixed(2)}%', style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.brown,
                      fontWeight: FontWeight.w900,
                      fontSize: 30.5)),
                footer: Column(
                  children: <Widget>[
                    Text(
                      "Resultados",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown
                      ),
                    ),
                    Text('Neutrales $neutrales',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xff2CAF4A),
                            fontWeight: FontWeight.w200,
                            fontSize: 17.5)),
                    SizedBox(width: 10.0),

                  ],
                ),
                progressColor:Colors.amberAccent,
                backgroundColor:Colors.black12,
              ),

              onTap: () async {

              }
          )
      ),
    );
  }

  Widget _negativos(){
    double aux= negativos==0? 0: ((negativos*100)/(positivos+negativos+neutrales))/100;
    double aux1= aux==0? 0: aux*100;
    return Card(
      shadowColor: Colors.black,
      semanticContainer: true,
      borderOnForeground: true,
      elevation: 15.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
          padding: const EdgeInsets.only(top:24.0, bottom: 24.0, left: 24.0, right: 24.0),
          child: GestureDetector(
              child: CircularPercentIndicator(
                radius: 98.0,
                lineWidth: 11.0,
                //animation: true,
                percent: aux,
                center: Text('${aux1.toStringAsFixed(2)}%', style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.brown,
                    fontWeight: FontWeight.w900,
                    fontSize: 30.5)),
                footer: Column(
                  children:  <Widget>[
                    Text(
                      "Resultados",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown
                      ),
                    ),
                    Text('Negativos $negativos',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xff2CAF4A),
                            fontWeight: FontWeight.w200,
                            fontSize: 17.5)),
                    SizedBox(width: 10.0),

                  ],
                ),
                progressColor: Colors.redAccent,
                backgroundColor:Colors.black12,
              ),

              onTap: () async {

              }
          )
      ),
    );
  }
}