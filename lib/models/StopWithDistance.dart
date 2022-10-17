// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:city_navigation/models/Stop.dart';

class StopWithDistance {
  final Stop stop;
  final String distanceFromUser;
  StopWithDistance({
    required this.stop,
    required this.distanceFromUser,
  });

  StopWithDistance copyWith({
    Stop? stop,
    String? distanceFromUser,
  }) {
    return StopWithDistance(
      stop: stop ?? this.stop,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stop': stop.toMap(),
      'distanceFromUser': distanceFromUser,
    };
  }

  factory StopWithDistance.fromMap(Map<String, dynamic> map) {
    return StopWithDistance(
      stop: Stop.fromMap(map['stop'] as Map<String, dynamic>),
      distanceFromUser: map['distanceFromUser'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StopWithDistance.fromJson(String source) =>
      StopWithDistance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StopWithDistance(stop: $stop, distanceFromUser: $distanceFromUser)';

  @override
  bool operator ==(covariant StopWithDistance other) {
    if (identical(this, other)) return true;

    return other.stop == stop && other.distanceFromUser == distanceFromUser;
  }

  @override
  int get hashCode => stop.hashCode ^ distanceFromUser.hashCode;
}
