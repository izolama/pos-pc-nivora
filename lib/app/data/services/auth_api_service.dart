import '../config/api_endpoints.dart';
import '../models/api/api_response.dart';
import '../models/auth/auth_login_request.dart';
import '../models/auth/auth_session.dart';
import '../network/api_client.dart';
import '../network/auth_token_store.dart';

class AuthApiService {
  AuthApiService({
    required ApiClient apiClient,
    required AuthTokenStore tokenStore,
  }) : _apiClient = apiClient,
       _tokenStore = tokenStore;

  final ApiClient _apiClient;
  final AuthTokenStore _tokenStore;

  Future<AuthSession> login(AuthLoginRequest request) async {
    final json = await _apiClient.post(
      ApiEndpoints.login,
      body: request.toJson(),
      requiresAuth: false,
    );

    final response = ApiResponse<AuthSession>.fromJson(
      json,
      (raw) => AuthSession.fromJson(raw as Map<String, dynamic>),
    );

    await _tokenStore.save(response.data.token);
    return response.data;
  }

  String? get token => _tokenStore.token;

  Future<void> logout() {
    return _tokenStore.clear();
  }
}
