class ApiResponse<T> {
  const ApiResponse({
    required this.status,
    required this.message,
    required this.data,
    this.meta,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
  });

  final String status;
  final String message;
  final T data;
  final Map<String, dynamic>? meta;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic rawData) mapper,
  ) {
    return ApiResponse<T>(
      status: json['status']?.toString() ?? 'UNKNOWN',
      message: json['message']?.toString() ?? '',
      data: mapper(json['data']),
      meta:
          json['meta'] is Map<String, dynamic>
              ? json['meta'] as Map<String, dynamic>
              : null,
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
    );
  }
}
