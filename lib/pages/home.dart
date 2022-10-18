import 'dart:async';

import 'package:city_navigation/controllers/authController.dart';
import 'package:city_navigation/models/AccountResponse.dart';
import 'package:city_navigation/pages/bus_stops.dart';
import 'package:city_navigation/pages/login.dart';
import 'package:city_navigation/pages/nearby_stages.dart';
import 'package:city_navigation/pages/welcome.dart';
import 'package:city_navigation/utilities/toastDialog.dart';
import 'package:city_navigation/widgets/mainDrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/AppData.dart';
import 'routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> controllerGoogleMap = Completer();
  late AppData appData;
  late GoogleMapController newGoogleMapController;
  // ignore: unnecessary_const
  static const CameraPosition kenya = const CameraPosition(
    target: LatLng(1.286389, 36.817223),
    zoom: 19,
  );

  late Position currentPosition;
  var geoLocator = Geolocator();
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  bool newNotification = false;
  //   location pin
  late BitmapDescriptor locationPin;
  @override
  void initState() {
    appData = Provider.of<AppData>(context, listen: false);
    fetchCurrentUser();
    super.initState();
  }

  fetchCurrentUser() async {
    final AccountResponse accountResponse =
        await AuthController.getCurrentUser();
    if (accountResponse.success) {
      appData.setUser(accountResponse.user);
    } else {
      ToastDialogue().showToast(accountResponse.message, 1);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginPage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: GestureDetector(
          onTap: () {},
          child: const Text(
            "Where are you going?",
            style: TextStyle(color: Colors.black),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 1.5,
              color: Colors.indigo),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: kenya,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        markers: markersSet,
        circles: circlesSet,
        onMapCreated: (GoogleMapController controler) {
          controllerGoogleMap.complete(controler);
          newGoogleMapController = controler;
          locatePosition();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Bus stops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Near You',
          ),
        ],
        onTap: ((value) {
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Routes()),
            );
          }
          if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BusStopsPage()),
            );
          }
          if (value == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NearByStagesPage(
                  currentUerPosition: currentPosition,
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  void locatePosition() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    if (kDebugMode) {
      print(statuses[Permission.location]);
    }
    if (statuses[Permission.location]!.isDenied) {
      requestPermission(Permission.location);
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;

      setState(() {
        markersSet.add(
          Marker(
              markerId: const MarkerId("user"),
              position: LatLng(position.latitude, position.longitude),
              anchor: const Offset(0.5, 0.5),
              draggable: false,
              flat: true,
              infoWindow: const InfoWindow(
                  title: "Home Address", snippet: "Current Location"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet)),
        );
      });

      LatLng latLngPosition = LatLng(position.latitude, position.longitude);
      CameraPosition cameraPosition =
          CameraPosition(target: latLngPosition, zoom: 19);
      newGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  Future<void> requestPermission(Permission permission) async {
    await permission.request();
  }
}
