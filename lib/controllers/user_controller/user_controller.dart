import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:securecar_api/models/user_login_model.dart';
import 'package:securecar_api/services/user_service.dart';

part 'validate_login_data.dart';

/// Controlador das rotas de login de usuário. Filtra os dados da requisição,
/// caso sejam válidos, passa a requição para um `Service`, caso não retorna o
/// erro.
class UserController {
  final _userService = UserService();

  /// Controle da rota de login do usuário. A rota exige um JSON contendo um
  /// e-mail e uma senha, caso não sejam fornecidos corretamente, retorna um
  /// erro.
  Future<Response> login({required RequestContext context}) async {
    final request = context.request;
    final method = request.method;

    if (method != HttpMethod.post) {
      return Response(
        body: 'Method not allowed',
        statusCode: HttpStatus.methodNotAllowed,
      );
    }

    final body = await request.body();

    final validityData = _validateLoginData(body: body);

    if (validityData.isError) {
      return Response(
        body: validityData.failedResponse!.error,
        statusCode: validityData.failedResponse!.statusCode,
      );
    }

    final data = jsonDecode(body) as Map<String, dynamic>;

    final user = UserLoginRequestModel(
      email: data['email'] as String,
      password: data['password'] as String,
    );

    return _userService.login(user: user);
  }
}
