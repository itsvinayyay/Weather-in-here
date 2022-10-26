import 'package:flutter/material.dart';
import 'package:weatherinhere/geolocation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homescreen.dart';

class Loading_Screen extends StatefulWidget {
  const Loading_Screen({Key? key}) : super(key: key);

  @override
  State<Loading_Screen> createState() => _Loading_ScreenState();
}

class _Loading_ScreenState extends State<Loading_Screen> {
  @override
  void initState() {
    super.initState();
    Geolocation();
  }

  void Geolocation() async {
    var gotdata = await Weatherinfo().gettingdata();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(gotdata);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeInOut(
          color: Colors.blue,
          size: 100,
        ),
      ),
    );
  }
}
