final class BaseRemoteResponse<T> {
  BaseRemoteResponse({
    required this.data,
    required this.success,
    required this.message,
    required this.statusCode,
  });

  final T? data;
  final bool? success;
  final String? message;
  final int? statusCode;
}
