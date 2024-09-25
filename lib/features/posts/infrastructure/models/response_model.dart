class ResponseModel<T> {
  final T data;
  final bool isFromCache;
  final String? message;

  ResponseModel({
    required this.data,
    this.isFromCache = false,
    this.message,
  });
}
