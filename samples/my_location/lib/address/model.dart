import 'package:flutter/cupertino.dart';

@immutable
class AddressModel {
  String? countryCode;
  String? housenumber;
  String? street;
  String? country;
  String? postcode;
  String? state;
  String? district;
  String? city;
  double? lon;
  double? lat;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  String? resultType;

  AddressModel(
      {this.countryCode,
      this.housenumber,
      this.street,
      this.country,
      this.postcode,
      this.state,
      this.district,
      this.city,
      this.lon,
      this.lat,
      this.formatted,
      this.addressLine1,
      this.addressLine2,
      this.resultType});

  AddressModel.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    housenumber = json['housenumber'];
    street = json['street'];
    country = json['country'];
    postcode = json['postcode'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    lon = json['lon'];
    lat = json['lat'];
    formatted = json['formatted'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    resultType = json['result_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = countryCode;
    data['housenumber'] = housenumber;
    data['street'] = street;
    data['country'] = country;
    data['postcode'] = postcode;
    data['state'] = state;
    data['district'] = district;
    data['city'] = city;
    data['lon'] = lon;
    data['lat'] = lat;
    data['formatted'] = formatted;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['result_type'] = resultType;
    return data;
  }

  @override
  String toString() {
    return '$formatted';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AddressModel && other.formatted == formatted && other.city == city;
  }

  @override
  int get hashCode => Object.hash(formatted, city);
}

class UserAddres {
  AddressModel? address;
  String? addressDetails; //House No, Flat No, Street and etc.

  UserAddres({this.address, this.addressDetails});

}
