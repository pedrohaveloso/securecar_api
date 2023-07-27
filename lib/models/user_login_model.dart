class UserLoginRequestModel {
  UserLoginRequestModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class UserLoginSuccessfulResponseModel {
  UserLoginSuccessfulResponseModel({
    required this.token,
    required this.fullName,
    required this.isValidated,
    required this.validationCode,
  });

  final String token;
  final String fullName;
  final bool isValidated;
  final int validationCode;

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'full_name': fullName,
      'is_validated': isValidated,
      if (!isValidated) 'validation_code': validationCode,
    };
  }
}

class UserLoginFailedResponseModel {
  UserLoginFailedResponseModel({
    required this.statusCode,
    required this.error,
  });

  final String error;
  final int statusCode;
}
