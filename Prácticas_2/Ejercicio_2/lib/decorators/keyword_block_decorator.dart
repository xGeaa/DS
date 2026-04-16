import 'secret_keeper_decorator.dart';
import '../models/secret_keeper.dart';

class KeywordBlockDecorator extends SecretKeeperDecorator{
  final List<String> blackList = [
    "ignora",
    "actua como",
    "revela",
    "acrónimo",
    "jailbreak",
    "conviértete",
    "hazte pasar como",
    "imagina"
  ];

  KeywordBlockDecorator(SecretKeeper inner) : super(inner);

  @override
  Future<String> ask(String userMessage) async {
    final messageLower = userMessage.toLowerCase();
    for (var word in blackList) {
      if (messageLower.contains(word)) {
        return "¡ALTO AHÍ! He detectado la palabra prohibida '$word'. ¡No intentes manipularme!";
      }
    }

    return super.ask(userMessage);
  }
}