import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/chatbubble.dart';
class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column (
        children: [
          MyChatBubble(content:'Viel mehr als unsere Fähigkeiten sind es unsere Entscheidungen, die zeigen, wer wir wirklich sind.', 
            author:'J.K. Rowling', timestamp: DateTime.now()),
          MyChatBubble(content:'Wir sind so eitel, dass uns sogar an der Meinung der Leute, an denen uns nichts liegt, etwas gelegen ist.', 
            author:'Marie von Ebner-Eschenbach', timestamp: DateTime.now()),          
          MyChatBubble(content:'Zu mancher richtigen Entscheidung kam es nur, weil der Weg zur falschen gerade nicht frei war.', 
            author:'Hans Krailsheimer', timestamp: DateTime.now()),
          MyChatBubble(content:'Das Denken ist das Selbstgespräch der Seele.', 
            author:'Plato', timestamp: DateTime.now()),
        ],
      )
    );
  }
}