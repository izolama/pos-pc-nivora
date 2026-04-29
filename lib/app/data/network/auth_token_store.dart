import 'package:shared_preferences/shared_preferences.dart';

import 'session_bootstrap.dart';

class AuthTokenStore {
  AuthTokenStore() : _token = SessionBootstrap.initialToken;

  static const _tokenKey = 'pos_token';
  String? _token;

  String? get token => _token;

  bool get hasToken => _token != null && _token!.isNotEmpty;

  Future<void> save(String token) async {
    _token = token;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
  }

  Future<void> clear() async {
    _token = null;
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_tokenKey);
  }
}
