import 'package:bcrypt/bcrypt.dart';

/// Encriptação de dados.
class Encrypt {
  /// Encripta um texto usando BCrypt.
  static String hashBCrypt({required String text}) {
    return BCrypt.hashpw(text, BCrypt.gensalt());
  }

  /// Verifica se um texto fornecido e um hash são equivalentes. BCrypt.
  static bool checkBCrypt({
    required String text,
    required String hashed,
  }) {
    return BCrypt.checkpw(text, hashed);
  }
}
