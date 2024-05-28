import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:greta_clientserverrest/accountcliente.dart';
import 'package:greta_clientserverrest/dao.dart';
import 'package:greta_clientserverrest/prenotazione.dart';
import 'package:http/http.dart' as http;
import "crociera.dart";
import "route.dart";
import "model.dart";
import "dao.dart";

class PrenotazioniPage extends StatefulWidget {
  final AccountClienti account;
  final PrenotazioneDao daoP;
  final List<CrocieraElement> cruises;

  PrenotazioniPage(this.account, this.daoP, this.cruises);

  @override
  _PrenotazioniPageState createState() => _PrenotazioniPageState();
}

class _PrenotazioniPageState extends State<PrenotazioniPage> {
  late Future<List<dynamic>?> _futurePrenotazioni;
  bool internet = false;
  CrocieraElement? _selectcruise;

  @override
  void initState() {
    super.initState();
    _futurePrenotazioni = fetchPrenotazioni(widget.account);
    _selectcruise = widget.cruises.isNotEmpty ? widget.cruises[0] : null;
    _initializeInternet();
  }

  Future<void> _initializeInternet() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.196.178/REST/Server/apirequest.php/connection'));
      print("RESPONSE " + response.body);
      print("STATUS CODE ${response.statusCode}");
      setState(() {
        internet = response.statusCode == 200;
      });
    } catch (e) {
      setState(() {
        internet = false;
      });
    }
    
    Timer(Duration(seconds: 3), () {
      if (!internet) {
        setState(() {
          internet = false;
        });
      }
    });
  }

  Future<List<dynamic>?> fetchPrenotazioni(AccountClienti account) async {
    if (!internet) {
      print("false");
      print(widget.daoP.getTodos());
      return widget.daoP.getTodos();
    } else {
      print("true");
      String id = account.cfCliente;
      try {
        final response = await http.get(Uri.parse(
            'http://192.168.196.178/REST/Server/apirequest.php/getreservation?cf_cliente=$id'));
        print("RISPOSTA !!! " + response.body);
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final List<dynamic> records = jsonData['records'];
          final List<PrenotazioneElement> routes = records
              .map((record) => PrenotazioneElement.fromJson(record))
              .toList();

          return routes;
        } else {
          throw Exception('Failed to load routes');
        }
      } catch (e) {
        throw Exception('Error: $e');
      }
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
    bool mio = internet;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.account.usernameCliente),
      ),
      body: _buildPrenotazioniList(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "stato della connessione: '$mio'",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: mio
                    ? null
                    : () {
                        // Azione da eseguire quando il bottone viene premuto
                      },
                child: Text(
                  'Riprova',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrenotazioniList() {
    setState(() {
          _futurePrenotazioni = fetchPrenotazioni(widget.account);
        });
    return FutureBuilder(
      future: _futurePrenotazioni,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Errore: ${snapshot.error}'));
        } else {
          List<dynamic> routes = snapshot.data!;
          print("QUESTE SONO LE ROUTES ${routes[0]}");
          return ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) {
              dynamic reserve = routes[index];
              return _buildReservationCard(reserve);
            },
          );
        }
      },
    );
  }

  Widget _buildReservationCard(dynamic reserve)  {
    CrocieraElement? cruise =  findCruiseById(int.parse(reserve.idCrociera));
    print(" VA?? ${cruise!.temaCrociera}");
    Color color = rainbowColors[int.parse(reserve.idCrociera) % rainbowColors.length];
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: color, width: 1),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.directions_boat, color: color),
            title: Text(cruise!.temaCrociera,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Il " +
                cruise.dataInizio +
                "  " +
                cruise.dataFine +
                "\nnella località: " +
                cruise.localita),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "http://192.168.196.178/cruises/" + cruise.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  modifyPrenotazione(
                      reserve.cfCliente, reserve.idCrociera);
                },
                child: Text('Modifica',
                    style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  deletePrenotazione(
                      cruise.idCrociera, reserve.cfCliente);
                },
                child: Text('Elimina',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Future<void> modifyPrenotazione(String cf_cliente, String id_crociera) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifica Prenotazione'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<CrocieraElement>(
                value: widget.cruises[0],
                onChanged: (CrocieraElement? newValue) {
                  setState(() {
                    _selectcruise = newValue!;
                  });
                },
                items: widget.cruises.map((CrocieraElement crociera) {
                  return DropdownMenuItem<CrocieraElement>(
                    value: crociera,
                    child: Text(crociera.temaCrociera),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  String apiUrl =
                      'http://192.168.196.178/REST/Server/apirequest.php/modifybooking';

                  Map<String, dynamic> requestBody = {
                    'cf_cliente': cf_cliente,
                    'id_crociera_old': id_crociera,
                    'id_crociera': _selectcruise!.idCrociera,
                    'data_prenotazione': DateTime.now().toString(),
                  };

                  String requestBodyJson = jsonEncode(requestBody);

                  http.Response response = await http.put(
                    Uri.parse(apiUrl),
                    body: requestBodyJson,
                  );

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('modifica avvenuta con successo!'),
                    ));
                    setState(() {
                      _futurePrenotazioni = fetchPrenotazioni(widget.account);
                    });
                    print('Prenotazione modificata con successo.');
                  } else {
                    print(
                        'Errore durante la modifica della prenotazione: ${response.body}');
                  }
                } catch (e) {
                  print('Errore: $e');
                }
                Navigator.pop(context);
              },
              child: Text('Salva'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deletePrenotazione(String id_crociera, String cf_cliente) async {
    print(id_crociera);
    print(cf_cliente);

    try {
      final response = await http.delete(
        Uri.parse(
            'http://192.168.196.178/REST/Server/apirequest.php/deletebooking'),
        body: jsonEncode(<String, String>{
          'id_crociera': id_crociera,
          'cf_cliente': cf_cliente,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('cancellazione avvenuta con successo!'),
        ));
        setState(() {
          _futurePrenotazioni = fetchPrenotazioni(widget.account);
        });
      } else {
        throw Exception('Failed to delete booking');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  CrocieraElement? findCruiseById(int idCrociera)  {
    print("VA??? ${widget.cruises[0].idCrociera}");

    for (CrocieraElement cruise in widget.cruises) {
      if (int.parse(cruise.idCrociera) == idCrociera) {
        return cruise;
      }
    }
    return null;
  }

  Future<CrocieraElement> fetchCruise(idCrociera) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.196.178/REST/Server/apirequest.php/getcruise?id_crociera=$idCrociera'));
      print("RISPOSTA !!! " + response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData.containsKey('id_crociera')) {
          return CrocieraElement.fromJson(jsonData);
        }
      }
      throw Exception('Failed to load routes');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
