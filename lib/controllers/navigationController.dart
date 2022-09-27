import 'dart:convert';

import 'package:city_navigation/models/Stop.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:city_navigation/constants/AppConfig.dart';
import 'package:city_navigation/models/Trip.dart';

class NavigationController with ChangeNotifier {
  List<Trip> trips = [];
  List<Stop> stops = [];
  Future getTrips() async {
    final result = await http.get(
      Uri.parse(tripsUrl),
      headers: {
        'Accept': 'Application/json',
        'Content-Type': 'Application/json'
      },
    );
    var convertDataToJson = jsonDecode(result.body);
    if (kDebugMode) {
      print("TRIPS**************$convertDataToJson");
    }

    List list = convertDataToJson['data'];
    final List<Trip> trips = list.map((e) => Trip.fromMap(e)).toList();
    this.trips = trips;
    notifyListeners();
  }

  Future getStops() async {
    final result = await http.get(
      Uri.parse(stopsUrl),
      headers: {
        'Accept': 'Application/json',
        'Content-Type': 'Application/json'
      },
    );
    var convertDataToJson = jsonDecode(result.body);
    if (kDebugMode) {
      print("Stops**************$convertDataToJson");
    }
    List list = convertDataToJson['data'];
    final List<Stop> stops = list.map((e) => Stop.fromMap(e)).toList();
    if (kDebugMode) {
      print("TRIPs======================${stops.length}");
    }
    this.stops = stops;
    notifyListeners();
  }

  Future<List<Trip>> getPaginatedTrips(int pageNumber, int pageSize) async {
    final result = await http.get(
      Uri.parse("$tripsPagesUrl?limit=$pageSize&page=$pageNumber"),
      headers: {
        'Accept': 'Application/json',
        'Content-Type': 'Application/json'
      },
    );
    var convertDataToJson = jsonDecode(result.body);
    if (kDebugMode) {
      print("TRIPS RESPONSE**************$convertDataToJson");
    }

    List list = convertDataToJson['results'];
    final List<Trip> trips = list.map((e) => Trip.fromMap(e)).toList();
    return trips;
  }
}
