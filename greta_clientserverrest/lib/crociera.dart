// To parse this JSON data, do
//
//     final crociera = crocieraFromJson(jsonString);

import 'dart:convert';

Crociera crocieraFromJson(String str) => Crociera.fromJson(json.decode(str));

/*String crocieraToJson(Crociera data) => json.encode(data.toJson());*/

class Crociera {
    List<CrocieraElement> crociera;

    Crociera({
        required this.crociera,
    });

    factory Crociera.fromJson(Map<String, dynamic> json) => Crociera(
        crociera: List<CrocieraElement>.from(json["crociera"].map((x) => CrocieraElement.fromJson(x))),
    );

   /* Map<String, dynamic> toJson() => {
        "crociera": List<dynamic>.from(crociera.map((x) => x.toJson())),
    };*/
}

class CrocieraElement {
    String idCrociera;
    String dataInizio;
    String dataFine;
    String durataCrociera;
    String temaCrociera;
    String idNave;
    String img;
    String localita;

    CrocieraElement({
        required this.idCrociera,
        required this.dataInizio,
        required this.dataFine,
        required this.durataCrociera,
        required this.temaCrociera,
        required this.idNave,
        required this.img,
        required this.localita,
    });

    factory CrocieraElement.fromJson(Map<String, dynamic> json) {
  return CrocieraElement(
    idCrociera: json["id_crociera"] ?? '',
    dataInizio: json["data_inizio"] ?? '',
    dataFine: json["data_fine"] ?? '',
    durataCrociera: json["durata_crociera"] ?? '',
    temaCrociera: json["tema_crociera"] ?? '',
    idNave: json["id_nave"] ?? '',
    img: json["img"] ?? '',
    localita: json["localita"] ?? '',
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
