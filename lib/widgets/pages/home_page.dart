import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/chatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<QuerySnapshot>(
          future: getCollections(),
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
                children: documents!
                    .map((doc) => MyChatBubble(
                          content: doc['content'].toString(),
                          author: doc['author'].toString(),
                          timestamp: doc['timestamp'].toDate(),
                        ))
                    .toList());
          }),
    );
  }
}

//function to check database connection
Future<QuerySnapshot<Map<String, dynamic>>> getCollections() async {
  try {
    return await FirebaseFirestore.instance.collection('Quotes').get();
  } catch (error) {
    log(error.toString());
    rethrow;
  }
}
