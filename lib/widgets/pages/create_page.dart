import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/widgets/chatbubble.dart';
import '../../blocs/settings/settings_bloc.dart';

class CreateQuotePage extends StatelessWidget{
  final TextEditingController _quoteController = TextEditingController();

  CreateQuotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Column(
              children: [
                MyChatBubble(content: '', author: state.authorName, timestamp: DateTime.now(), quoteController: _quoteController),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _sendQuote(state.authorName);
                  },
                  child: const Text('Send Quote'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _sendQuote(String authorName) {
    // Handle quote submission logic here.
    // You can use _quoteController.text to get the quote entered by the user.
    FirebaseFirestore.instance.collection('Quotes').add({
      'author': authorName,
      'content': _quoteController.text,
      'timestamp': DateTime.now(),
    });
  }
}
