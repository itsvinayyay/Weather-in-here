import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weatherinhere/geolocation.dart';
import 'customlocation.dart';
import 'about_page.dart';
import 'backend.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.jsondecoder);
  late var jsondecoder;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final globalkey = GlobalKey<ScaffoldState>();
  bool showmenu = false;
  late int inttemp;
  late int windspeed;
  late String cityname;
  late int humidity;
  late int pressure;
  late String message;
  late int id;
  late int maxtemp;
  late int mintemp;
  late String sunrise;
  late String sunset;
  late int sealvl;
  late int grdlvl;

  @override
  void initState() {
    super.initState();
    Updates(widget.jsondecoder);
  }

  String getClockInUtcPlus3Hours(int time) {
    final newtime =
        DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: true)
            .add(const Duration(hours: 3));
    return '${newtime.hour}:${newtime.minute}';
  }

  void Updates(dynamic decoded) {
    setState(
      () {
        var temp = decoded['main']['temp'];
        inttemp = temp.toInt();
        var doubwindspeed = decoded['wind']['speed'];
        windspeed = doubwindspeed.toInt();
        var doubpressure = decoded['main']['pressure'];
        pressure = doubpressure.toInt();
        cityname = decoded['name'];
        humidity = decoded['main']['humidity'];
        message = decoded['weather'][0]['main'];
        id = decoded['weather'][0]['id'];
        double doubmax = decoded['main']['temp_max'];
        maxtemp = doubmax.toInt();
        double doubmin = decoded['main']['temp_min'];
        mintemp = doubmin.toInt();
        int doubsunrise = decoded['sys']['sunrise'];
        sunrise = getClockInUtcPlus3Hours(doubsunrise as int);
        int doubsunset = decoded['sys']['sunset'];
        sunset = getClockInUtcPlus3Hours(doubsunset as int);
        var doubsealvl = decoded["main"]["sea_level"];
        sealvl = doubsealvl.toInt();
        var doubgrdlvl = decoded["main"]["grnd_level"];
        grdlvl = doubgrdlvl.toInt();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime Now = DateTime.now();
    String Month = DateFormat.EEEE().format(Now);
    var Date = DateFormat.d().format(Now);
    var Year = DateFormat.y().format(Now);

    var threshold = 50;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A87E9),
            Color(0xFF0773F0),
            Color(0xFF1D3CBD),
          ],
        ),
      ),
      child: Scaffold(
        key: globalkey,
        endDrawer: Drawer(
            backgroundColor: Color(0xFF2A87E9),
            elevation: 80,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Weather in here!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Location 🔍",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    String returnedName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return customLocation();
                        },
                      ),
                    );
                    if (returnedName != null) {
                      var cityweatherinfo =
                          await Weatherinfo().gettingcitydata(returnedName);
                      Updates(cityweatherinfo);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    "Backend work 👀",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Backend();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "About Us 🤨",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return About_page();
                        },
                      ),
                    );
                  },
                ),
              ],
            )),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
                          "It's $cityname!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        globalkey.currentState?.openEndDrawer();
                      },
                      icon: Icon(
                        Icons.dehaze_rounded,
                        size: 35,
                      ),
                    )
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
        body: GestureDetector(
          onPanEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy > threshold) {
              this.setState(() {
                showmenu = false;
              });
            } else if (details.velocity.pixelsPerSecond.dy < -threshold) {
              this.setState(() {
                showmenu = true;
              });
            }
          },
          child: Stack(
            children: [
              SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                            "images/${Weatherinfo().returnimage(id)}.png"),
                        height: 260,
                        width: 340,
                        // color: Colors.white,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                height: 110,
                                child: Text(
                                  "$inttemp°",
                                  style: TextStyle(
                                    fontSize: 110,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF1D3CBD),
                            ),
                            height: 60,
                            width: 70,
                            child: TextButton(
                              onPressed: () async {
                                var received =
                                    await Weatherinfo().gettingdata();
                                Updates(received);
                              },
                              child: Icon(
                                Icons.hourglass_bottom,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 190,
                        ),
                        child: Container(
                          height: 25,
                          child: Text(
                            "$message!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeInOut,
                child: BottomDrawer(
                    inttemp,
                    cityname,
                    humidity,
                    windspeed,
                    pressure,
                    maxtemp,
                    mintemp,
                    sunrise,
                    sunset,
                    sealvl,
                    grdlvl,
                    message),
                duration: Duration(milliseconds: 200),
                left: 0,
                bottom: (showmenu)
                    ? -230
                    : -((3 * MediaQuery.of(context).size.height) / 4),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomDrawer extends StatelessWidget {
  BottomDrawer(
      this.inttemp,
      this.cityname,
      this.humidity,
      this.windspeed,
      this.pressure,
      this.maxtemp,
      this.mintemp,
      this.sunrise,
      this.sunset,
      this.sealvl,
      this.grdlvl,
      this.message);
  late int inttemp;
  late int windspeed;
  late String cityname;
  late int humidity;
  late int pressure;
  late int maxtemp;
  late int mintemp;
  late String sunrise;
  late String sunset;
  late int sealvl;
  late int grdlvl;
  late String message;
  var datefor = DateFormat("hh:m a");

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: ((3 * height) / 4) + 230,
      width: width,
      child: Column(
        children: [
          Icon(
            FontAwesomeIcons.minus,
            color: Colors.grey,
            size: 50,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Weather now",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 160,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.severe_cold,
                      color: Colors.grey.shade800,
                      size: 32,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Feel like",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "${inttemp - 2}°",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
              SizedBox(
                width: 25,
              ),
              SizedBox(
                width: 160,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.wind_power,
                      color: Colors.grey.shade800,
                      size: 32,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Wind",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "${windspeed}km/h",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 170,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      FontAwesomeIcons.umbrella,
                      color: Colors.grey.shade800,
                      size: 28,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Pressure",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "${pressure} Pa ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 160,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      FontAwesomeIcons.droplet,
                      color: Colors.grey.shade800,
                      size: 28,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Humidity",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "$humidity%",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 170,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      FontAwesomeIcons.arrowUp,
                      color: Colors.grey.shade800,
                      size: 28,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Max. Temp.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "${maxtemp + 3}°",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 160,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      FontAwesomeIcons.arrowDown,
                      color: Colors.grey.shade800,
                      size: 28,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Min. Temp.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "${mintemp - 3}°",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 170,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.sunny_snowing,
                      color: Colors.grey.shade800,
                      size: 28,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Sunrise",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "$sunrise",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 160,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.sunny,
                      color: Colors.grey.shade800,
                      size: 28,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Sunset",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "${sunset}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 170,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.water,
                      color: Colors.grey.shade800,
                      size: 28,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Sea Lvl.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "$sealvl millibar",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 160,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.landscape,
                      color: Colors.grey.shade800,
                      size: 28,
                    ),
                    radius: 23,
                  ),
                  title: Text(
                    "Ground Lvl.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "$grdlvl millibar",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12.0,
                  tileColor: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade400,
            ),
            width: 320,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Looks like its $message in $cityname...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
