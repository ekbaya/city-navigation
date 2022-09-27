// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:city_navigation/models/user.dart';

class AccountResponse {
  final String message;
  final String status;
  final bool success;
  final User user;
  AccountResponse({
    required this.message,
    required this.status,
    required this.success,
    required this.user,
  });

  AccountResponse copyWith({
    String? message,
    String? status,
    bool? success,
    User? user,
  }) {
    return AccountResponse(
      message: message ?? this.message,
      status: status ?? this.status,
      success: success ?? this.success,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
      'success': success,
      'user': user.toMap(),
    };
  }

  factory AccountResponse.fromMap(Map<String, dynamic> map) {
    return AccountResponse(
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      success: map['sucess'] ?? false,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountResponse.fromJson(String source) =>
      AccountResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountResponse(message: $message, status: $status, success: $success, user: $user)';
  }

  @override
  bool operator ==(covariant AccountResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.status == status &&
        other.success == success &&
        other.user == user;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        status.hashCode ^
        success.hashCode ^
        user.hashCode;
  }
}
