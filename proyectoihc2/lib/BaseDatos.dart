import 'package:proyectoihc2/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Basedatos{
  Database _db;

  Future initDB() async{
    var dir = await getDatabasesPath();
    var path = dir + "task.db";
    _db = await openDatabase(path,
      version: 1,
      onCreate: (Database db, int version){
        db.execute("CREATE TABLE task (id INTEGER PRIMERY KEY, title TEXT NOT NULL, subtitle TEXT, finish INTEGER DEFAULT 0, time TEXT NOT NULL");
      }
    );
    print("--- Base de datos inicializada ---");
  }

  insert(Reminder e){
    _db.insert("task", e.toMap());
    print("--- Elemento "+e.title+" agregado ---");
  }

  Future<List<Reminder>> getReminders() async{
    List<Map<String, dynamic>> results = await _db.query("task");
    print("--- Base de datos recuperada ---");
    return results.map((e) => Reminder.fromMap(e)).toList();
  }

  delete(int id) async {
    _db.delete("task", where: 'id = ?', whereArgs: [id]);
    print("--- Elemento de id "+id.toString()+" fue eliminado de la base de datos ---");
  }

  update(Reminder e) async {
    _db.update("task",e.toMap(), where: 'id = ?', whereArgs: [e.id]);
    print("--- Elemento de id "+e.id.toString()+" fue actualizado en la base de datos ---");
  }
}