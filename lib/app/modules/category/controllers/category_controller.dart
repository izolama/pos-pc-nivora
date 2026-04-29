import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/exceptions/app_exception.dart';
import '../../../data/models/category/category_item.dart';
import '../../../data/repositories/category_repository.dart';

class CategoryController extends GetxController {
  CategoryController({required CategoryRepository repository})
    : _repository = repository;

  final CategoryRepository _repository;

  final categories = <CategoryItem>[].obs;
  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final errorMessage = ''.obs;

  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final descriptionController = TextEditingController();

  final selectedCategoryId = RxnInt();

  bool get isEditing => selectedCategoryId.value != null;

  @override
  void onClose() {
    nameController.dispose();
    imageController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> loadCategories() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      categories.assignAll(await _repository.getCategories());
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat kategori.';
    } finally {
      isLoading.value = false;
    }
  }

  void startCreate() {
    selectedCategoryId.value = null;
    nameController.clear();
    imageController.clear();
    descriptionController.clear();
  }

  void startEdit(CategoryItem item) {
    selectedCategoryId.value = item.id;
    nameController.text = item.name;
    imageController.text = item.imageUrl;
    descriptionController.text = item.description;
  }

  Future<void> submit() async {
    isSubmitting.value = true;
    errorMessage.value = '';
    try {
      if (isEditing) {
        await _repository.updateCategory(
          categoryId: selectedCategoryId.value!,
          name: nameController.text.trim(),
          image: imageController.text.trim(),
          description: descriptionController.text.trim(),
        );
      } else {
        await _repository.createCategory(
          name: nameController.text.trim(),
          image: imageController.text.trim(),
          description: descriptionController.text.trim(),
        );
      }
      await loadCategories();
      startCreate();
      Get.snackbar(
        'Kategori tersimpan',
        'Perubahan kategori berhasil dikirim ke API.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menyimpan kategori.';
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    try {
      await _repository.deleteCategory(categoryId);
      await loadCategories();
      if (selectedCategoryId.value == categoryId) {
        startCreate();
      }
      Get.snackbar(
        'Kategori dihapus',
        'Data kategori berhasil dihapus dari API.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menghapus kategori.';
    }
  }
}
