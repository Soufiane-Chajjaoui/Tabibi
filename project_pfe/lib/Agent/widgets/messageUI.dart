import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: double.infinity),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
        child: Text(
            'Message holla Message hollaMessage hollaMessage hollaMessage hollaMessage holla'),
      ),
    );
  }
}
