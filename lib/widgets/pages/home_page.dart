import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/chatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomePage extends StatelessWidget{
  const HomePage({super.key});

  Widget _buildListItem (BuildContext context, DocumentSnapshot document){
    return MyChatBubble(quote: document['quote'], username: document['username'], timestamp: document['timestamp'],);
  }

  @override
  Widget build(BuildContext context) {    
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Quotes').snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
          if (!snapshot.hasData){
            return const Center(
            child: CircularProgressIndicator(),
          );
          }
          return ListView.builder(
            itemExtent:80.0 ,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) => 
            _buildListItem(context, snapshot.data?.docs[index] as DocumentSnapshot<Object?>),
          );
        }
        ),
    );
  }
}