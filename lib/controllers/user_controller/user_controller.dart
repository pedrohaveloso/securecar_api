import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:securecar_api/models/user_login_model.dart';
import 'package:securecar_api/services/user_service.dart';

part 'validate_login_data.dart';

class UserController {
  final _userService = UserService();

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
