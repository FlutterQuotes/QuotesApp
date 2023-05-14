import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/widgets/chatbubble.dart';
import '../../blocs/settings/settings_bloc.dart';
import 'package:quotes_app/db/collection.dart';

class CreateQuotePage extends StatelessWidget{
  final TextEditingController _quoteController = TextEditingController();

  CreateQuotePage({super.key});

  @override
  Widget build(BuildContext context) {

  Collection db = Collection();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quote'),
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
                    _sendQuote(context, state.authorName);
                    db.getCollections();
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

  void _sendQuote(BuildContext context, String authorName) {
    String quote = _quoteController.text.trim();
    if (quote.isNotEmpty) {
      FirebaseFirestore.instance.collection('Quotes').add({
        'author': authorName,
        'content': quote,
        'timestamp': DateTime.now(),
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quote created successfully!'),
          ),
        );
        _quoteController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create quote. Please try again later.'),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quote cannot be empty!'),
        ),
      );
    }
  }
}
