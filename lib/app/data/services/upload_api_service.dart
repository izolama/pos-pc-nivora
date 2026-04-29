import 'dart:typed_data';

import '../config/api_endpoints.dart';
import '../config/app_environment.dart';
import '../models/api/api_response.dart';
import '../models/upload/upload_models.dart';
import '../network/api_client.dart';

class UploadApiService {
  UploadApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<UploadImageResult> uploadImage({
    required Uint8List bytes,
    required String filename,
  }) async {
    final json = await _apiClient.postMultipart(
      baseUrlOverride: AppEnvironment.uploadBaseUrl,
      path: ApiEndpoints.uploadImage,
      fileField: 'file',
      bytes: bytes,
      filename: filename,
    );
    final response = ApiResponse<UploadImageResult>.fromJson(
      json,
      (raw) => UploadImageResult.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }
}
