import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: EdgeInsets.only(bottom: 3),
      child: ListTile(
        title: Text('Soufian chajjaoui'),
        subtitle: Text('last Message'),
        leading: CircleAvatar(
          radius: 25,
          child: Image.asset(
            'images/pngwing.png',
            height: 30,
            width: 30,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueGrey,
        ),
        trailing: Text('11:00'),
      ),
    );
  }
}
