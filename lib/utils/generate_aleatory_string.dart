import 'dart:math';

/// Função que gera e retorna uma `String` aleatória.
///
/// Deve receber o número máximo de caracteres como parâmetro.
String generateAleatoryString({required int length}) {
  final random = Random.secure();

  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';

  return List.generate(
    length,
    (index) => chars[random.nextInt(chars.length)],
  ).join();
}
