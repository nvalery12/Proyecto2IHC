import 'package:proyectoihc2/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class Basedatos{
  Database _db;

  Future initDB() async{
    _db = await openDatabase(join(await getDatabasesPath(), 'tasks.db'),
      version: 1,
      onCreate: (db, version){
        db.execute("CREATE TABLE task(id INTEGER PRIMERY KEY, title TEXT NOT NULL, subtitle TEXT, finish INTEGER DEFAULT 0, time TEXT NOT NULL)");
      }
    );
    print("--- Base de datos inicializada ---");
    getReminders();
  }

  insert(Reminder e){
    _db.insert("task", e.toMap());
    print("--- Elemento "+e.title+" agregado ---");
  }

  Future<List<Reminder>> getReminders() async{
    /*List<Map<String, dynamic>> results = await _db.query("task");
    print("--- Base de datos recuperada ---");
    return results.map((e) => Reminder.fromMap(e)).toList();*/

    List<Reminder> lista= [];
    var resultado= await _db.query("task");
    resultado.forEach((element) {
      var objeto= Reminder.fromMap(element);
      print("Imprimiendo: "+objeto.id.toString());
      lista.add(objeto);
    });
    return lista;
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