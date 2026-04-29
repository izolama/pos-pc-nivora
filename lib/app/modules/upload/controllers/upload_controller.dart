import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../data/exceptions/app_exception.dart';
import '../../../data/models/upload/upload_models.dart';
import '../../../data/repositories/upload_repository.dart';

class UploadController extends GetxController {
  UploadController({required UploadRepository repository})
    : _repository = repository;

  final UploadRepository _repository;

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final uploaded = Rxn<UploadImageResult>();
  final selectedFileName = ''.obs;

  Future<void> pickAndUpload() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      final file = result?.files.single;
      final bytes = file?.bytes;
      if (file == null || bytes == null) {
        isLoading.value = false;
        return;
      }
      selectedFileName.value = file.name;
      uploaded.value = await _repository.uploadImage(
        bytes: Uint8List.fromList(bytes),
        filename: file.name,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal upload image.';
    } finally {
      isLoading.value = false;
    }
  }
}
