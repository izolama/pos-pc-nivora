import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/exceptions/app_exception.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  AuthController({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  bool get isLoggedIn => (_repository.token ?? '').isNotEmpty;

  String get maskedToken {
    final token = _repository.token ?? '';
    if (token.length <= 14) {
      return token;
    }
    return '${token.substring(0, 8)}...${token.substring(token.length - 6)}';
  }

  @override
  void onInit() {
    super.onInit();
    usernameController.text = 'your_username';
    passwordController.text = '123456';
    if (isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(AppPages.dashboard);
      });
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _repository.login(
        username: usernameController.text.trim(),
        password: passwordController.text,
      );
      Get.offAllNamed(AppPages.dashboard);
      Get.snackbar(
        'Login berhasil',
        'Token berhasil didapat dan sesi POS aktif.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Login gagal. Periksa kredensial dan akses API.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    Get.offAllNamed(AppPages.login);
  }
}
