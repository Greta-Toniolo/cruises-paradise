import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greta_clientserverrest/accountcliente.dart';
import 'package:http/http.dart' as http;
import "crociera.dart";
import "route.dart";
import "cruisedetailpage.dart";
import "accountcliente.dart";
import "main.dart";

class DetailPage extends StatefulWidget {
  final CrocieraElement cruise;
  final AccountClienti account;

  DetailPage(this.cruise, this.account);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Color> rainbowColors = [
    Colors.red,
    Colors.orange,
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
    backgroundColor: Colors.transparent, // Imposta lo sfondo trasparente
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.orange, Colors.purple], // Cambia i colori del gradiente come preferisci
      ),
    ),
  ),
  ),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: Image.network(
                  "http://192.168.196.178/cruises/" + widget.cruise.img,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
  text: TextSpan(
    children: [
      for (int i = 0; i < widget.cruise.temaCrociera.length; i++)
        TextSpan(
          text: widget.cruise.temaCrociera[i],
          style: TextStyle(
            color: rainbowColors[i % rainbowColors.length], 
            fontWeight: FontWeight.bold, // Rende il testo grassetto
            fontSize: 24.0,// Utilizza un colore dell'arcobaleno per ciascuna lettera
          ),
        ),
    ],
  ),
  
),
                    SizedBox(height: 8.0),
                    Text(
                      widget.cruise.durataCrociera+" giorni",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.cruise.dataInizio +
                          " fino al " +
                          widget.cruise.dataFine,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _showConfirmationDialog(context);
                    },
                    icon: Icon(Icons.book, color: Colors.black,),
                    label: Text('Prenota ora!',  style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Azione quando viene premuto il pulsante "Visualizza percorso"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CruiseDetailPage(widget.cruise),
                        ),
                      );
                    },
                    icon: Icon(Icons.map, color: Colors.black,),
                    label: Text('Visualizza percorso', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    ),
  ),
);
  }
  void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Conferma prenotazione'),
      content: Text('Confermi la prenotazione della crociera ${widget.cruise.temaCrociera} della durata di ${widget.cruise.durataCrociera} giorni nella località ${widget.cruise.localita}?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Chiude il dialog
          },
          child: Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop(); 
            var url = Uri.parse('http://192.168.196.178/REST/Server/apirequest.php/newreserve');
           try {
            DateTime today = DateTime.now();
      // Invia la richiesta GET al server
      print("QUESTO è IL CODICE FISCALE" + widget.account.cfCliente);
      var response = await http.post(url, body: {
  'cf_cliente': widget.account.cfCliente,
  'id_crociera': widget.cruise.idCrociera,
  'data_prenotazione': today.toString(),
});   
      print("RISPOSTA " + response.body);

      if (response.statusCode == 200) {
        _showConfirmationMessage(context);
        print("RISPOSTA " + response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('registrazione avvenuta con successo!.'),
              ));
        // Login riuscito, naviga alla pagina successiva
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } 
    } catch (e) {
      // Gestisci l'eccezione, ad esempio mostrando un messaggio di errore
      print('Errore durante la richiesta HTTP: $e');
    }// Chiude il dialog
             // Mostra il messaggio di conferma
          },
          child: Text('Conferma'),
        ),
      ],
    ),
  );
}

void _showConfirmationMessage(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Prenotazione confermata'),
      content: Text('La prenotazione della crociera ${widget.cruise.temaCrociera} è stata confermata con successo.'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Chiude il dialog
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}


}
