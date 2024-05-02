import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via/models/wiki_page.dart';
import 'package:via/repositories/groq_repository.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.wikiPage) : super(const ChatState()) {
    repo = GroqRepository(wikiPage: wikiPage);
    repo.startChat();
    final initMessage =
        //    "Context: ${wikiPage.title} \n I would Like to ask you some questions on this.";
        //    "Context: ${wikiPage.title} \n I would Like to ask you some questions on this. Please reply in 200 words.";
        "I am going to give you a context and a question, you are supposed to give me an answer in this format:\n {context: ${wikiPage.title}, response:...,}  \n Please reply in 200 words.";
    sendMessage(initMessage);
  }
  final WikiPage wikiPage;
  late final repo;

  void sendMessage(String message) async {
    final newMessages = List<String>.from(state.messages)..add(message);
    final response = await repo.sendMessage(message);
    newMessages.add(response);
    emit(state.copyWith(messages: newMessages));
  }
}
