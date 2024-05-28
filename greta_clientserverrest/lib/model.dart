import 'package:floor/floor.dart';
@Entity(tableName: "Reserve")
class Reserve {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String cfCliente;

  final String idCrociera;

  final String dataPrenotazione;

  Reserve(this.id, this.cfCliente, this.idCrociera, this.dataPrenotazione);
}

@Entity(tableName: "Cruise")
class Cruise {
  @PrimaryKey()
  final int idCrociera;
final String dataInizio;
final String dataFine;
final int durataCrociera;
final String temaCrociera;
final int idNave;
final String img;
final String localita;
  Cruise(this.idCrociera, this.dataInizio, this.dataFine, this.durataCrociera, this.temaCrociera, this.idNave, this.img, this.localita);
}

