import 'package:city_navigation/models/StopWithDistance.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../controllers/navigationController.dart';

class NearByStagesPage extends StatefulWidget {
  const NearByStagesPage({super.key, required this.currentUerPosition});
  final Position currentUerPosition;

  @override
  State<NearByStagesPage> createState() => _NearByStagesPageState();
}

class _NearByStagesPageState extends State<NearByStagesPage> {
  bool loading = true;
  List<StopWithDistance> stopsWithDistance = [];
  late NavigationController navigationController;
  @override
  void initState() {
    navigationController =
        Provider.of<NavigationController>(context, listen: false);
    computeDistance();
    super.initState();
  }

  void computeDistance() {
    //2. Filter all stops that are less tha 500m from the user location
    for (var stop in navigationController.stops) {
      //1. Compute distance
      double distance = Geolocator.distanceBetween(
          widget.currentUerPosition.latitude,
          widget.currentUerPosition.longitude,
          double.parse(stop.stop_lat),
          double.parse(stop.stop_lon));
      if (distance <= 500) {
        //3. Select the distances that are less tha 500m from the user
        stopsWithDistance.add(StopWithDistance(
            stop: stop, distanceFromUser: distance.toString()));
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Stages Near You",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: loading
          ? Lottie.asset('assets/jsons/loading.json')
          : ListView.builder(
              itemCount: stopsWithDistance.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.place),
                  title: Text(stopsWithDistance[index].stop.stop_name),
                  subtitle: Text(stopsWithDistance[index].stop.stop_id),
                  trailing: Text(distanceText(
                      double.parse(stopsWithDistance[index].distanceFromUser))),
                );
              },
            ),
    );
  }

  String distanceText(double distance) {
    if (distance < 1000) {
      return "$distance m";
    } else {
      return "${distance / 1000} km";
    }
  }
}
