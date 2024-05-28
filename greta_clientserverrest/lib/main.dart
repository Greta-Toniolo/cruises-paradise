import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greta_clientserverrest/accountcliente.dart';
import 'package:greta_clientserverrest/elenco.dart';
import 'package:greta_clientserverrest/registration.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:provider/provider.dart';
import 'dao.dart';
import "database.dart";
void main() {
  runApp(
  
       MaterialApp(
              home: LoginPage(),
            ),
          );
}
class DatabaseProvider extends ChangeNotifier {
  late PrenotazioneDao? _prenotazioneDao;

  // Metodo per inizializzare il database e il dao
  Future<void> initDatabase() async {
    _prenotazioneDao = await _getDaoP();
    notifyListeners();
  }

PrenotazioneDao? get prenotazioneDao => _prenotazioneDao!;
}
  Future<PrenotazioneDao?> _getDaoP() async {
  try {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database.prenotazioneDao;
    
  } catch (e) {
    return null;
    debugPrint("Errore durante la creazione del database: $e");
    // Gestisci l'errore in modo appropriato, ad esempio mostrando un messaggio di errore all'utente o riprovando la creazione del database.
  }
}


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  late AccountClienti account;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
 
@override
  void initState() {
 super.initState();
  // Call initDatabase method directly
}

void initDatabase() async {
  await Provider.of<DatabaseProvider>(context, listen: false).initDatabase();
}

  void _login() async {
    print("CIAO");
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      // Gestisci l'errore se username o password sono vuoti
      return;
    }

    // Esegui l'hash della password
    String hashedPassword = hashPassword(password);
      print("CIAOooo");
     var url = Uri.parse(
        'http://192.168.196.178/REST/Server/apirequest.php/getcfcliente?username=$username');
        print("CIAOoooOOO");

    try {
      // Invia la richiesta GET al server
      var response = await http.get(url);
      print("CIAOoooOOO QUI");
      print("RISPOSTA " + response.body);
      var $cfCliente= response.body;
      account= new AccountClienti( usernameCliente: '$username', passwordCliente: '$password', cfCliente: $cfCliente, dipendente: 'false');
      if (response.statusCode == 200) {
        print("RISPOSTA " + response.body);
        // Login riuscito, naviga alla pagina successiva
      } 
        // Gestisci l'errore del login fallito
        // Ad esempio, visualizza un messaggio di err
    } catch (e) {
      // Gestisci l'eccezione, ad esempio mostrando un messaggio di errore
      print('Errore durante la richiesta HTTP: $e');
    }
  
    // Invia la richiesta al server
    // Costruisci l'URL della richiesta GET con i parametri della query string
    var url1 = Uri.parse(
        'http://192.168.196.178/REST/Server/apirequest.php/getpassword?username=$username&password=$password');

    try {
      // Invia la richiesta GET al server
      var response = await http.get(url1);
      print("RISPOSTA " + response.body);
      if (response.statusCode == 200) {
        print("RISPOSTA " + response.body);
        // Login riuscito, naviga alla pagina successiva
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(account)),
        );
      } else {
        // Gestisci l'errore del login fallito
        // Ad esempio, visualizza un messaggio di errore
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Errore di login'),
            content: Text('Username o password non validi. Riprova'),
            actions: [
              TextButton(
                onPressed: () {
                  // Chiudi il dialog e cancella i testi nei campi di testo
                  Navigator.pop(context);
                  //_usernameController.clear();
                  _passwordController.clear();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Gestisci l'eccezione, ad esempio mostrando un messaggio di errore
      print('Errore durante la richiesta HTTP: $e');
    }
  }

  String hashPassword(String password) {
    // Esegui l'hash della password utilizzando l'algoritmo SHA256
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
Widget build(BuildContext context) {
  return 
        // Database initialized, build login UI
       Scaffold(
          appBar: AppBar(
            title: Text('Cruises Paradise'),
          ),
          body: Stack(
            children: [
              // Sfondo con immagine
              Positioned.fill(
                child: Image.network(
                  "http://192.168.196.178/cruises/home-14.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              // Form di login
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Cruises Paradise!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.person, color: Colors.black,), // Icona dell'utente
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.lock, color: Colors.black), // Icona del lucchetto
                        ),
                      ),
                      SizedBox(height: 5.0),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Login', style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(height: 25.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationPage(),
                            ),
                          );
                        },
                        child: Text('Non hai un Account?', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
  }