// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDTO {
  final String name;
  final String email;
  final String phone;
  final String password;
  UserDTO({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  UserDTO copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) {
    return UserDTO(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDTO.fromJson(String source) =>
      UserDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDTO(name: $name, email: $email, phone: $phone, password: $password)';
  }

  @override
  bool operator ==(covariant UserDTO other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ phone.hashCode ^ password.hashCode;
  }
}
