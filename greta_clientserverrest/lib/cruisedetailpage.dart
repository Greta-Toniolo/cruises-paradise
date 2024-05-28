import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "crociera.dart";
import "route.dart";

class CruiseDetailPage extends StatefulWidget {
  final CrocieraElement cruise;

  CruiseDetailPage(this.cruise);

  @override
  _CruiseDetailPageState createState() => _CruiseDetailPageState();
}

class _CruiseDetailPageState extends State<CruiseDetailPage> {
  late Future<List<RouteElement>> _futureRoutes;

  @override
  void initState() {
    super.initState();
    _futureRoutes = fetchRoutes(widget.cruise);
  }

  Future<List<RouteElement>> fetchRoutes(CrocieraElement cruise) async {
    String id=cruise.idCrociera;
    try {
      final response = await http.get(
          Uri.parse('http://192.168.196.178/REST/Server/apirequest.php/getroutes?id_crociera=$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> records = jsonData['records'];
        final List<RouteElement> routes = records.map((record) => RouteElement.fromJson(record)).toList();
        
        return routes;
      } else {
        throw Exception('Failed to load routes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
List<Color> rainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cruise.temaCrociera),
      ),
      body: FutureBuilder(
        future: _futureRoutes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else {
            List<RouteElement> routes = snapshot.data!;
            return ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                Color color = rainbowColors[index % rainbowColors.length];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Bordo arrotondato
                    side: BorderSide(color: color, width: 1), // Bordo grigio sottile
                  ),
                  child: ListTile(
                    leading: Icon(Icons.location_on, color:color),
                    title: Text(routes[index].citta, style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(routes[index].dataOra),
                    // Implementa onTap per navigare a una pagina di dettaglio della route se necessario
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
