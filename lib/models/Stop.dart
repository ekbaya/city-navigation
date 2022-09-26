// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Stop {
  final int id;
  final String stop_id;
  final String stop_name;
  final String stop_lat;
  final String stop_lon;
  Stop({
    required this.id,
    required this.stop_id,
    required this.stop_name,
    required this.stop_lat,
    required this.stop_lon,
  });

  

  Stop copyWith({
    int? id,
    String? stop_id,
    String? stop_name,
    String? stop_lat,
    String? stop_lon,
  }) {
    return Stop(
      id: id ?? this.id,
      stop_id: stop_id ?? this.stop_id,
      stop_name: stop_name ?? this.stop_name,
      stop_lat: stop_lat ?? this.stop_lat,
      stop_lon: stop_lon ?? this.stop_lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stop_id': stop_id,
      'stop_name': stop_name,
      'stop_lat': stop_lat,
      'stop_lon': stop_lon,
    };
  }

  factory Stop.fromMap(Map<String, dynamic> map) {
    return Stop(
      id: map['id'] as int,
      stop_id: map['stop_id'] as String,
      stop_name: map['stop_name'] as String,
      stop_lat: map['stop_lat'] as String,
      stop_lon: map['stop_lon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stop.fromJson(String source) => Stop.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Stop(id: $id, stop_id: $stop_id, stop_name: $stop_name, stop_lat: $stop_lat, stop_lon: $stop_lon)';
  }

  @override
  bool operator ==(covariant Stop other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.stop_id == stop_id &&
      other.stop_name == stop_name &&
      other.stop_lat == stop_lat &&
      other.stop_lon == stop_lon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      stop_id.hashCode ^
      stop_name.hashCode ^
      stop_lat.hashCode ^
      stop_lon.hashCode;
  }
}
