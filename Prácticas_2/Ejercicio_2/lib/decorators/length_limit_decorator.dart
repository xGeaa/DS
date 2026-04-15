import 'secret_keeper_decorator.dart';
import '../models/secret_keeper.dart';

class LengthLimitDecorator extends SecretKeeperDecorator{
  final int limit = 200;

  LengthLimitDecorator(SecretKeeper inner) : super(inner);

  @override
  Future<String> ask(String userMessage) async {
    String response = await super.ask(userMessage);

    if (response.length > limit) {
      return "[El guardián es de pocas palabras, no se va a parar a darte información gratuita.]";
    }

    return response;
  }
}