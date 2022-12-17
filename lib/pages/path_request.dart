// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PathRequest {
  final String location;
  final String destination;
  PathRequest({
    required this.location,
    required this.destination,
  });

  PathRequest copyWith({
    String? location,
    String? destination,
  }) {
    return PathRequest(
      location: location ?? this.location,
      destination: destination ?? this.destination,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'destination': destination,
    };
  }

  factory PathRequest.fromMap(Map<String, dynamic> map) {
    return PathRequest(
      location: map['location'] as String,
      destination: map['destination'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PathRequest.fromJson(String source) =>
      PathRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PathRequest(location: $location, destination: $destination)';

  @override
  bool operator ==(covariant PathRequest other) {
    if (identical(this, other)) return true;

    return other.location == location && other.destination == destination;
  }

  @override
  int get hashCode => location.hashCode ^ destination.hashCode;
}
