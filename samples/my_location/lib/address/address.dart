import 'package:flutter/material.dart';
import 'package:my_location/address/model.dart';
import 'package:my_location/address/service.dart';


class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<String> address = <String>[
    "Antonio",
    "Pedro",
    "igg",
    "mov",
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  List<AddressModel> suggestions = [];

  var formKey = GlobalKey<FormState>();
  String selectOption = "Selected Option";

  Future<void> getSuggetions(String text) async {
    suggestions = await AddressSuggestions.getSuggestions(text);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Autocomplete<AddressModel>(
                optionsBuilder: ((textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<AddressModel>.empty();
                  }

                  getSuggetions(textEditingValue.text);
                  return suggestions.where((element) => element.formatted!
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                }),
                onSelected: (addressModel) {
                  setState(() {
                    selectOption = addressModel.formatted!;
                    suggestions.clear();
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(selectOption, style: Theme.of(context).textTheme.headline5)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
