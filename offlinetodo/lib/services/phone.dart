//@dart=2.9
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';
//import 'call_log.dart';
//import 'log.dart';


class MyApp extends StatefulWidget {
  //MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
List<Contact>contact=[];
  List<Contact>filter=[];
  TextEditingController controller=TextEditingController();
  @override
  void initState() { 
    getAllContact();
    controller.addListener(() {
      filterContact();
    });
    super.initState();
    
  }
  getAllContact()async{
    bool getPermission = false;
     final PermissionStatus permissionStatus = await _getPermission();


      if(permissionStatus == PermissionStatus.granted){
List<Contact> _contacts = (
   
  await ContactsService.getContacts()).toList();
setState(() {
  contact=_contacts;
});}else{
   return showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text('Permissions error'),
                    content: Text('Please enable contacts access '
                        'permission in system settings'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ));
        }
     // },
      //child: Container(child: Text('See Contacts')),
   // );
//}
  }
  filterContact(){
List<Contact>_contact=[];
_contact.addAll(contact);
if(controller.text.isNotEmpty){

_contact.retainWhere((contact){
  String search=controller.text.toLowerCase();
  String conname=contact.displayName.toLowerCase();
  return conname.contains(search);
});
setState(() {
  filter=_contact;
});


  }}
////////////////D:\flutter\.pub-cache\hosted\pub.dartlang.org\contacts_service-0.6.1\lib\contacts_service.dart
 
  
  



  @override
  Widget build(BuildContext context) {

    bool issearching=controller.text.isNotEmpty;
    return MaterialApp(
      home: Scaffold(//appBar: AppBar(title: Text('Contact'),),
        body: Column(children: [
        //ElevatedButton(onPressed: (){
          
         //   new Call();
    //                Navigator.push(context,
    //  MaterialPageRoute(builder: (context) => Call()),
    // );
          

       // }, child: Icon(Icons.navigate_next)
       // )
//Log();
//return ChangeNotifierProvider<LogState>(create:(context) =>LogState(),
 //child: Log()
  

 //Log(),

//  await Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => Log()),
//   );
         
          Container(
child: TextField(
controller:controller ,
decoration: InputDecoration(
labelText:'search',
border: new OutlineInputBorder(
borderSide: new BorderSide(
  color: Theme.of(context).primaryColor
)
),
prefixIcon: Icon(Icons.search,
color: Theme.of(context).primaryColor,)
),
),
          ),


  
  
Expanded(
  child:   
  contact!=null?ListView.builder(shrinkWrap:true,
  itemCount:issearching==true?filter.length:contact.length
  ,itemBuilder: ( context,index){
  
      
  
     Contact contact1=issearching==true?filter[index]:contact[index];
  



  return ListTile(
  
  title: Text(contact1.displayName),
  
  subtitle:contact1.phones.length>0? Text(contact1.phones.elementAt(0).value):Text('finding more'),
  
  leading: (contact1.avatar!=null&&contact1.avatar.length>0)?CircleAvatar
  (backgroundImage:MemoryImage(contact1.avatar) ):CircleAvatar(
  
      child: Text(contact1.initials()),
  
  ),
  trailing:IconButton(onPressed: ()async{
    var con=9800;
  await launch("tel:${contact1.phones.elementAt(0).value}");

  }, icon: Icon(Icons.call),)
  );
  
  
  
  
  
  }):Text('loading'),
)
,

        ],),
      ),
    );
  } 
   Future<bool> _askPermissions() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
          print(permissionStatus);
      return permissionStatus[Permission.contacts] 
      ??
       PermissionStatus.values;
      
    } else {
      return permission;
    }
  }
}












