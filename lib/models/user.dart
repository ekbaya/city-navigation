// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String name;
  final String email;
  final String phone;
  final String id;
  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
  });

  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? id,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'id': id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $name, email: $email, phone: $phone, id: $id)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ phone.hashCode ^ id.hashCode;
  }
}
