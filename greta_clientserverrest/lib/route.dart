// To parse this JSON data, do
//
//     final crociera = crocieraFromJson(jsonString);

import 'dart:convert';

Route crocieraFromJson(String str) => Route.fromJson(json.decode(str));

/*String crocieraToJson(Crociera data) => json.encode(data.toJson());*/

class Route {
    List<RouteElement> route;

    Route({
        required this.route,
    });

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        route: List<RouteElement>.from(json["route"].map((x) => RouteElement.fromJson(x))),
    );

   /* Map<String, dynamic> toJson() => {
        "crociera": List<dynamic>.from(crociera.map((x) => x.toJson())),
    };*/
}

class RouteElement {
      final String codicePercorso;
  final String dataOra;
  final String citta;
  final String idCrociera;

    RouteElement({
        required this.codicePercorso,
        required this.dataOra,
        required this.citta,
        required this.idCrociera,
    });

    factory RouteElement.fromJson(Map<String, dynamic> json) {
  return RouteElement(
    codicePercorso: json["codice_percorso"] ?? '',
    dataOra: json["data_ora"] ?? '',
    citta: json["citta"] ?? '',
    idCrociera: json["id_crociera"] ?? '',
  );
}
/*
    Map<String, dynamic> toJson() => {
        "id_crociera": idCrociera,
        "data_inizio": "${dataInizio.year.toString().padLeft(4, '0')}-${dataInizio.month.toString().padLeft(2, '0')}-${dataInizio.day.toString().padLeft(2, '0')}",
        "data_fine": "${dataFine.year.toString().padLeft(4, '0')}-${dataFine.month.toString().padLeft(2, '0')}-${dataFine.day.toString().padLeft(2, '0')}",
        "durata_crociera": durataCrociera,
        "tema_crociera": temaCrociera,
        "id_nave": idNave,
        "localita": localita,
    };*/
}