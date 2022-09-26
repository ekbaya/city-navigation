// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Route {
  final int id;
  final int short_name;
  final String long_name;
  final String description;
  Route({
    required this.id,
    required this.short_name,
    required this.long_name,
    required this.description,
  });

  Route copyWith({
    int? id,
    int? short_name,
    String? long_name,
    String? description,
  }) {
    return Route(
      id: id ?? this.id,
      short_name: short_name ?? this.short_name,
      long_name: long_name ?? this.long_name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'short_name': short_name,
      'long_name': long_name,
      'description': description,
    };
  }

  factory Route.fromMap(Map<String, dynamic> map) {
    return Route(
      id: map['id'] as int,
      short_name: map['short_name'] as int,
      long_name: map['long_name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Route.fromJson(String source) =>
      Route.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Route(id: $id, short_name: $short_name, long_name: $long_name, description: $description)';
  }

  @override
  bool operator ==(covariant Route other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.short_name == short_name &&
        other.long_name == long_name &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        short_name.hashCode ^
        long_name.hashCode ^
        description.hashCode;
  }
}
