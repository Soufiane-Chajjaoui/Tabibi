import 'package:flutter/material.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: EdgeInsets.only(bottom: 3),
      child: ListTile(
        title: Expanded(child: Text('Soufian chajjaoui')),
        subtitle: Text('name Urgance'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.verified),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.cancel),
            ),
          ],
        ),
      ),
    );
  }
}
