import 'package:flutter/material.dart';
import 'package:my_location/address/model.dart';
import 'package:my_location/address/service.dart';
import 'package:my_location/address/tiles.dart';
import 'package:my_location/address/user.dart';
import 'package:my_location/models/query.dart';
import 'package:my_location/models/request_response.dart';
import 'package:my_location/services/coordinates_to_address.dart';
import 'package:provider/provider.dart';

class UserAddressesPage extends StatelessWidget {
  const UserAddressesPage({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> getDistance(Query query) async {
    RequestResponse response =
        await CoordinateToAddress.calculatePriceByDistance(query);
    if (!response.hasError) {
      return response.data as Map<String, dynamic>;
    }
    return response.error as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    double officeLatitude =
        28.593833099999998; //replace this latitude to the office's latitude
    double officeLongitude =
        77.13497891459929; // replace longitude  to the office's longitude
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Addresses'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<UserModel>(
            builder: (context, user, child) {
              var addresses = user.addresses;

              if (addresses.isNotEmpty) {
                return ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      var currentAddress = addresses[index];
                      return GestureDetector(
                          onTap: () async {
                            var result = await getDistance(Query(
                                locLatitude: currentAddress.address!.lat,
                                locLongitude: currentAddress.address!.lon,
                                desLatitude: officeLatitude,
                                desLongitude: officeLongitude));
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      content: FutureBuilder<RequestResponse>(
                                          builder: ((context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const SizedBox(
                                                  height: 80,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator()));
                                            } else if (snapshot.hasError) {
                                              return const SizedBox(
                                                  height: 50,
                                                  child: Center(
                                                      child: Text(
                                                          "Something wrong happened")));
                                            }
                                            var result = snapshot.data!.data
                                                as Map<String, dynamic>;
                                            return SizedBox(
                                                height: 50,
                                                child: Text(
                                                    "Delivery Tax of ${result["total_tax"]} might be applied for ${result["distance"]}"));
                                          }),
                                          future: CoordinateToAddress
                                              .calculatePriceByDistance(Query(
                                                  locLatitude: currentAddress
                                                      .address!.lat,
                                                  locLongitude: currentAddress
                                                      .address!.lon,
                                                  desLatitude: officeLatitude,
                                                  desLongitude:
                                                      officeLongitude)))); // I am showing the raw Map only for your reference,you must change it to a user friend information
                                });
                          },
                          child: AddressTile(address: currentAddress));
                    });
              }
              return Center(
                  child: Text(
                "No Addresses Found",
                style: Theme.of(context).textTheme.bodyLarge,
              ));
            },
          ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddAddressPage();
            }));
          },
          child: const Icon(Icons.add),
        ));
  }
}

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  List<AddressModel> suggestions = [];
  var formKey = GlobalKey<FormState>();
  Future<void> getSuggetions(String text) async {
    suggestions = await AddressSuggestions.getSuggestions(text);
  }

  //to validade the address, so far just to check if it is in India
  bool addressValidate(AddressModel? address) {
    return address != null &&
        address.formatted!.isNotEmpty &&
        address.formatted!.startsWith(RegExp(r'[A-Z][a-z]')) &&
        address.country!.toLowerCase() == "india";
  }

  @override
  Widget build(BuildContext context) {
    UserAddress address = UserAddress();

    TextEditingController addressDetailsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Consumer<UserModel>(
            builder: (context, user, child) {
              return Column(
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
                      address.address = addressModel;

                      suggestions.clear();
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: addressDetailsController,
                    validator: (str) {
                      return str!.isNotEmpty ? null : "Required";
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                        hintText: "House No./Building or Flat No/Street et"),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (addressValidate(address.address)) {
                            address.addressDetails =
                                addressDetailsController.text;

                            user.addAddress(address);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text("Address added successfully"),
                              ),
                            )));
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                    "Unfortunately we are not able to delivery to this location! Please use another one"),
                              ),
                            )));
                          }
                        }
                      },
                      child: const Text(
                        "Save My Address",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
