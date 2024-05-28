import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao.dart';
import 'model.dart';

part 'database.g.dart';
 // the generated code will be there
@Database(version: 1, entities: [Reserve, Cruise])
abstract class AppDatabase extends FloorDatabase {
  PrenotazioneDao get prenotazioneDao;
}


