// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Shape {
  final int id;
  final int shape_pt_sequence;
  final String shape_pt_lat;
  final String shape_pt_lon;
  Shape({
    required this.id,
    required this.shape_pt_sequence,
    required this.shape_pt_lat,
    required this.shape_pt_lon,
  });

  Shape copyWith({
    int? id,
    int? shape_pt_sequence,
    String? shape_pt_lat,
    String? shape_pt_lon,
  }) {
    return Shape(
      id: id ?? this.id,
      shape_pt_sequence: shape_pt_sequence ?? this.shape_pt_sequence,
      shape_pt_lat: shape_pt_lat ?? this.shape_pt_lat,
      shape_pt_lon: shape_pt_lon ?? this.shape_pt_lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'shape_pt_sequence': shape_pt_sequence,
      'shape_pt_lat': shape_pt_lat,
      'shape_pt_lon': shape_pt_lon,
    };
  }

  factory Shape.fromMap(Map<String, dynamic> map) {
    return Shape(
      id: map['id'] as int,
      shape_pt_sequence: map['shape_pt_sequence'] as int,
      shape_pt_lat: map['shape_pt_lat'] as String,
      shape_pt_lon: map['shape_pt_lon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shape.fromJson(String source) =>
      Shape.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shape(id: $id, shape_pt_sequence: $shape_pt_sequence, shape_pt_lat: $shape_pt_lat, shape_pt_lon: $shape_pt_lon)';
  }

  @override
  bool operator ==(covariant Shape other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.shape_pt_sequence == shape_pt_sequence &&
        other.shape_pt_lat == shape_pt_lat &&
        other.shape_pt_lon == shape_pt_lon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shape_pt_sequence.hashCode ^
        shape_pt_lat.hashCode ^
        shape_pt_lon.hashCode;
  }
}
