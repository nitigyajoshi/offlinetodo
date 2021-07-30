 
 // @dart=2.9
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final  String task;
  final String date;
  final Function onUpdate;
  final Function onDelete;
 TaskTile({this.task, this.date,this.onDelete,this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.all(15.0),
            child: Card(

              child: Column(
children: [
Text(date, style: TextStyle(color: Colors.red, fontSize: 22.0, fontWeight: FontWeight.bold)),
SizedBox(height: 10,),
Text(task, style: TextStyle(color: Colors.green, fontSize: 22.0, fontWeight: FontWeight.bold)),
SizedBox(height: 10,),
Row(children: [
IconButton(onPressed: (){
onUpdate();
}, icon: Icon(Icons.edit))
,IconButton(onPressed: (){
onDelete();
}, icon: Icon(Icons.delete))


],)

],


              ),
            ),
    );
  }
}