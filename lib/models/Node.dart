// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Node {
  final String name;
  final String latitude;
  final String longitude;
  Node({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  Node copyWith({
    String? name,
    String? latitude,
    String? longitude,
  }) {
    return Node(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Node.fromMap(Map<dynamic, dynamic> map) {
    return Node(
      name: map['name'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Node.fromJson(String source) =>
      Node.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Node(name: $name, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant Node other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => name.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
