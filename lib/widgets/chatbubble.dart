import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';


class MyChatBubble extends StatefulWidget{

  final String content;
  final String author;
  final DateTime timestamp;

  MyChatBubble({super.key, required this.content, required this.author, required this.timestamp});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
  }

class _ChatBubbleState extends State<MyChatBubble> {
  
  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper2(type: BubbleType.receiverBubble),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      backGroundColor: const  Color(0xffE7E7ED),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            "Johan Wolfgang von Goethe",
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

}