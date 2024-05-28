// To parse this JSON data, do
//
//     final prenotazione = prenotazioneFromJson(jsonString);

import 'dart:convert';

Prenotazione prenotazioneFromJson(String str) => Prenotazione.fromJson(json.decode(str));

String prenotazioneToJson(Prenotazione data) => json.encode(data.toJson());

class Prenotazione {
    List<PrenotazioneElement> prenotazione;

    Prenotazione({
        required this.prenotazione,
    });

    factory Prenotazione.fromJson(Map<String, dynamic> json) => Prenotazione(
        prenotazione: List<PrenotazioneElement>.from(json["Prenotazione"].map((x) => PrenotazioneElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Prenotazione": List<dynamic>.from(prenotazione.map((x) => x.toJson())),
    };
}

class PrenotazioneElement {
    String cfCliente;
    String idCrociera;
    String dataPrenotazione;

    PrenotazioneElement({
        required this.cfCliente,
        required this.idCrociera,
        required this.dataPrenotazione,
    });

    factory PrenotazioneElement.fromJson(Map<String, dynamic> json) => PrenotazioneElement(
        cfCliente: json["cf_cliente"],
        idCrociera: json["id_crociera"],
        dataPrenotazione: json["data_prenotazione"],
    );

    Map<String, dynamic> toJson() => {
        "cf_cliente": cfCliente,
        "id_crociera": idCrociera,
        "data_prenotazione": dataPrenotazione,
    };
}
