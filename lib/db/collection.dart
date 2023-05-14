import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class Collection{

//function to check database connection
Future<QuerySnapshot<Map<String, dynamic>>> getCollections() async {
  try {
    return await FirebaseFirestore.instance.collection('Quotes').get();
  } catch (error) {
    log(error.toString());
    rethrow;
  }
}
}