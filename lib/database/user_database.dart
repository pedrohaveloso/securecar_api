import 'package:securecar_api/database/database.dart';

/// Realiza a comunicação com o banco de dados. Métodos para comunicação
/// relacionados ao usuário.
class UserDatabase extends Database {
  /// Através do id do usuário `userId`, salva um token de acesso a API. O token
  /// `userToken` deve ser uma chave chave aleatória.
  Future<void> createUserToken({
    required int userId,
    required String userToken,
  }) async {
    final conn = await connect();

    await conn.query(
      'INSERT INTO '
      '`${usersTokenTable.tableName}` '
      '('
      '`${usersTokenTable.columns.token}`, '
      '`${usersTokenTable.columns.userId}`'
      ') '
      'VALUES (?, ?);',
      [userToken, userId],
    );

    await conn.close();
  }

  /// Procura um usuário no banco, caso encontre retorna suas informações, caso
  /// não encontre retorna nulo.
  Future<
      ({
        int userId,
        String fullName,
        bool isValidated,
        String? validationCode,
      })?> searchUserByEmailAndPass({
    required String email,
    required String password,
  }) async {
    final conn = await connect();

    final results = await conn.query(
      'SELECT '
      '`${usersValidationTable.columns.userId}`, '
      '`${usersTable.columns.fullName}`, '
      '`${usersValidationTable.columns.isValidated}`, '
      '`${usersValidationTable.columns.validationCode}` '
      'FROM '
      '`${usersTable.tableName}`, '
      '`${usersValidationTable.tableName}` '
      'WHERE '
      '`${usersTable.columns.email}` = ? '
      'AND '
      '`${usersTable.columns.password}` = ? '
      'AND '
      '`${usersTable.tableName}`.`${usersTable.columns.id}` '
      '= '
      '`${usersValidationTable.tableName}`.'
      '`${usersValidationTable.columns.userId}`;',
      [email, password],
    );

    await conn.close();

    if (results.isEmpty) {
      return null;
    }

    final isValidated =
        results.first[usersValidationTable.columns.isValidated] != 0;

    return (
      userId: results.first[usersValidationTable.columns.userId] as int,
      fullName: results.first[usersTable.columns.fullName] as String,
      isValidated: isValidated,
      validationCode: isValidated
          ? ''
          : results.first[usersValidationTable.columns.validationCode]
              as String,
    );
  }

  /// Insere um novo usuário no banco de dados, além do seu código de validação.
  ///
  /// A data de nascimento [birth] deve estar no formato `yyyy-mm-dd`.
  Future<void> insertUser({
    required String fullName,
    required String email,
    required String birth,
    required String cpf,
    required String password,
    required String validationCode,
  }) async {
    final conn = await connect();

    await conn.query(
      'INSERT INTO `${usersTable.tableName}` '
      '(`${usersTable.columns.fullName}`, '
      '`${usersTable.columns.email}`, '
      '`${usersTable.columns.birth}`, '
      '`${usersTable.columns.cpf}`, '
      '`${usersTable.columns.password}`'
      ') VALUES '
      '(?, ?, ?, ?, ?);',
      [fullName, email, birth, cpf, password],
    );

    await conn.query(
      'INSERT INTO `${usersValidationTable.tableName}` '
      '(`${usersValidationTable.columns.validationCode}`, '
      '`${usersValidationTable.columns.userId}`'
      ') VALUES '
      '(?, '
      '('
      'SELECT ${usersTable.columns.id} '
      'FROM ${usersTable.tableName} '
      'WHERE ${usersTable.columns.email} = ? '
      ')'
      ');',
      [validationCode, email],
    );

    await conn.close();
  }
}
