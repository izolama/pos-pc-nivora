class AuthSession {
  const AuthSession({required this.token});

  final String token;

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(token: json['token']?.toString() ?? '');
  }
}
