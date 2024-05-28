import 'package:floor/floor.dart';

import 'model.dart';

@dao
abstract class PrenotazioneDao {
  @Query('SELECT * FROM Reserve')
  Future<List<Reserve>> getTodos();

  @Query('SELECT * FROM Prenotazione WHERE cf_cliente = :cf')
  Future<List<Reserve>> findPrenotazioneByCf(String cf);

  @insert
  Future<void> insertPrenotazione(Reserve item);

  @insert
  Future<void> insertPrenotazioni(List<Reserve> items);

  @update
  Future<void> updatePrenotazioni(List<Reserve> items);

  @Query(
      'UPDATE `Prenotazione` SET `idCrociera`= :idCrociera WHERE idCrociera= :id_crociera_old')
  Future<void> updatePrenotazione(int idCrociera, int id_crociera_old);

 
   @Query('INSERT INTO Reserve (cfCliente, idCrociera, dataPrenotazione) VALUES (:cfCliente, :idCrociera, :dataPrenotazione)')
  Future<void> insertReserve(String cfCliente, int idCrociera, String dataPrenotazione);


  @delete
  Future<void> deletePrenotazione(Reserve items);

  @Query('DELETE FROM Reserve')
  Future<void> deleteAll();
}

@dao
abstract class CruiseDao {
  @Query('SELECT * FROM Cruise')
  Future<List<Cruise>> getTodos();

  @Query('SELECT * FROM Cruise WHERE idCrociera = :cf')
  Future<List<Cruise>> findCruiseById(int cf);

  @insert
  Future<void> insertCruise(Cruise item);

  @insert
  Future<void> insertCruises(List<Cruise> items);

  @update
  Future<void> updateCruises(List<Cruise> items);

  @Query(
      'UPDATE `Prenotazione` SET `idCrociera`= :idCrociera WHERE idCrociera= :id_crociera_old')
  Future<void> updatePrenotazione(int idCrociera, int id_crociera_old);

 
  @Query('INSERT INTO Cruise (idCrociera, dataInizio, dataFine, durataCrociera, temaCrociera, idNave, img, localita) VALUES (:idCrociera, :dataInizio, :dataFine, :durataCrociera, :temaCrociera, :idNave, :img, :localita)')
Future<void> insertCruiseReal(
  int idCrociera,
  String dataInizio,
  String dataFine,
  int durataCrociera,
  String temaCrociera,
  int idNave,
  String img,
  String localita,
);

  @delete
  Future<void> deletePrenotazione(Reserve items);

  @Query('DELETE FROM Cruise')
  Future<void> deleteAll();
}
