import 'package:flutter/material.dart';
import 'package:world_timer_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setUpWorldTime() async{
    WorldTime w=WorldTime(location: 'Kolkata',flag: 'india.png',url: 'Asia/Kolkata');
    await w.getTime();

    Navigator.pushReplacementNamed(context,'/home',arguments: {
      'location':w.location,
      'flag':w.flag,
      'time':w.time,
      'isDaytime':w.isDaytime,
    });
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 50.0,
        ),
      )
    );
  }
}
