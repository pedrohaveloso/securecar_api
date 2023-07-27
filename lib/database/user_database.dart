import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:securecar_api/database/database.dart';

class UserDatabase extends Database {
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

  Future<bool> searchUserByEmail({required String email}) async {
    final conn = await connect();

    final results = await conn.query(
      'SELECT '
      '`${usersTable.columns.email}` '
      'FROM '
      '`${usersTable.tableName}` '
      'WHERE '
      '`${usersTable.columns.email}` = ?;',
      [email],
    );

    await conn.close();

    if (results.isEmpty) {
      return false;
    }

    return true;
  }

  Future<Response> authUser({
    required String email,
    required String password,
  }) async {
    final conn = await connect();

    final results = await conn.query(
      'SELECT `$usersTable`.`id`, '
      '`full_name`, '
      '`is_validated`, '
      '`validation_code` '
      'FROM `$usersTable`, `$usersValidationTable` '
      'WHERE `email` = ? AND `password` = ? '
      'AND `$usersTable`.`id` = `$usersValidationTable`.`user_id`;',
      [email, password],
    );

    if (results.isEmpty) {
      await conn.close();
      return Response(
        body: 'Invalid email or password',
        statusCode: HttpStatus.unprocessableEntity,
      );
    }

    final token = await _createUserToken(userId: results.first['id'] as int);

    await conn.close();
    return UserModel().login(results: results, token: token);

    Future<Response> login({
      required Results results,
      required String token,
    }) async {
      return Response.json(
        body: {
          'token': token,
          'full_name': results.first['full_name'],
          'is_validated': results.first['is_validated'],
          if (results.first['is_validated'] == 0)
            'validation_code': results.first['validation_code'],
        },
      );
    }
  }
}
