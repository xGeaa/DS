abstract class SecretKeeper {
  // El secreto que el usuario intenta robar
  String get secretWord;

  // El método para hablar con el guardián
  Future<String> ask(String userMessage);
}