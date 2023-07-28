import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:securecar_api/database/user_database.dart';
import 'package:securecar_api/models/user_login_model.dart';
import 'package:securecar_api/utils/encrypt.dart';
import 'package:securecar_api/utils/generate_aleatory_string.dart';

/// Serviços e processos de usuário. Após o filtro da requisição, as informações
/// devem ser passadas para esse serviço.
class UserService {
  final _userDatabase = UserDatabase();

  /// Serviço de login de usuário, recebe um [UserLoginRequestModel] `user`,
  /// retornando uma resposta com um erro, caso o login não seja realizado, ou
  /// uma com informações do usuário e um Token da API, caso seja realizado.
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

    final token = generateAleatoryString(length: 60);

    final tokenHashed = Encrypt.hashBCrypt(
      text: token,
    );

    await _userDatabase.createUserToken(
      userId: userExists.userId,
      userToken: tokenHashed,
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
