import '../models/secret_keeper.dart';

abstract class SecretKeeperDecorator implements SecretKeeper {
  final SecretKeeper _inner;

  SecretKeeperDecorator(this._inner);

  @override
  String get secretWord => _inner.secretWord;

  @override
  Future<String> ask(String userMessage) {
    return _inner.ask(userMessage);
  }
}