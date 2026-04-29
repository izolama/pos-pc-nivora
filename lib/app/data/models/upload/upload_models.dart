class UploadImageResult {
  const UploadImageResult({required this.urlFull, required this.urlThumb});

  final String urlFull;
  final String urlThumb;

  factory UploadImageResult.fromJson(Map<String, dynamic> json) {
    return UploadImageResult(
      urlFull: json['urlFull']?.toString() ?? '',
      urlThumb: json['urlThumb']?.toString() ?? '',
    );
  }
}
