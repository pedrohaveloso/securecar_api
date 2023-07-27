import 'package:dart_frog/dart_frog.dart';
import 'package:securecar_api/database/user_database.dart';
import 'package:securecar_api/models/user_login_model.dart';

class UserService {
  final _userDatabase = UserDatabase();

  Future<Response> login({required UserLoginRequestModel user}) async {
    final userExists = await _userDatabase.searchUserByEmail(email: user.email);
    if (!userExists) return Response();
  }
}
