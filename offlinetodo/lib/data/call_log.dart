//@dart=2.9
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import 'package:offlinetodo/data/call_log.dart';
import 'package:offlinetodo/model/call_log.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';


class LogState extends ChangeNotifier {
  bool loading=false;
  //List<PhoneCallLog> phoneCallLog = [];

   Future<List<PhoneCallLog>> getCallLog() async {
     //<List<PhoneCallLog>>
    List<PhoneCallLog> phoneCallLog = [];
    if (Platform.isIOS) {
     return phoneCallLog;
     //return CallLog.get();
    }

    try {
  Iterable<CallLogEntry> entries = await CallLog.get();
      for (var item in entries) {
          phoneCallLog.add(PhoneCallLog(
            name: item.name,
            duration: "${item.duration.toString()} seconds",
            timeStamp: convertStampToDateTime(item.timestamp),
            callType: callType(item.callType),
            phoneNumber: item.number));
            CallLog.get();
      return phoneCallLog;}
    } catch (e) {
      print(e.toString());
      return [];
    }
    return phoneCallLog;
  }
  String convertStampToDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    var formattedDate = DateFormat.yMMMd().format(date);
    var timeFormat = new DateFormat('hh:mm:ss aa');

    return ('${timeFormat.format(date)}-$formattedDate');
  }
    String callType(CallType callType) {
    switch (callType) {
      case CallType.incoming:
        return "Incoming";
        break;

      case CallType.outgoing:
        return "OutGoing";
        break;

      case CallType.unknown:
        return "Unknown";
        break;

      case CallType.missed:
        return "Missed Call";
        break;

      case CallType.rejected:
        return "Rejected";
        break;

      case CallType.blocked:
        return "Blocked";
        break;

      case CallType.voiceMail:
        return "Voice mail";
        break;

      case CallType.answeredExternally:
        return "Answered Externally";
        break;

      default:
        return "Unknown";
        break;
    }
  }
}