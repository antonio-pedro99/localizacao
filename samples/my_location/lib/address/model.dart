
// this class contains all information that will be provided by the API, do not change.
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

  AddressModel.fromAddress(AddressModel other) {
    countryCode = other.countryCode;
    housenumber = other.housenumber;
    street = other.street;
    country = other.country;
    postcode = other.postcode;
    state = other.state;
    district = other.district;
    city = other.city;
    lon = other.lon;
    lat = other.lat;
    formatted = other.formatted;
    addressLine1 = other.addressLine1;
    addressLine2 = other.addressLine2;
    resultType = other.resultType;
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
    return other is AddressModel &&
        other.formatted == formatted &&
        other.city == city;
  }

  @override
  int get hashCode => Object.hash(formatted, city);
}

// this will be the user Class, containing all information.
class UserAddress {
  AddressModel? address;
  String? addressDetails; //House No, Flat No, Street and etc.

  UserAddress({this.address, this.addressDetails});
}
