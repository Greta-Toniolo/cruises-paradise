// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PrenotazioneDao? _prenotazioneDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Reserve` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `cfCliente` TEXT NOT NULL, `idCrociera` TEXT NOT NULL, `dataPrenotazione` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cruise` (`idCrociera` INTEGER NOT NULL, `dataInizio` TEXT NOT NULL, `dataFine` TEXT NOT NULL, `durataCrociera` INTEGER NOT NULL, `temaCrociera` TEXT NOT NULL, `idNave` INTEGER NOT NULL, `img` TEXT NOT NULL, `localita` TEXT NOT NULL, PRIMARY KEY (`idCrociera`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PrenotazioneDao get prenotazioneDao {
    return _prenotazioneDaoInstance ??=
        _$PrenotazioneDao(database, changeListener);
  }
}

class _$PrenotazioneDao extends PrenotazioneDao {
  _$PrenotazioneDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _reserveInsertionAdapter = InsertionAdapter(
            database,
            'Reserve',
            (Reserve item) => <String, Object?>{
                  'id': item.id,
                  'cfCliente': item.cfCliente,
                  'idCrociera': item.idCrociera,
                  'dataPrenotazione': item.dataPrenotazione
                }),
        _reserveUpdateAdapter = UpdateAdapter(
            database,
            'Reserve',
            ['id'],
            (Reserve item) => <String, Object?>{
                  'id': item.id,
                  'cfCliente': item.cfCliente,
                  'idCrociera': item.idCrociera,
                  'dataPrenotazione': item.dataPrenotazione
                }),
        _reserveDeletionAdapter = DeletionAdapter(
            database,
            'Reserve',
            ['id'],
            (Reserve item) => <String, Object?>{
                  'id': item.id,
                  'cfCliente': item.cfCliente,
                  'idCrociera': item.idCrociera,
                  'dataPrenotazione': item.dataPrenotazione
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Reserve> _reserveInsertionAdapter;

  final UpdateAdapter<Reserve> _reserveUpdateAdapter;

  final DeletionAdapter<Reserve> _reserveDeletionAdapter;

  @override
  Future<List<Reserve>> getTodos() async {
    return _queryAdapter.queryList('SELECT * FROM Reserve',
        mapper: (Map<String, Object?> row) => Reserve(
            row['id'] as int?,
            row['cfCliente'] as String,
            row['idCrociera'] as String,
            row['dataPrenotazione'] as String));
  }

  @override
  Future<List<Reserve>> findPrenotazioneByCf(String cf) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Prenotazione WHERE cf_cliente = ?1',
        mapper: (Map<String, Object?> row) => Reserve(
            row['id'] as int?,
            row['cfCliente'] as String,
            row['idCrociera'] as String,
            row['dataPrenotazione'] as String),
        arguments: [cf]);
  }

  @override
  Future<void> updatePrenotazione(
    int idCrociera,
    int id_crociera_old,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE `Prenotazione` SET `idCrociera`= ?1 WHERE idCrociera= ?2',
        arguments: [idCrociera, id_crociera_old]);
  }

  @override
  Future<void> insertReserve(
    String cfCliente,
    int idCrociera,
    String dataPrenotazione,
  ) async {
    await _queryAdapter.queryNoReturn(
        'INSERT INTO Reserve (cfCliente, idCrociera, dataPrenotazione) VALUES (?1, ?2, ?3)',
        arguments: [cfCliente, idCrociera, dataPrenotazione]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Reserve');
  }

  @override
  Future<void> insertPrenotazione(Reserve item) async {
    await _reserveInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertPrenotazioni(List<Reserve> items) async {
    await _reserveInsertionAdapter.insertList(items, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePrenotazioni(List<Reserve> items) async {
    await _reserveUpdateAdapter.updateList(items, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePrenotazione(Reserve items) async {
    await _reserveDeletionAdapter.delete(items);
  }
}
