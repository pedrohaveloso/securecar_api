import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:securecar_api/database/user_database.dart';
import 'package:securecar_api/models/user_login_model.dart';
import 'package:securecar_api/utils/generate_aleatory_string.dart';

class UserService {
  final _userDatabase = UserDatabase();

  Future<Response> login({required UserLoginRequestModel user}) async {
    final userExists = await _userDatabase.searchUserByEmailAndPass(
      email: user.email,
      password: user.password,
    );

    if (userExists == null) {
      return Response(
        body: 'Invalid email or password',
        statusCode: HttpStatus.unprocessableEntity,
      );
    }

    final token = BCrypt.hashpw(
      generateAleatoryString(length: 60),
      BCrypt.gensalt(),
    );

    await _userDatabase.createUserToken(
      userId: userExists.userId,
      userToken: token,
    );

    final response = UserLoginSuccessfulResponseModel(
      token: token,
      fullName: userExists.fullName,
      isValidated: userExists.isValidated,
      validationCode: userExists.validationCode ?? '',
    );

    return Response.json(
      body: response.toMap(),
    );
  }
}
