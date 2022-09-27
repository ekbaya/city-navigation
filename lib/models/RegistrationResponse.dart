// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegistrationResponse {
  final String message;
  final String status;
  final String success;
  RegistrationResponse({
    required this.message,
    required this.status,
    required this.success,
  });

  RegistrationResponse copyWith({
    String? message,
    String? status,
    String? success,
  }) {
    return RegistrationResponse(
      message: message ?? this.message,
      status: status ?? this.status,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
      'success': success,
    };
  }

  factory RegistrationResponse.fromMap(Map<String, dynamic> map) {
    return RegistrationResponse(
      message: map['message'] as String,
      status: map['status'] as String,
      success: map['success'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationResponse.fromJson(String source) =>
      RegistrationResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegistrationResponse(message: $message, status: $status, success: $success)';

  @override
  bool operator ==(covariant RegistrationResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.status == status &&
        other.success == success;
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode ^ success.hashCode;
}
