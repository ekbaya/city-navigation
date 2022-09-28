// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
  final String formattedAddress;
  final String placeName;
  final String placeId;
  final double latitude;
  final double longitude;
  Address({
    required this.formattedAddress,
    required this.placeName,
    required this.placeId,
    required this.latitude,
    required this.longitude,
  });

  Address copyWith({
    String? formattedAddress,
    String? placeName,
    String? placeId,
    double? latitude,
    double? longitude,
  }) {
    return Address(
      formattedAddress: formattedAddress ?? this.formattedAddress,
      placeName: placeName ?? this.placeName,
      placeId: placeId ?? this.placeId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'formattedAddress': formattedAddress,
      'placeName': placeName,
      'placeId': placeId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Address.fromMap(Map<dynamic, dynamic> map) {
    return Address(
      formattedAddress: map['formattedAddress'] as String,
      placeName: map['placeName'] as String,
      placeId: map['placeId'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(formattedAddress: $formattedAddress, placeName: $placeName, placeId: $placeId, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.formattedAddress == formattedAddress &&
        other.placeName == placeName &&
        other.placeId == placeId &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return formattedAddress.hashCode ^
        placeName.hashCode ^
        placeId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
