import 'package:http/http.dart';
import 'dart:convert';

class Locationdecoded {
  Locationdecoded(this.Url1);
  late String Url1;

  Future getdata() async {
    Response response = await get(Uri.parse(Url1));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeddata = jsonDecode(data);
      return decodeddata;
    } else {
      print(response.statusCode);
    }
  }
}
