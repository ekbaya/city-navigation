// ignore: file_names
import 'package:city_navigation/constants/AppConfig.dart';
import 'package:city_navigation/helpers/GoogleMapsRepository.dart';
import 'package:city_navigation/models/DirectionDetail.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainAppAPI {
  static Future<String> searchCoordinatesAddress(
      Position position, context) async {
    String placeAddress = "";
    String lat = position.latitude.toString();
    String lng = position.longitude.toString();
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$mapKey";

    var response = await GoogleMapsRepository.getRequest(url);

    if (response != "failed") {
      placeAddress = response["results"][0]["formatted_address"];
    }

    return placeAddress;
  }

  static Future<DirectionDetail> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng destinationPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey";
    var resp = await GoogleMapsRepository.getRequest(directionUrl);
    if (resp == "failed") {
      return DirectionDetail(
          distanceValue: 0,
          durationValue: 0,
          distanceText: "",
          durationText: "",
          encodedPoints: "");
    }

    DirectionDetail directionDetail = DirectionDetail(
        distanceValue: resp["routes"][0]["legs"][0]["distance"]["value"],
        durationValue: resp["routes"][0]["legs"][0]["duration"]["value"],
        distanceText: resp["routes"][0]["legs"][0]["distance"]["text"],
        durationText: resp["routes"][0]["legs"][0]["duration"]["text"],
        encodedPoints: resp["routes"][0]["overview_polyline"]["points"]);

    return directionDetail;
  }
}
