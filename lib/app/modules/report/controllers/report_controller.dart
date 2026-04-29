import 'package:get/get.dart';

import '../../../data/exceptions/app_exception.dart';
import '../../../data/models/report/report_models.dart';
import '../../../data/repositories/report_repository.dart';

class ReportController extends GetxController {
  ReportController({required ReportRepository repository})
    : _repository = repository;

  final ReportRepository _repository;

  final report = Rxn<SummaryReportModel>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      report.value = await _repository.getSummaryReport();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat summary report.';
    } finally {
      isLoading.value = false;
    }
  }
}
