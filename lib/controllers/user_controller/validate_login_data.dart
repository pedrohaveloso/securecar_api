part of 'user_controller.dart';

({
  bool isError,
  UserLoginFailedResponseModel? failedResponse,
}) _validateLoginData({required String body}) {
  if (body.isEmpty) {
    return (
      isError: true,
      failedResponse: UserLoginFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Body is empty',
      )
    );
  }

  try {
    if (jsonDecode(body) is! Map<String, dynamic>) {
      return (
        isError: true,
        failedResponse: UserLoginFailedResponseModel(
          statusCode: HttpStatus.badRequest,
          error: 'Wrong data',
        )
      );
    }
  } catch (_) {
    return (
      isError: true,
      failedResponse: UserLoginFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Wrong body',
      )
    );
  }

  final data = jsonDecode(body) as Map<String, dynamic>;

  if (data['email'] == null) {
    return (
      isError: true,
      failedResponse: UserLoginFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Email is empty',
      )
    );
  }

  if (data['email'] is! String) {
    return (
      isError: true,
      failedResponse: UserLoginFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Email is invalid',
      )
    );
  }

  if (data['password'] == null) {
    return (
      isError: true,
      failedResponse: UserLoginFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Password is empty',
      )
    );
  }

  if (data['password'] is! String) {
    return (
      isError: true,
      failedResponse: UserLoginFailedResponseModel(
        statusCode: HttpStatus.badRequest,
        error: 'Password is invalid',
      )
    );
  }

  return (isError: false, failedResponse: null);
}
