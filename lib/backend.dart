import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constants.dart';

class Backend extends StatelessWidget {
  const Backend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String Month = DateFormat.EEEE().format(DateTime.now());
    var Date = DateFormat.d().format(DateTime.now());
    var Year = DateFormat.y().format(DateTime.now());
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xFF2A87E9),
            Color(0xFF0773F0),
            Color(0xFF1D3CBD),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          bottom: PreferredSize(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Container(
                        height: 25,
                        width: 275,
                        child: Text(
                          "Weatherinhere!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 27, top: 3),
                    child: Text(
                      "$Month $Date, $Year",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ],
            ),
            preferredSize: Size.fromHeight(25),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Constantshere("API provider:", "openweather.com"),
                SizedBox(
                  height: 10,
                ),
                Constantshere("API key:", "345feaf0fec56bc72c6978738efa985a"),
                SizedBox(
                  height: 10,
                ),
                Constantshere(
                    "URL:", "api.openweathermap.org/data/2.5/weather"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 25,
                    ),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        width: 80,
                        height: 30,
                        child: Text(
                          "v.1.7.0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
