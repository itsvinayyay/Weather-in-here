import 'package:geolocator/geolocator.dart';
import 'decoder.dart';

const apiid = "345feaf0fec56bc72c6978738efa985a";
const openweatherURL = "https://api.openweathermap.org/data/2.5/weather";
const openweatherURL2 =
    "https://api.openweathermap.org/data/2.5/air_pollution?";

class Weatherinfo {
  Future<dynamic> gettingcitydata(String Cityname) async {
    Locationdecoded senddata = Locationdecoded(
        "$openweatherURL?q=$Cityname&appid=$apiid&units=metric");
    var weatherinfo = await senddata.getdata();
    return weatherinfo;
  }

  Future<dynamic> gettingdata() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    Locationdecoded senddata = Locationdecoded(
        "$openweatherURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiid&units=metric");
    var decodeddata = await senddata.getdata();

    return decodeddata;
  }

  String returnimage(int condition) {
    if (condition > 200 && condition < 300) {
      return '6';
    } else if (condition > 300 && condition < 400) {
      return '1';
    } else if (condition > 400 && condition < 500) {
      return '7';
    } else if (condition > 500 && condition < 600) {
      return '5';
    } else if (condition > 700 && condition < 800) {
      return '8';
    } else if (condition == 800) {
      return '3';
    } else if (condition > 800 && condition <= 804) {
      return '2';
    } else {
      return '4';
    }
  }
}
