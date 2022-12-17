import 'dart:async';

import 'package:city_navigation/models/path.dart';
import 'package:city_navigation/pages/path_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PathPage extends StatefulWidget {
  const PathPage({super.key, required this.path, required this.pathRequest});

  final Path path;
  final PathRequest pathRequest;

  @override
  State<PathPage> createState() => _PathPageState();
}

class _PathPageState extends State<PathPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> controllerGoogleMap = Completer();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: Text(
          "Path from ${widget.pathRequest.location} to ${widget.pathRequest.destination}",
          style: const TextStyle(color: Colors.black),
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

      for (int i = 0; i < widget.path.path.length; i++) {
        markersSet.add(
          Marker(
              markerId: MarkerId((i + 1).toString()),
              position: LatLng(widget.path.path[i][0], widget.path.path[i][1]),
              infoWindow: i == 0
                  ? InfoWindow(
                      title: widget.pathRequest.location,
                      snippet: "Origin Location")
                  : i == widget.path.path.length - 1
                      ? InfoWindow(
                          title: widget.pathRequest.destination,
                          snippet: "Destination Location")
                      : InfoWindow.noText,
              draggable: false,
              flat: true,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue)),
        );
      }

      setState(() {});

      LatLng latLngPosition =
          LatLng(widget.path.path[0][0], widget.path.path[0][1]);
      CameraPosition cameraPosition =
          CameraPosition(target: latLngPosition, zoom: 18);
      newGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  Future<void> requestPermission(Permission permission) async {
    await permission.request();
  }
}
