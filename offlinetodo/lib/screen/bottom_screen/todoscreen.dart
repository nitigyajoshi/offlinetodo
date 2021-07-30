
 // @dart=2.9
 //// @dart=2.1
import 'package:intl/intl.dart';
//import 'package:offline_todo/Widgets/task_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:offlinetodo/widgets/task_tile.dart';
//import 'package:offline_todo/Widgets/todo_text.dart';
import 'package:offlinetodo/widgets/todo_text.dart';
import '../show_todo.dart';
import 'package:offlinetodo/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:offlinetodo/model/todo.dart';
import 'package:offlinetodo/data/todobrain.dart';

//import 'package:path/path.dart'as Path;

class TodoScreen extends StatefulWidget {
 // const TodoScreen({ Key? key }) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TODOBRAIN>(
      
      builder: (context, data, child){
return FutureBuilder<List<TODO>>(future: data.getAllTask()
,builder:
 (BuildContext context,AsyncSnapshot<List<TODO>> snapshot){
//snapshot.hasData snapshot.hasError||
if(snapshot.hasData){
  return DefaultTabController(length: 3, child: Scaffold(
appBar: AppBar(bottom: TabBar(tabs: [
Tab(
     icon: Icon(Icons.assignment),
                          text:'All',
),
Tab(
     icon: Icon(Icons.today),
                          text:'Today',
),
Tab(
     icon: Icon(Icons.calendar_today_sharp),
                          text:'Tommrrow',
),

]),),
body: TabBarView(children: [
renderTask(TaskDate.all),
renderTask(TaskDate.today),
renderTask(TaskDate.tomorrow),

]),floatingActionButton: FloatingActionButton(elevation:5,
child:Icon(Icons.add),onPressed: ()async{
await addTask(context);

}),
  ));
} else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('loading'),
              );


            }
            ////////////////////////////
return Center(child: Text('no data found'),);
});
        
    
  }
    );
          
          }

          
    Widget renderTask(TaskDate taskDate){
     // final _todoTask = Provider.of<TODOBRAIN>(context, listen: false);
     final _todoTask = Provider.of<TODOBRAIN>(context ,listen: false);
    List<TODO> todoList = _todoTask.getAllTaskFiltered(taskDate);
    if(todoList==null){
return Container(child: Text('no data added'),);
    }



return ListView.builder(itemCount: todoList.length,itemBuilder: (context,position){
return TaskTile(
   task: todoList[position].task,
            date: todoList[position].date,
onDelete: (){
showDialog<void>(context: context, builder: (BuildContext context){
return AlertDialog(
title: Text('Are you sure to delete ?'),
content: SingleChildScrollView(
child: ListBody(
children: [
Text('sure')
],),),actions: [TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();},     
                      ), TextButton(
                        child: Text('Yes'),
                        onPressed: () async {
                     
                          await _todoTask.deleteTODO(todoList[position].id);
                          Navigator.of(context).pop();  },
                      ),
                      

],
);


});

}, onUpdate: () async {
             await updateTask(context, todoList[position]);

            },


);


});


    }

//////////

 void addTask(BuildContext context) async {
    TODO _todo = TODO();
    final _todoTask = Provider.of<TODOBRAIN>(context, listen: false);

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    _todo.date = (formatter.format(now)).toString();
    String errorMsg = "";
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      TodoTextField(
                        hintValue: 'Task',
                        onChanged: (value) {
                          _todo.task = value;
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1995, 1, 1),
                              maxTime: DateTime(2050, 1, 1), onChanged: (date) {
                            DateFormat formatter = DateFormat('yyyy-MM-dd');
                            state(() {
                              _todo.date = (formatter.format(date)).toString();
                            });
                          }, onConfirm: (date) {
                            DateFormat formatter = DateFormat('yyyy-MM-dd');

                            state(() {
                              _todo.date = (formatter.format(date)).toString();
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              border:
                                  Border.all(width: 0.8, color: Colors.black38),
                            ),
                            child: Text(
                              _todo.date,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom == 0
                            ? 10
                            : 300,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_todo.task != null) {
                            if (_todo.task.length > 0) {
                              _todoTask.addTODO(_todo);
                              Navigator.pop(context);
                            } else {
                              state(() {
                                errorMsg = 'Empty'; });}  } else { state(() {   errorMsg = 'empty'; });  }},
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              border: Border.all(
                                  width: 0.8, color: Colors.black38)),
                          child: Text(
                            'save',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(child: Text(errorMsg)),
                    ],
                  ),
                ),
              );
            },
          );
        });
 }
///////////////////
 void updateTask(BuildContext context, TODO todo) async {
    TODO _todo = TODO();
    _todo.id = todo.id;
    _todo.task = todo.task;
    _todo.date = todo.date;
 final _todoTask = Provider.of<TODOBRAIN>(context, listen: false);
    String errorMsg = "";
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode()); },
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      TodoTextField(
                        hintValue: _todo.task,
                        onChanged: (value) {
                          _todo.task = value;}, ),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1995, 1, 1),
                              maxTime: DateTime(2050, 1, 1), onChanged: (date) {
                            DateFormat formatter = DateFormat('yyyy-MM-dd');
                            state(() {
                              _todo.date = (formatter.format(date)).toString();
                            });
                          }, onConfirm: (date) {
                            DateFormat formatter = DateFormat('yyyy-MM-dd');

                            state(() {
                              _todo.date = (formatter.format(date)).toString();
                            });
                          },
                              currentTime: DateTime.parse(_todo.date),
                              locale: LocaleType.en);
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              border:
                                  Border.all(width: 0.8, color: Colors.black38),
                            ),
                            child: Text(
                              _todo.date,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom == 0
                            ? 10
                            : 300,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_todo.task != null) {
                            if (_todo.task.length > 0) {
                              _todoTask.editTodo(_todo);
                              Navigator.pop(context);
                            } else {
                              state(() {
                                errorMsg =' Empty';
                              });
                            }
                          } else {
                            state(() {
                              errorMsg = 'Empty';
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              border: Border.all(
                                  width: 0.8, color: Colors.black38)),
                          child: Text(
                          '  Update',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(child: Text(errorMsg)),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }




}

// class TodoScreen extends StatefulWidget {
  
  
 
// //  const TodoScreen({ Key? key }) : super(key: key);

//   @override
//   _TodoScreenState createState() => _TodoScreenState();
// }

// class _TodoScreenState extends State<TodoScreen> {


//    DateTime ?selectedDate ;

//   bool check=false;
// var text;
// bool visibility=true;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
    
//       IconButton(onPressed: (){
//       setState(() {
//         check=true;
//         visibility=false;
//       });
    
//       }, 
      
    
      
//       icon: Icon(Icons.add_task)),
//       Visibility(visible: visibility,child: ShowTodo()
//       ),





//           Visibility(
//             visible: check,
//             child: Container(child: ListView(
//           children: [
//           TextField(
            
//           decoration: InputDecoration(
//         fillColor: Colors.white,
//           hintText:"enter task ?" ,
          
          
//           ),onChanged: (value){
// text=value;
//           },
//           ),
          
        
//          // ignore: deprecated_member_use


//       SizedBox(height: 20,),
//       ///////////////////////////////////////////
//       ///
//       selectedDate!=null?   Text(
//         "${selectedDate}"
//         .split(' ')[0],
//         style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
//       ):Text('😬opps date not selected!!! '),


//       //     Text(
//       //   "${selectedDate}"
//       //   .split(' ')[0],
//       //   style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
//       // ),
//       SizedBox(
//         height: 20.0,
        
//       ),
//       // ignore: deprecated_member_use



//       RaisedButton(
//         onPressed: (){
//     showDatePicker(context: context, initialDate: DateTime.now(), 
    
//     firstDate: DateTime(2021), lastDate: DateTime(2030),
//     ).then((date){
//     setState(() {
//       selectedDate=date;
//     });
    
//     });
//           }
//           // Refer step 3
//         ,
        
        
//         child: Text(
//           'Select date 📅',
//           style:
//               TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         color: Colors.greenAccent,
//       ),


//       ElevatedButton(onPressed: (){
//     setState(() {
      
    
//       check=false;
//       visibility=true;
//     });
//       }, child: Text('Save',style: TextStyle(fontSize: 15),))
        
//           ],
          
          
          
//            shrinkWrap: true,
//             ),
              
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// //}