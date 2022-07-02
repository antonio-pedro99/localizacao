import 'package:flutter/material.dart';
import 'package:my_location/address/model.dart';

class UserModel extends ChangeNotifier {
  final List<UserAddress> _addresses = [];

  void addAddress(UserAddress address) {
    _addresses.add(address);
    notifyListeners();
  }

  List<UserAddress> get addresses => _addresses;
}
