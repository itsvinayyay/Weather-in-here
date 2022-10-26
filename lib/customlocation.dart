import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class customLocation extends StatefulWidget {
  const customLocation({Key? key}) : super(key: key);

  @override
  State<customLocation> createState() => _customLocationState();
}

class _customLocationState extends State<customLocation> {
  String Month = DateFormat.EEEE().format(DateTime.now());
  var Date = DateFormat.d().format(DateTime.now());
  var Year = DateFormat.y().format(DateTime.now());
  late String cityname;
  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.only(bottom: 8, left: 25),
                    child: Text("$Month $Date, $Year"),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ],
            ),
            preferredSize: Size.fromHeight(25),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 60,
                    width: 320,
                    child: TextField(
                      enableSuggestions: true,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        icon: Icon(
                          FontAwesomeIcons.city,
                          color: Colors.white,
                        ),
                        hintText: "Enter your City Name...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        cityname = value;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                height: 60,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF1D3CBD),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, cityname);
                  },
                  child: Text(
                    "Search 🔍",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
