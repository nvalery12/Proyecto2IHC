import 'package:proyectoihc2/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Basedatos{
  Database _db;

  Future initDB() async{
    _db = await openDatabase("task.db",
      version: 1,
      onCreate: (Database db, int version){
        db.execute("CREATE TABLE task (id INTEGER PRIMERY KEY, title TEXT NOT NULL, subtitle TEXT, finish INTEGER DEFAULT 0, time TEXT NOT NULL ");
      }
    );
    print("--- Base de datos inicializada ---");
  }

  insert(Reminder e){
    _db.insert("task", e.toMap());
    print("--- Elemento "+e.title+" agregado ---");
  }

  Future<List<Reminder>> getReminder() async{
    List<Map<String, dynamic>> results = await _db.query("task");
    print("--- Base de datos recuperada ---");
    return results.map((e) => Reminder.fromMap(e)).toList();
  }
}