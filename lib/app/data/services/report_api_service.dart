import '../config/api_endpoints.dart';
import '../models/api/api_response.dart';
import '../models/report/report_models.dart';
import '../network/api_client.dart';

class ReportApiService {
  ReportApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<SummaryReportModel> getSummaryReport({
    String startDate = '2026-01-01',
    String endDate = '2026-12-31',
  }) async {
    final json = await _apiClient.get(
      ApiEndpoints.summaryReport,
      queryParameters: {'startDate': startDate, 'endDate': endDate},
    );
    final response = ApiResponse<SummaryReportModel>.fromJson(
      json,
      (raw) => SummaryReportModel.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }
}
