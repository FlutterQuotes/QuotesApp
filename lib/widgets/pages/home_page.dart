import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/chatbubble.dart';
class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:MyChatBubble(content:' Qoute', author:'test', timestamp: DateTime.now()),
          );
  }
}