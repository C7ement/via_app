import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via/models/wiki_page.dart';

import 'chat_cubit.dart';
import 'chat_state.dart';

class ChatPage extends StatelessWidget {
  WikiPage wikiPage;
  ChatPage({required this.wikiPage});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(wikiPage),
      child: _ChatPage(),
    );
  }
}

class _ChatPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.messages.length,
                  reverse: false,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.messages[index]),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Type a message',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    context.read<ChatCubit>().sendMessage(_textController.text);
                    _textController.clear();
                  },
                ),
              ),
              onSubmitted: (text) {
                context.read<ChatCubit>().sendMessage(text);
                _textController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
