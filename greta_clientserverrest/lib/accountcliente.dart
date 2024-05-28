// To parse this JSON data, do
//
//     final accountCliente = accountClienteFromJson(jsonString);

import 'dart:convert';

AccountCliente accountClienteFromJson(String str) => AccountCliente.fromJson(json.decode(str));

String accountClienteToJson(AccountCliente data) => json.encode(data.toJson());

class AccountCliente {
    List<AccountClienti> accountClienti;

    AccountCliente({
        required this.accountClienti,
    });

    factory AccountCliente.fromJson(Map<String, dynamic> json) => AccountCliente(
        accountClienti: List<AccountClienti>.from(json["AccountClienti"].map((x) => AccountClienti.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "AccountClienti": List<dynamic>.from(accountClienti.map((x) => x.toJson())),
    };
}

class AccountClienti {
    String usernameCliente;
    String passwordCliente;
    String cfCliente;
    String dipendente;

    AccountClienti({
              required this.usernameCliente,
        required this.passwordCliente,
        required this.cfCliente,
        required this.dipendente,
    });

    factory AccountClienti.fromJson(Map<String, dynamic> json) => AccountClienti(
        usernameCliente: json["username_cliente"],
        passwordCliente: json["password_cliente"],
        cfCliente: json["cf_cliente"],
        dipendente: json["dipendente"],
    );

    Map<String, dynamic> toJson() => {
        "username_cliente": usernameCliente,
        "password_cliente": passwordCliente,
        "cf_cliente": cfCliente,
        "dipendente": dipendente,
    };
}
