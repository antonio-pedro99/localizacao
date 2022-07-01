import 'package:flutter/material.dart';
import 'package:my_location/models/location.dart';
import 'package:my_location/models/request_response.dart';
import 'package:my_location/services/coordinates_to_address.dart';
import 'package:my_location/services/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Location Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Location Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DeviceLocation deviceLocation = DeviceLocation();
  late bool serviceEnabled;
  late bool permissionStatus;
  String text = "Starting";
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    serviceEnabled = await deviceLocation.enableService();
    permissionStatus = await deviceLocation.grantPermission();

    if (permissionStatus && serviceEnabled) {
      await deviceLocation.getDeviceLocationData();
      deviceLocation.location.enableBackgroundMode(enable: true);

      deviceLocation.location.onLocationChanged.listen((event) {
        setState(() {
          text =
              "Latitude: ${deviceLocation.locationData!.latitude}, Longitude: ${deviceLocation.locationData!.longitude}";
        });
      });
    } else {
      setState(() {
        text = "Nothing to show";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "$text",
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          RequestResponse requestResponse =
              await CoordinateToAddress.fromCoordinates(
                  deviceLocation.locationData!.latitude,
                  deviceLocation.locationData!.longitude);

          if (!requestResponse.hasError) {
            DefaultLocation location = requestResponse.data as DefaultLocation;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
              padding: const EdgeInsets.all(10),
              child: Text("${location.displayName}"),
            )));
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
