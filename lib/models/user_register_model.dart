/// Modelo de *request* para register de usuários.
class UserRegisterRequestModel {
  /// Crie um modelo de *request* para o registro de usuários.
  ///
  /// - O [email] deve ser uma String, além de ser um e-mail válido.
  /// - A [birth] deve ser uma String, no formato `yyyy-mm-dd`.
  /// - O [cpf] deve ser uma String, no formato `00000000000`.
  UserRegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.birth,
    required this.cpf,
    required this.password,
    required this.validationCode,
  });

  /// Nome completo do usuário.
  final String fullName;

  /// E-mail do usuário.
  final String email;

  /// Data de nascimento do usuário. Padrão: `yyyy-mm-dd`.
  final String birth;

  /// CPF do usuário. Padrão: `00000000000`.
  final String cpf;

  /// Senha do usuário.
  final String password;

  /// Código de validação do usuário.
  final String validationCode;
}

/// Modelo de *response* em caso de sucesso no cadastro de usuários.
class UserRegisterSuccessfulResponseModel {
  /// Crie um modelo de *response* para cadastro de usuários.
  UserRegisterSuccessfulResponseModel({
    required this.token,
  });

  /// Token de usuário. Uma chave aleatória composta por 60 letras.
  final String token;

  /// Transforma as variáveis da classe em um Map<String, dynamic>.
  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }
}

/// Modelo de *response* em caso de erro no cadastro de usuários.
class UserRegisterFailedResponseModel {
  /// Crie um modelo de *response* para cadastro de usuários.
  UserRegisterFailedResponseModel({
    required this.statusCode,
    required this.error,
  });

  /// Erro ocorrido.
  final String error;

  /// Código de status do erro.
  final int statusCode;
}
