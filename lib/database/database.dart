import 'package:mysql1/mysql1.dart';

/// Utilizando, atualmente, a biblioteca  `mysql1`, essa classe realiza o
/// controle das conexões com o banco de dados.
abstract class Database {
  /// Inicia e retorna um objeto de conexão com o banco de dados.
  Future<MySqlConnection> connect() async {
    final connection = await MySqlConnection.connect(
      ConnectionSettings(
        // host: 'localhost',
        // port: 3306,
        user: 'root',
        db: 'securecar',
        password: 'root',
      ),
    );

    return connection;
  }

  /// Tabela de usuários.
  final usersTable = (
    tableName: 'usersTable',
    columns: (
      id: 'id',
      fullName: 'full_name',
      email: 'email',
      birth: 'birth',
      cpf: 'cpf',
      password: 'password',
    ),
  );

  /// Tabela de validação dos usuários.
  final usersValidationTable = (
    tableName: 'users_validation',
    columns: (
      id: 'id',
      validationCode: 'validation_code',
      isValidated: 'is_validated',
      userId: 'user_id',
    )
  );

  /// Tabelas com os tokens de acesso dos usuários.
  final usersTokenTable = (
    tableName: 'users_token',
    columns: (
      id: 'id',
      token: 'token',
      userId: 'user_id',
    )
  );
}
