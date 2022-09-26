// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:city_navigation/models/Route.dart';
import 'package:city_navigation/models/Shape.dart';

class Trip implements Comparable<Trip> {
  final int id;
  final String trip_id;
  final String trip_headsign;
  final Route route;
  final Shape shape;
  Trip({
    required this.id,
    required this.trip_id,
    required this.trip_headsign,
    required this.route,
    required this.shape,
  });

  Trip copyWith({
    int? id,
    String? trip_id,
    String? trip_headsign,
    Route? route,
    Shape? shape,
  }) {
    return Trip(
      id: id ?? this.id,
      trip_id: trip_id ?? this.trip_id,
      trip_headsign: trip_headsign ?? this.trip_headsign,
      route: route ?? this.route,
      shape: shape ?? this.shape,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'trip_id': trip_id,
      'trip_headsign': trip_headsign,
      'route': route.toMap(),
      'shape': shape.toMap(),
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] as int,
      trip_id: map['trip_id'] as String,
      trip_headsign: map['trip_headsign'] as String,
      route: Route.fromMap(map['route'] as Map<String, dynamic>),
      shape: Shape.fromMap(map['shape'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Trip.fromJson(String source) =>
      Trip.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Trip(id: $id, trip_id: $trip_id, trip_headsign: $trip_headsign, route: $route, shape: $shape)';
  }

  @override
  bool operator ==(covariant Trip other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.trip_id == trip_id &&
        other.trip_headsign == trip_headsign &&
        other.route == route &&
        other.shape == shape;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        trip_id.hashCode ^
        trip_headsign.hashCode ^
        route.hashCode ^
        shape.hashCode;
  }

  @override
  int compareTo(Trip other) => trip_id.compareTo(other.trip_id);
}
