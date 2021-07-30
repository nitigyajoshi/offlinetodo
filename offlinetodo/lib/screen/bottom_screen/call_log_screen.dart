import 'package:flutter/material.dart';
import 'package:offlinetodo/model/call_log.dart';
import 'call_log_screen.dart';
import 'package:provider/provider.dart';
import 'package:offlinetodo/data/call_log.dart';
import 'dart:io' show Platform;
class Log extends StatefulWidget {
  const Log({ Key? key }) : super(key: key);

  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  Widget build(BuildContext context) {
      if (Platform.isIOS) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'iosCallLog',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
      );
    }
   return Consumer<LogState>(builder: (context, data, child){
return FutureBuilder
 <List<PhoneCallLog>>
 (
         future: data.getCallLog(),
         builder:
          (BuildContext context ,
         
         AsyncSnapshot<List<PhoneCallLog>>
          snapshot){
        
           if(snapshot.hasData){
           return ListView.builder(
           //  scrollDirection: Axis.vertical,
             itemCount: 
             snapshot.data!.length,
             //+(isEmpty? 1 : 0),
             //snapshot.data!.length,
             itemBuilder: (context,position){
              // position++;
             return SizedBox(
  
  child:   Card(
  
    child:   Expanded(
  
      child: Column(
  
        children: [ 
          //Text('...${phoneCallLog[1].phoneNumber}'),
          snapshot.data![position].name!=null?Text(snapshot.data![position].phoneNumber):Text('Unknown number'),
  
  //         phoneCallLog.length>0?Text('phone: ${phoneCallLog[position].phoneNumber}'):Text('loading'),
  
   snapshot.data![position].duration!=null?Text(snapshot.data![position].duration):Text('loading'),
  
 snapshot.data![position].callType!=null?Text(snapshot.data![position].callType):Text('loading'),
  

        ],
  
      ),
  
    ),
  
  ),
  
);

           });
         }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        return Text('no call log');
     

       });
   });
  }
}