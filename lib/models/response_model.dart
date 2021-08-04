abstract class PostResponse {
  final String message;
  PostResponse({required this.message});
}

class FailedResponse extends PostResponse {
  final String? errorMessage;
  final String? errorKey;
  final errorData;

  FailedResponse({
    required String message,
    this.errorMessage,
    this.errorKey,
    this.errorData,
  }) : super(message: message);

  factory FailedResponse.fromJson(Map<String, dynamic> json) {
    return FailedResponse(
      message: json['message'],
      errorMessage: json['message'],
      errorKey: json['message'],
      errorData: json['message'],
    );
  }
}

class SuccessResponse extends PostResponse {
  SuccessResponse({required String message}) : super(message: message);

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(message: json['message']);
  }
}
