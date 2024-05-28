import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

final TextEditingController cfController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController repeatPasswordController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController surnameController = TextEditingController();

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrazione'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Codice Fiscale
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  // Password
                  Expanded(
                    child: TextField(
                      controller: surnameController,
                      decoration: InputDecoration(labelText: 'Cognome'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Codice Fiscale
                  Expanded(
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Password
                  Expanded(
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Codice Fiscale
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: 'Telefono'),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  // Password
                  Expanded(
                    child: TextField(
                      controller: cfController,
                      decoration: InputDecoration(labelText: 'Codice Fiscale'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Codice Fiscale
                  Expanded(
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  // Password
                  Expanded(
                    child: TextField(
                      controller: repeatPasswordController,
                      decoration: InputDecoration(labelText: 'Ripeti Password'),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              // Ripeti Password
              ElevatedButton(
                onPressed: () {
                  _registration(context);
                },
                child: Text('Registrati'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_registration(BuildContext context) async {
  // Effettua la registrazione
  String cf = cfController.text;
  String password = passwordController.text;
  String repeatPassword = repeatPasswordController.text;
  String username = usernameController.text;
  String phone = phoneController.text;
  String email = emailController.text;
  String name = nameController.text;
  String surname = surnameController.text;

  // Esegui la logica di registrazione qui
  // Verifica se i campi sono validi
  if (password != repeatPassword) {
    // Password non corrispondenti, mostra un messaggio di errore
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Le password non corrispondono.'),
    ));
    return; // Interrompi la registrazione se le password non corrispondono
  } else {
    var url1 =
        Uri.parse('http://192.168.196.178/REST/Server/apirequest.php/newclient');
    try {
      // Invia la richiesta GET al server
      var response = await http.post(url1, body: {
        'fiscalcode': cf,
        'nome': name,
        'cognome': surname,
        'email': email,
        'phone': phone
      });
      print("RISPOSTA " + response.body);

      if (response.statusCode == 200) {
        print("RISPOSTA " + response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('registrazione avvenuto con successo!.'),
        ));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
        // Login riuscito, naviga alla pagina successiva
      }
    } catch (e) {
      // Gestisci l'eccezione, ad esempio mostrando un messaggio di errore
      print('Errore durante la richiesta HTTP: $e');
    }

    var url =
        Uri.parse('http://192.168.196.178/REST/Server/apirequest.php/newuser');
    try {
      // Invia la richiesta GET al server
      var response = await http.post(url, body: {
        'username': username,
        'password': repeatPassword,
        'fiscalcode': cf,
      });
      print("RISPOSTA " + response.body);

      if (response.statusCode == 200) {
        print("RISPOSTA " + response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('registrazione avvenuto con successo!.'),
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
    }
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Registrazione completata con successo.'),
  ));
}
