import 'dart:convert';

import 'package:my_location/models/location.dart';
import 'package:my_location/models/query.dart';
import 'package:my_location/models/request_response.dart';
import 'package:http/http.dart' as http;

const String localizacaoApi = "https://geolocalizacao-api.herokuapp.com";

class CoordinateToAddress {
  static Future<RequestResponse> fromCoordinates(
      double? latitude, double? longitude) async {
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
            "$localizacaoApi/distance/cost/coordinates?loc_lact=${query.locLatitude}&loc_lon=${query.locLongitude}&des_lat=${query.desLatitude}&des_lon=${query.desLongitude}&fixed_tax=40&tax_rate=4"))
        .then((value) {
      if (value.statusCode == 200) {
        requestResponse.setData = jsonDecode(value.body);
      } else {
        requestResponse.setError = jsonDecode(value.body);
      }
    });

    return requestResponse;
  }
}
