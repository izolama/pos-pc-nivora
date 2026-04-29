import '../models/auth/auth_login_request.dart';
import '../models/auth/auth_session.dart';
import '../services/auth_api_service.dart';

class AuthRepository {
  AuthRepository({required AuthApiService service}) : _service = service;

  final AuthApiService _service;

  Future<AuthSession> login({
    required String username,
    required String password,
  }) {
    return _service.login(
      AuthLoginRequest(username: username, password: password),
    );
  }

  String? get token => _service.token;

  Future<void> logout() {
    return _service.logout();
  }
}
