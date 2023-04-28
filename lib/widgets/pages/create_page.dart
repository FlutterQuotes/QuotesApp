import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';

class CreateQuotePage extends StatefulWidget {
  final String username;

  const CreateQuotePage({super.key, required this.username});

  @override
  CreateQuotePageState createState() => CreateQuotePageState();
}

class CreateQuotePageState extends State<CreateQuotePage> {
  TextEditingController _quoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Text(
                  state.authorName,
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }
            ),
            Text('Username: ${widget.username}'),
            TextField(
              controller: _quoteController,
              decoration: const InputDecoration(labelText: 'Quote'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendQuote,
              child: const Text('Send Quote'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendQuote() {
    // Handle quote submission logic here.
    // You can use _quoteController.text to get the quote entered by the user.
    print('Quote: ${_quoteController.text}');
  }
}
