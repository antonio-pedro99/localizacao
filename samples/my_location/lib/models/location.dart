import 'package:my_location/models/address.dart';

class DefaultLocation {
  int? placeId;
  String? lat;
  String? lon;
  String? displayName;
  Address? address;
  List<String>? boundingbox;

  DefaultLocation(
      {this.placeId,
      this.lat,
      this.lon,
      this.displayName,
      this.address,
      this.boundingbox});

  DefaultLocation.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    lat = json['lat'];
    lon = json['lon'];
    displayName = json['display_name'];
    if (json['address'] != null) {
      address = Address.fromJson(json['address']);
    } else {
      address = null;
    }
    boundingbox = json['boundingbox'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;

    data['lat'] = lat;
    data['lon'] = lon;
    data['display_name'] = displayName;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['boundingbox'] = boundingbox;
    return data;
  }
}
