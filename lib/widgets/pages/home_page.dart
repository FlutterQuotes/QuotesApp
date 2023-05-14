import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/chatbubble.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<QuerySnapshot>(
            future: _getCollections(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final List<QueryDocumentSnapshot<Object?>>? documents =
                  snapshot.data?.docs;
              return ListView(
                  shrinkWrap: true,
                  controller: controller,
                  children: documents!
                      .map((doc) => MyChatBubble(
                            content: doc['content'].toString(),
                            author: doc['author'].toString(),
                            timestamp: doc['timestamp'].toDate(),
                          ))
                      .toList());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refreshPage,
        child: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

//function to check database connection
Future<QuerySnapshot<Map<String, dynamic>>> _getCollections() async {
  try {
    return await FirebaseFirestore.instance.collection('Quotes').get();
  } catch (error) {
    log(error.toString());
    rethrow;
  }
}