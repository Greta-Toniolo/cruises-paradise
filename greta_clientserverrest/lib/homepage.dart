import 'package:flutter/material.dart';

// Esempio di dati di crociera
List<Map<String, dynamic>> crociere = [
  {
    "tema": "San Valentino",
    "durata": "3",
    "localita": "Italia",
  },
  {
    "tema": "Estate",
    "durata": "10",
    "localita": "Maldive",
  },
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageVera(),
    );
  }
}

class HomePageVera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scopri le novità!!'),
        backgroundColor: const Color.fromARGB(255, 220, 84, 84), // Colore dell'appbar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue], // Colori del gradiente
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: crociere.length,
          itemBuilder: (context, index) {
            return _buildCrocieraCard(crociere[index]);
          },
        ),
      ),
    );
  }

  Widget _buildCrocieraCard(Map<String, dynamic> crociera) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            crociera['tema'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Durata: ${crociera['durata']} giorni',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 16),
              Text(
                'Location: ${crociera['localita']}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
