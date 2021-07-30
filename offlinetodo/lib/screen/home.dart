// @dart=2.9
import 'package:flutter/material.dart';
import 'package:offlinetodo/data/contact_task.dart';
import 'package:offlinetodo/data/todobrain.dart';
import 'package:offlinetodo/screen/bottom_screen/contact_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import 'package:offlinetodo/model/call_log.dart';
import 'package:offlinetodo/data/call_log.dart';
import 'package:offlinetodo/screen/bottom_screen/call_log_screen.dart';
import 'package:offlinetodo/services/phone.dart';
//import 'package:offlinetodo/services/service_contact.dart';
//import 'bottom_screen/todoscreen.dart';
//import 'bottom_screen.dart/todoscreen.dart';
import 'package:offlinetodo/screen/bottom_screen/todoscreen.dart';
class Home extends StatefulWidget {
 // const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
int _currentPage = 0;
 GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),),
body: renderscreen(),
//renderscreen()    ,

drawer: MyDrawer(),
// bottomNavigationBar: BottomNavigationBar(items: 
// [
bottomNavigationBar:BottomNavigationBar(
    key: globalKey,
  items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "assignment",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: "Contact",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label:" Call",
          ),
        ],
currentIndex: _currentPage,
selectedItemColor: Colors.blue[800],

onTap: (position){
setState(() {
   _currentPage = position;
});
},

)



  
// ]


//),


    );
  }


  Widget renderscreen(){
switch (_currentPage) {
  case 0:
    return ChangeNotifierProvider<TODOBRAIN>(
          create: (context) => TODOBRAIN(),
          child: TodoScreen(),
        ); 
    break;
  case 1:
   return  Scaffold(body:MyApp() ,);
    break;
  case 2:return ChangeNotifierProvider<LogState>(
   create: (BuildContext context)=>LogState(),
    child: Log(),
    // create: (BuildContext context)=>LogState(),child: Log(),
      
  );
    break;
default:return Text('data');

}


  }




 // Future<Widget> call()async{
 // return Container(
//child: await Contact_service(),
 // );
}
//}
//idea
//https://github.com/Tokol/ulimited_demo/blob/master/lib/data/todo_task.dart
//https://github.com/Tokol/flutter_todo_offline/blob/master/lib/database/database.dart
