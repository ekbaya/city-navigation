// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginDTO {
  final String email;
  final String password;
  LoginDTO({
    required this.email,
    required this.password,
  });

  LoginDTO copyWith({
    String? email,
    String? password,
  }) {
    return LoginDTO(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginDTO.fromMap(Map<String, dynamic> map) {
    return LoginDTO(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDTO.fromJson(String source) =>
      LoginDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginDTO(email: $email, password: $password)';

  @override
  bool operator ==(covariant LoginDTO other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
