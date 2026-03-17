import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe?Alignment.centerRight:AlignmentGeometry.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),

        decoration: BoxDecoration(
          color: isMe?Colors.blue:Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: isMe ? Radius.circular(18) : Radius.circular(0),
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(18),
          ),
        ),
        child: Text(message,style: TextStyle(
          color: isMe?Colors.white:Colors.black
        ),),
      ),
    );
  }
}