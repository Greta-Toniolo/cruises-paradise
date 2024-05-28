import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greta_clientserverrest/accountcliente.dart';
import 'package:greta_clientserverrest/prenotazioni.dart';
import 'package:http/http.dart' as http;
import 'crociera.dart';
import "cruisedetailpage.dart";
import "details.dart";
import "accountcliente.dart";
import "dao.dart";
import "database.dart";
import "model.dart";
import "prenotazione.dart";
import 'package:provider/provider.dart';
import "main.dart";


class HomePage extends StatefulWidget {
  final AccountClienti account;

  HomePage(this.account);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<CrocieraElement> _cruises = [];
  late PrenotazioneDao _daoP;

  @override
  void initState() {
   _initialize();
  // _daoP = Provider.of<DatabaseProvider>(context, listen: false).prenotazioneDao!;
 super.initState();
   
  }

  _initialize() async{
 _daoP=await _getDaoP();
  await _popolaDatabase();
   await  _fetchCruises();
  }

 Future<PrenotazioneDao> _getDaoP() async {
  
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database.prenotazioneDao;
    
  
}
  Future<void> _popolaDatabase() async {
    _daoP.deleteAll();
    var id = widget.account.cfCliente;
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.196.178/REST/Server/apirequest.php/getreservation?cf_cliente=$id'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> records = jsonData['records'];
        final List<PrenotazioneElement> routes =
            records.map((record) => PrenotazioneElement.fromJson(record)).toList();
        for (int i = 0; i < routes.length; i++) {
          _daoP.insertReserve(
              routes[i].cfCliente, int.parse(routes[i].idCrociera), routes[i].dataPrenotazione);
        }
      } else {
        throw Exception('Failed to load routes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> _fetchCruises() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.196.178/REST/Server/apirequest.php/getcruises'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> records = jsonData['records'];
        List<CrocieraElement> cruises = [];
        for (var record in records) {
          cruises.add(CrocieraElement(
            idCrociera: record['id_crociera'],
            dataInizio: record['data_inizio'],
            dataFine: record['data_fine'],
            durataCrociera: record['durata_crociera'],
            temaCrociera: record['tema_crociera'],
            idNave: record['id_nave'],
            img: record['img'],
            localita: record['localita'],
          ));
        }
        setState(() {
          _cruises = cruises;
        });
      } else {
        print("errore qui");
      }
    } catch (e) {
      print('Errore durante il recupero delle crociere: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cruises Paradise'),
        backgroundColor: const Color.fromARGB(255, 121, 203, 241),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _showBottomSheet(context);
            },
          ),
        ],
      ),
      body: _buildCruiseList(),
    );
  }

  Widget _buildCruiseList() {
    return ListView.builder(
      itemCount: _cruises.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: const BoxDecoration(),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(_cruises[index], widget.account),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      "http://192.168.196.178/cruises/" + _cruises[index].img,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _cruises[index].temaCrociera,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${_cruises[index].durataCrociera} giorni',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _cruises[index].localita,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrenotazioniPage(widget.account, _daoP, _cruises),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_outlined, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Visualizza Prenotazioni', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login_sharp, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text('Logout Cliente', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
