import 'package:flutter/material.dart';
import 'package:my_location/address/model.dart';

class AddressSuggestionTile extends StatelessWidget {
  const AddressSuggestionTile({Key? key, this.address}) : super(key: key);

  final AddressModel? address;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.business),
      title: Text(
        address!.formatted!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      trailing: Text(address!.country!),
    );
  }
}
