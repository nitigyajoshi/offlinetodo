
//@dart=2.9

 import 'package:offlinetodo/model/todo.dart';
import 'todobrain.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
//import 'package:unlimted_demo/model/todo.dart';

class DB {
  static Database _db;

  static int get _version => 1;

  static final String TABLE_NAME = "TODOS";

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'task';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    db.execute("CREATE TABLE '$TABLE_NAME' ("
        "id INTEGER PRIMARY KEY,"
        "taskName TEXT,"
        "date TEXT"
        ")");
  }

  static Future<int> insert(TODO todo) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id FROM $TABLE_NAME");
    int id = table.first["id"];

    var raw = await _db.rawInsert(
        "INSERT Into $TABLE_NAME (id,taskName,date)"
        " VALUES (?,?,?)",
        [id, todo.task, todo.date]);
    return raw;
  }

  static Future<List<TODO>> query() async {
    var res = await _db.query("$TABLE_NAME");
    List<TODO> _todoList = [];
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _todoList.add(
            TODO(id: res[i]["id"], task: res[i]["taskName"], date: res[i]["date"]));
      }
    }

    return _todoList;
  }

  static Future<int> update(TODO todo) async {

    await _db.update('$TABLE_NAME', todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  static Future<int> delete(int id) async {
    await _db.delete('$TABLE_NAME', where: 'id = ?', whereArgs: [id]);
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// import 'package:sqflite/sqflite.dart';
// import 'package:offline_todo/model/todo.dart';
// import 'dart:async';

// class DB{
//  static Database db; 
//  static int get _version => 9;
//  static final String TABLE_NAME = "TODOS";
//  //static final String TABLE_ROW_ID = "id";
//  static final String date="44";
//  static final String Taskname="taskName";

//  static Future<void>init()async{
// if (db!=null){
// return ;
// }

// try{
// String _path=await getDatabasesPath()+ 'task';
// print(_path);
// db=await openDatabase(_path,version:_version,onCreate:oncreate);
// print('data successfully added');
// }
// catch(e){
// print('something went wrong');
// print(e);

// }



// }

//  static void oncreate(Database db,int version)async{

// db.execute(
// "CREATE TABLE TODOS ("
// "id INTEGER PRIMARY KEY,"
// "taskName TEXT,"
// "date TEXT"


// ")"
// );
// }


// static Future<int>insert(TODO todo)async{
// var table=await db.rawQuery(
// "SELECT MAX(id)+1 as id FROM $TABLE_NAME"
// );
// int id=table.first["id"];
// print(id);
// var raw=await db.rawInsert(
// "INSERT INTO $TABLE_NAME(id,$Taskname,$date)"
// "VALUES (?,?,?)",
// ["id,todo.task,todo.date"]

// );
// return raw;

// }

//  static Future<List<TODO>>getTodo()async{
//   if (db==null){
//    await DB.init();
//   }
// var res=await db.query("$TABLE_NAME");
// List<TODO>todos=[];

// if (res.isNotEmpty) {
  
//   for(int i=0;i<=res.length;i++){
// todos.add(TODO(id: res[i]["id"],
// task: res[i]["$Taskname"],
// date: res[i]["date"],
// ));


//   }
//   return todos;
// } else {
//    print("no data");
//    throw ("no data");
//   //return todos;
 
// }


// }
// static Future<int>update(TODO task)async{

//   var result=db.update('$TABLE_NAME',task.toMap(),where:'id=?',
//   whereArgs:(task.id));




// return result;
// }

// static Future<int>delete(int id)async{
// var result=await db.delete(TABLE_NAME,where:'TABLE_ROW_ID=?',
// whereArgs:[id]);
// return result;
// }

// }



 

