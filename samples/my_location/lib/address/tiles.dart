import 'package:flutter/material.dart';
import 'package:my_location/address/model.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({Key? key, required this.address}) : super(key: key);

  final UserAddress address;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.business),
      title: Text(
        address.addressDetails!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Text(
          "${address.address!.formatted!}, ${address.address!.city ?? ""} "),
    );
  }
}
