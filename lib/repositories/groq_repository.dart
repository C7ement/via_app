import 'package:groq/groq.dart';
import 'package:via/api_key.dart';
import 'package:via/models/wiki_page.dart';

class GroqRepository {
  late Groq groq;
  final WikiPage wikiPage;

  GroqRepository({required this.wikiPage}) {
    const apiKey = String.fromEnvironment('groqApiKey', defaultValue: groqKey);
    groq = Groq(apiKey, model: GroqModel.llama370b8192);
  }

  Future<void> startChat() async {
    groq.startChat();
  }

  Future<String> sendMessage(String text) async {
    try {
      GroqResponse response = await groq.sendMessage(text);
      return response.choices.first.message.content;
    } on GroqException catch (error) {
      print('Error sending message: ${error.message}');
      return 'Error: ${error.message}';
    }
  }

  Future<void> setCustomInstructions(String instructions) async {
    groq.setCustomInstructionsWith(instructions);
  }
}
