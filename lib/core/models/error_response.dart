class ErrorResponse {
  const ErrorResponse({required this.error});

  final String error;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(error: json['error'] as String);
  }
}
