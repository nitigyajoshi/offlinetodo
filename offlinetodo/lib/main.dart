 // @dart=2.9
import 'package:flutter/material.dart';
//import 'database.dart';
//import 'package:TODO_OFFLINE/screen/home.dart';
//import 'database.dart';
import 'data/database.dart';
import 'screen/home.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
 // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Home()
    );
  }
}