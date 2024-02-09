class Authentication {
  final String email;
  final String password;
  final String? confirmPassword;
  final String? token;

  Authentication({
    required this.email,
    required this.password,
    this.confirmPassword,
    this.token,
  });
}
