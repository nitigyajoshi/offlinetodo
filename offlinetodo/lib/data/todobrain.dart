///import 'model/todo.dart';
 // 
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
//import 'package:TODO_OFFLINE/model/todo.dart';
import 'package:offlinetodo/model/todo.dart';
import 'database.dart';

enum TaskDate { all, today, tomorrow }
class TODOBRAIN extends ChangeNotifier {

  List<TODO> _todos = [];
Future<List<TODO>>getTODOS()  async  {
    return _todos;
  }
  // TODO getTODO(int position){
  //   return _todos[position];
  // }

  void addTODO(TODO newTODO)async{
    if(newTODO!=null){
await DB.insert(newTODO);
await getAllTask();
    }
   // _todos.add(newTODO);
    //notifyListeners();
  }



  void editTodo( TODO editTODO)async{
    await DB.update(editTODO);
    notifyListeners();
  }
Future<List<TODO>>getAllTask()async{
_todos=await DB.query();
notifyListeners();
return _todos;
}


   deleteTODO (int position)async{
await DB.delete(position);
   
    notifyListeners();

  }

 List<TODO>getAllTaskFiltered(TaskDate taskDate){
   
List<TODO>_todos1=[];
List<TODO>_filteredTodo=[];
if(_todos.isNotEmpty){
_todos1=_todos;
DateTime now=DateTime.now();
 DateFormat formatter = DateFormat('yyyy-MM-dd');
for(int i=0;i<_todos1.length;i++){
if(taskDate==TaskDate.all){
_filteredTodo.add(_todos1[i]);
}else if(taskDate==TaskDate.today){
    var todayDate = formatter.format(now);
          String todayDateString = todayDate.toString().trim();
          if (_todos[i].date.trim() == todayDateString) {
            _filteredTodo.add(_todos[i]);
          }
}else if(taskDate==TaskDate.tomorrow){
var tommrrow=now.add(Duration(days: 1));
var tommorrowdate=formatter.format(tommrrow);
String tommrrowstring=tommorrowdate.toString().trim();
if(_todos1[i].date.trim()==tommrrowstring){
_filteredTodo.add(_todos1[i]);
}
}
}
return _filteredTodo;
}
return _filteredTodo;
 }





}