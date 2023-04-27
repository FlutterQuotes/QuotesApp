import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';


class MyChatBubble extends StatefulWidget{

  final String content;
  final String author;
  final DateTime timestamp;

  const MyChatBubble({super.key, required this.content, required this.author, required this.timestamp});

  @override
  ChatBubbleState createState() => ChatBubbleState();
  }

class ChatBubbleState extends State<MyChatBubble> {
  
  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper2(type: BubbleType.receiverBubble),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      backGroundColor: const  Color(0xffE7E7ED),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.content,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 5),
          Row(children: [
            Expanded(
              child: Text(
                widget.author,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          const Padding(
            padding: EdgeInsets.only(left: 77),
          ),
          Text(
            '${widget.timestamp.day}.${widget.timestamp.month}.${widget.timestamp.year}',
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          ],)   
        ],
      ),
    );
  }

}