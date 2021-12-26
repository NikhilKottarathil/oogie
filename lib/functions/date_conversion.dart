import 'dart:math';

import 'package:intl/intl.dart';

String getDateString(String string) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
  final f = new DateFormat('dd-MM-yyyy');
  String startingdate = f.format(dateTime);

  return startingdate;
}

String getTimeString(String string) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
  final f = new DateFormat('hh:mm a');
  String time = f.format(dateTime);

  return time;
}

String getDateAndTimeString(String string) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
  String time = f.format(dateTime);

  return time;
}

String getDayMonthString(String string) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
  final f = new DateFormat('dd-MM');
  String time = f.format(dateTime);

  return time;
}

String getDurationTime(String string) {
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(int.parse(string) - 19800000);

  final full = new DateFormat('hh-mm');
  final hour = new DateFormat('hh');
  final min = new DateFormat('mm');
  final sec = new DateFormat('s');
  final ampm = new DateFormat('a');
  String f = full.format(dateTime);
  String h = hour.format(dateTime);
  String m = min.format(dateTime);
  String s = sec.format(dateTime);
  String a = ampm.format(dateTime);

  String time = '';
  if (int.parse(string) < 60000) {
    time = s + " s";
  } else if (f == '12-30') {
    time = '30 m';
  } else if (f == '01-00') {
    time = '1 h';
  } else if (f == '01-30') {
    time = '1 h 30 m';
  } else if (f == '02-00') {
    time = '2 h';
  } else if (f == '02-30') {
    time = '2 h 30 m';
  } else if (f == '03-00') {
    time = '3 h';
  } else {
    if (h == '12') {
      if (a == 'AM') {
        time = m + " m";
      } else {
        time = h + " h " + m + " m";
      }
    } else {
      time = h + " h " + m + " m";
    }
  }

  return time;
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

String getTimeDifferenceFromNow(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);
  if (difference.inSeconds < 5) {
    return "Just now";
  } else if (difference.inMinutes < 1) {
    return "${difference.inSeconds}s ago";
  } else if (difference.inHours < 1) {
    return "${difference.inMinutes}m ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h ago";
  } else {
    return "${difference.inDays}d ago";
  }
}

String getTimeDifferenceFromNowString(String date) {
  // Dat  dateTime = DateFormat.w.format(DateTime.now());
  DateTime dateTime = DateFormat('EEE, dd MMM yyyy hh:mm:ss')
      .parse(date.substring(0, date.length - 3));

  print(dateTime);
  Duration difference = DateTime.now().difference(dateTime);
  if (difference.inSeconds < 5) {
    return "Just now";
  } else if (difference.inMinutes < 1) {
    return "${difference.inSeconds}s ago";
  } else if (difference.inHours < 1) {
    return "${difference.inMinutes}m ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h ago";
  } else {
    return "${difference.inDays}d ago";
  }
}

getDateTimeFromStringFormat(String date){
  DateTime dateTime = DateFormat('EEE, dd MMM yyyy hh:mm:ss')
      .parse(date.substring(0, date.length - 3));
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
  String time = f.format(dateTime);

  return time;
}getDateFromStringFormat(String date){
  DateTime dateTime = DateFormat('EEE, dd MMM yyyy hh:mm:ss')
      .parse(date.substring(0, date.length - 3));
  final f = new DateFormat('dd-MM-yyyy');
  String time = f.format(dateTime);

  return time;
}