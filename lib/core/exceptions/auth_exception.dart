// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthException implements Exception {
  static const Map<String, String> errorsPortuguese = { //Default erros in authentication - In portuguese
    'EMAIL_EXISTS': 'E-mail já cadastrado!',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Acesso bloqueado temporariamente. Tente novamente mais tarde!',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID PASSWORD': 'Senha informada não confere.',
    'USER_DISABLED': 'A conta do usuário foi desabilitada.',
    'INVALID_LOGIN_CREDENTIALS': 'Verifique o e-mail e senha!',
  };

  static const Map<String, String> errors = { //Default erros in authentication - In English
    'EMAIL_EXISTS': 'The E-mail',
    'OPERATION_NOT_ALLOWED': 'Operation not allowed!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Access blocked. Try again later!',
    'EMAIL_NOT_FOUND': 'E-mail not found!',
    'INVALID PASSWORD': 'Invalid password!',
    'USER_DISABLED': "User's account is disabled!",
    'INVALID_LOGIN_CREDENTIALS': "Invalid login credentials!",
  };

  final String key;

  AuthException({required this.key});

  @override
  String toString() => errors[key] ?? 'Error ocurred trying to authenticate user.';
}
