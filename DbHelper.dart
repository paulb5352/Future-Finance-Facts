import 'package:cash_flow/helpers/DbBase.dart';
import 'package:sqflite/sqflite.dart' as sql;


class DBHelper extends DbBase {

  static Future<void> insert(String table, Map<String, Object> data) async {
    
    try{
      final db = await DbBase.database();
      db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } catch (error){
      throw Exception('Could not insert into : ' + table + ' : ' + error.toString());
    }
  }

  static Future<void> update(String table, int id, Map<String, Object> data) async {

    try{
      final db = await DbBase.database();
      db.update(table,
      data,
      where: 'id = ?', whereArgs: [id],
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } catch (error) {
      throw Exception ('could not update table ' + table + ' : ' + error.toString());
    }
  }

  static  Future<int> delete(String table, int id) async {

    try{
      final db = await DbBase.database();
      return await db.delete(table, where: 'id = ?', whereArgs: [id]);
    } catch (error){
      throw Exception('could not delete from table ' + table + ' : ' + error.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    try{
      final db = await DbBase.database();
      return db.query(table); // list of maps
    } catch (error){
      throw Exception('could not retrieve data from ' + table + ' : ' + error.toString());
    }
  }
}


