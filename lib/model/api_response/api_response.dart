class ApiResponse<T> {
  final bool error;
  final String message;
  final T data;

  ApiResponse({required this.error, required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ApiResponse(error: json['error'], message: json['message'], data: fromJson(json));
  }
}
