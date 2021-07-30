//import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
children: [
DrawerHeader(child: Text('TodoApp',style: TextStyle(fontSize: 14,color: Colors.amberAccent),))
,
ListTile(
              leading: Icon(Icons.assignment),
              title: Text('assignment'),
              onTap: () {
                Navigator.pop(context);
               
              },
            ),

ListTile(
              leading: Icon(Icons.phone),
              title: Text('phone'),
              onTap: () {
                Navigator.pop(context);
               
              },
            ),






],






      )


    );
  }
}