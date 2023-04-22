import 'package:flutter/material.dart';

class CreateQuotePage extends StatefulWidget {
  final String username;

  CreateQuotePage({super.key, required this.username});

  @override
  _CreateQuotePageState createState() => _CreateQuotePageState();
}

class _CreateQuotePageState extends State<CreateQuotePage> {
  TextEditingController _quoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Username: ${widget.username}'),
            TextField(
              controller: _quoteController,
              decoration: InputDecoration(labelText: 'Quote'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendQuote,
              child: Text('Send Quote'),
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
