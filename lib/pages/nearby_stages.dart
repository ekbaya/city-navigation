import 'package:city_navigation/constants/AppStyle.dart';
import 'package:city_navigation/models/StopWithDistance.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../controllers/navigationController.dart';
import '../models/Stop.dart';
import 'directions.dart';

class NearByStagesPage extends StatefulWidget {
  const NearByStagesPage({super.key, required this.currentUerPosition});
  final Position currentUerPosition;

  @override
  State<NearByStagesPage> createState() => _NearByStagesPageState();
}

class _NearByStagesPageState extends State<NearByStagesPage> {
  bool loading = true;
  List<StopWithDistance> stopsWithDistance = [];
  List<Stop> stops = [];
  late NavigationController navigationController;
  @override
  void initState() {
    navigationController =
        Provider.of<NavigationController>(context, listen: false);
    computeDistance();
    super.initState();
  }

  void computeDistance() async {
    //2. Filter all stops that are less tha 500m from the user location
    stops = await navigationController.getStops();
    for (var stop in stops) {
      //1. Compute distance
      double distance = Geolocator.distanceBetween(
        widget.currentUerPosition.latitude,
        widget.currentUerPosition.longitude,
        double.parse(stop.stop_lat),
        double.parse(stop.stop_lon),
      );
      if (distance <= 1000) {
        //3. Select the distances that are less tha 1km from the user
        stopsWithDistance.add(StopWithDistance(
            stop: stop, distanceFromUser: distance.toString()));
      }
    }

    setState(() {
      //sort the list
      stopsWithDistance.sort(
        (a, b) => a.distanceFromUser.compareTo(b.distanceFromUser),
      );
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
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DirectionsPage(
                            name: stopsWithDistance[index].stop.stop_name,
                            lat: stopsWithDistance[index].stop.stop_lat,
                            long: stopsWithDistance[index].stop.stop_lon,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppStyle.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        distanceText(double.parse(
                            stopsWithDistance[index].distanceFromUser)),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  String distanceText(double distance) {
    if (distance < 1000) {
      return "${distance.toInt()} m";
    } else {
      return "${distance / 1000} km";
    }
  }
}
