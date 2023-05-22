import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class CityRepository {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE cities(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        latitude REAL,
        longitude REAL
      )
      """);
  }
  
  static Future<sql.Database> db() async {
    Database db = await sql.openDatabase(
      'mycities.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
    print('Banco:  ${db.isOpen.toString()}');
    return db;
  }

  // Cria uma nova cidade
  static Future<int> createCity(String name, Double? latitude, Double? longitude) async {
    final db = await CityRepository.db();

    final data = {'name': name, 'latitude': latitude, 'longitude': longitude};
    final id = await db.insert('cities', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
        db.close();
    return id;
  }

  // Lê todas as cidades
  static Future<List<Map<String, dynamic>>> getCities() async {
    final db = await CityRepository.db();
    return db.query('cities', orderBy: "id");
  }

  // Lê uma única cidade por id
  // Não foi utilizado esse método neste aplicativo, mas deixei aqui para uso posterior
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await CityRepository.db();
    return db.query('cities', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Atualiza uma cidade por id
  static Future<int> updateCity(
      int id, String name, Double? latitude, Double? longitude) async {
    final db = await CityRepository.db();

    final data = {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('cities', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete uma cidade
  static Future<void> deleteCity(int id) async {
    final db = await CityRepository.db();
    try {
      await db.delete("cities", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}