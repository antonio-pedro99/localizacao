import 'dart:convert';

import 'package:my_location/models/location.dart';
import 'package:my_location/models/query.dart';
import 'package:my_location/models/request_response.dart';
import 'package:http/http.dart' as http;

const String localizacaoApi = "https://geolocalizacao-api.herokuapp.com";

class CoordinateToAddress {


  static Future<RequestResponse> fromCoordinates(double? latitude, double? longitude) async {
    RequestResponse requestResponse = RequestResponse();
    await http
        .get(Uri.parse("$localizacaoApi/details/?lat=$latitude&lon=$longitude"))
        .then((value) {
      if (value.statusCode == 200) {
        requestResponse.setData =
            DefaultLocation.fromJson(jsonDecode(value.body));
      } else {
        requestResponse.setError = jsonDecode(value.body);
      }
    });
    return requestResponse;
  }



  static Future<RequestResponse> calculatePriceByDistance(Query query) async {
    RequestResponse requestResponse = RequestResponse();
    await http
        .get(Uri.parse(
            "$localizacaoApi/distance/cost?loc_lact=28.525377&loc_lon=77.280106&des_lat=28.5481899&des_lon=77.2740645&fixed_tax=30&tax=3"))
        .then((value) {
      if (value.statusCode == 200) {
        requestResponse.setData =
            DefaultLocation.fromJson(jsonDecode(value.body));
      } else {
        requestResponse.setError = jsonDecode(value.body);
      }
    });

    return requestResponse;
  }
}
