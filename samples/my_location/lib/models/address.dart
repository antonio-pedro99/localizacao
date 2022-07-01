class Address {
  String? suburb;
  String? county;
  String? stateDistrict;
  String? state;
  String? postcode;
  String? country;
  String? countryCode;

  Address(
      {this.suburb,
      this.county,
      this.stateDistrict,
      this.state,
      this.postcode,
      this.country,
      this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    suburb = json['suburb'];
    county = json['county'];
    stateDistrict = json['state_district'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suburb'] = suburb;
    data['county'] = county;
    data['state_district'] = stateDistrict;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    data['country_code'] = countryCode;
    return data;
  }
}
