import 'package:securecar_api/database/database.dart';

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
      '`${usersTokenTable.columns.id}`'
      ') '
      'VALUES (?, ?);',
      [userToken, userId],
    );

    await conn.close();
  }

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
      '`${usersTable.columns.email}`, '
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
        results.first[usersValidationTable.columns.isValidated] == 0;

    return (
      userId: results.first[usersValidationTable.columns.userId] as int,
      fullName: results.first[usersTable.columns.fullName] as String,
      isValidated: isValidated,
      validationCode: isValidated
          ? null
          : results.first[usersValidationTable.columns.validationCode]
              as String,
    );
  }
}
