import 'dart:typed_data';

import '../models/upload/upload_models.dart';
import '../services/upload_api_service.dart';

class UploadRepository {
  UploadRepository({required UploadApiService service}) : _service = service;

  final UploadApiService _service;

  Future<UploadImageResult> uploadImage({
    required Uint8List bytes,
    required String filename,
  }) {
    return _service.uploadImage(bytes: bytes, filename: filename);
  }
}
