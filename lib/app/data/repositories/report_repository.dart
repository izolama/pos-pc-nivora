import '../models/report/report_models.dart';
import '../services/report_api_service.dart';

class ReportRepository {
  ReportRepository({required ReportApiService service}) : _service = service;

  final ReportApiService _service;

  Future<SummaryReportModel> getSummaryReport() {
    return _service.getSummaryReport();
  }
}
