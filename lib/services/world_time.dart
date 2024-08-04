import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class WorldTime{
  String location='';
  String time='';
  String flag='';
  String url='';
  bool isDaytime=false;

  WorldTime({required this.location,required this.flag,required this.url});

  Future<void> getTime() async {
    try {
      //get request response
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      print(data);

      //get properties from data
      String datetime = data['datetime'];
      tzdata.initializeTimeZones();

      // Parse the input datetime string
      String datetimeStr = datetime;
      DateTime parsedDatetime = DateTime.parse(datetimeStr);

      // Get the local timezone
      tz.Location localTz = tz.getLocation(url); // Replace with the desired timezone

      // Convert the parsed datetime to the local timezone
      tz.TZDateTime localDatetime = tz.TZDateTime.from(parsedDatetime, localTz);

      // Format the local datetime
      String formattedDatetime =
      DateFormat('HH:mm:ss').format(localDatetime);

      // Print the local datetime
      print(formattedDatetime);

      DateTime parsedTime = DateFormat('HH:mm:ss').parse(formattedDatetime);

      isDaytime = parsedTime.hour > 6 && parsedTime.hour < 20 ? true : false;
      time = formattedDatetime;
    }
    catch(e){
      print('caught error : $e');
      time = 'Could not get the time data currently.\nPlease Try later';
    }
  }
}
