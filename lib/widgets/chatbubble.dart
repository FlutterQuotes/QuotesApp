import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';


class MyChatBubble extends StatefulWidget{

  final String content;
  final String author;
  final DateTime timestamp;
  final TextEditingController? quoteController;


  const MyChatBubble({super.key, required this.content, required this.author, required this.timestamp, this.quoteController});

  @override
  ChatBubbleState createState() => ChatBubbleState();
  }

class ChatBubbleState extends State<MyChatBubble> {
  
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;

    List<Widget> chatBubbleChild;
    if (widget.quoteController == null) {
      chatBubbleChild = [
        Text(
          widget.content,
          style: TextStyle(color: primaryColor),
        ),
        const SizedBox(height: 5),
        Row(children: [
          Text(
            widget.author,
            style: TextStyle(color: primaryColor, fontSize: 12),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 77),
          ),
          Text(
            '${widget.timestamp.day}.${widget.timestamp.month}.${widget.timestamp.year}',
            style: TextStyle(color: primaryColor.withOpacity(0.5), fontSize: 12),
          ),
        ],)
      ];
    } else {
      chatBubbleChild = [
        TextField(
          controller: widget.quoteController,
          decoration: const InputDecoration(labelText: 'Quote'),
          maxLines: 3,
        ),
        const SizedBox(height: 5),
        Row(children: [
          Expanded(
            child:
          Text(
            widget.author,
            style: TextStyle(color: primaryColor, fontSize: 12),
          ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 77),
          ),
          Text(
            '${widget.timestamp.day}.${widget.timestamp.month}.${widget.timestamp.year}',
            style: TextStyle(color: primaryColor.withOpacity(0.5), fontSize: 12),
          ),
        ],)
      ];
    }

    return ChatBubble(
      clipper: ChatBubbleClipper2(type: BubbleType.receiverBubble),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      backGroundColor: const  Color(0xffE7E7ED),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: chatBubbleChild,
      ),
    );
  }

}