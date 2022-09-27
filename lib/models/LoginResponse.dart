// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponse {
  final String message;
  final String status;
  final bool success;
  final String token;
  LoginResponse({
    required this.message,
    required this.status,
    required this.success,
    required this.token,
  });

  LoginResponse copyWith({
    String? message,
    String? status,
    bool? success,
    String? token,
  }) {
    return LoginResponse(
      message: message ?? this.message,
      status: status ?? this.status,
      success: success ?? this.success,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
      'success': success,
      'token': token,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      success: map['success'] ?? false,
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponse(message: $message, status: $status, success: $success, token: $token)';
  }

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.status == status &&
        other.success == success &&
        other.token == token;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        status.hashCode ^
        success.hashCode ^
        token.hashCode;
  }
}
