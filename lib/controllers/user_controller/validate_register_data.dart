part of 'user_controller.dart';

/// Valida os dados da requisição de registro de usuário.
({
  bool isError,
  UserRegisterFailedResponseModel? failedResponse,
}) _validateRegisterData({required String body}) {
  if (body.isEmpty) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Body is empty',
      )
    );
  }

  try {
    if (jsonDecode(body) is! Map<String, dynamic>) {
      return (
        isError: true,
        failedResponse: UserRegisterFailedResponseModel(
          statusCode: HttpStatus.badRequest,
          error: 'Wrong data',
        )
      );
    }
  } catch (_) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Wrong body',
      )
    );
  }

  final data = jsonDecode(body) as Map<String, dynamic>;

  if (data['full_name'] == null) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Name is empty',
      )
    );
  }

  if (data['full_name'] is! String) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Name is invalid',
      )
    );
  }

  if (data['email'] == null) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Email is empty',
      )
    );
  }

  if (data['email'] is! String) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Email is invalid',
      )
    );
  }

  if (data['birth'] == null) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Birth is empty',
      )
    );
  }

  if (data['birth'] is! String) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Birth is invalid',
      )
    );
  }

  if (data['cpf'] == null) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'CPF is empty',
      )
    );
  }

  if (data['cpf'] is! String) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'CPF is invalid',
      )
    );
  }

  if (data['password'] == null) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Password is empty',
      )
    );
  }

  if (data['password'] is! String) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Password is invalid',
      )
    );
  }

  if (data['validation_code'] == null) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Validation code is empty',
      )
    );
  }

  if (data['validation_code'] is! String) {
    return (
      isError: true,
      failedResponse: UserRegisterFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Validation code is invalid',
      )
    );
  }

  return (isError: false, failedResponse: null);
}
