/// Modelo de *request* para login de usuários.
class UserLoginRequestModel {
  /// Crie um modelo de *request* para login de usuários. O [email] deve ser uma
  /// String, além de ser um e-mail válido.
  UserLoginRequestModel({
    required this.email,
    required this.password,
  });

  /// E-mail do usuário.
  final String email;

  /// Senha do usuário.
  final String password;
}

/// Modelo de *response* em caso de sucesso no login de usuários.
class UserLoginSuccessfulResponseModel {
  /// Crie um modelo de *response* para login de usuários.
  UserLoginSuccessfulResponseModel({
    required this.token,
    required this.fullName,
    required this.isValidated,
    required this.validationCode,
  });

  /// Token de usuário. Uma chave aleatória composta por 60 letras.
  final String token;

  /// Nome completo do usuário.
  final String fullName;

  /// Booleano que define se o usuário está ou não validado.
  final bool isValidated;

  /// Código de validação (4 dígitos).
  final String validationCode;

  /// Transforma as variáveis da classe em um Map<String, dynamic>.
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'full_name': fullName,
      'is_validated': isValidated,
      if (!isValidated) 'validation_code': validationCode,
    };
  }
}

/// Modelo de *response* em caso de erro no login de usuários.
class UserLoginFailedResponseModel {
  /// Crie um modelo de *response* para login de usuários.
  UserLoginFailedResponseModel({
    required this.statusCode,
    required this.error,
  });

  /// Erro ocorrido.
  final String error;

  /// Código de status do erro.
  final int statusCode;
}
