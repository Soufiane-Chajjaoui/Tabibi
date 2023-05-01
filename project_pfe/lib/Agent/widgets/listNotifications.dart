import 'package:flutter/material.dart';
import 'package:project_pfe/Agent/widgets/NotificationCard.dart';

class ListNotifications extends StatelessWidget {
  const ListNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 17,
      itemBuilder: (context, index) => CardNotification(),
    );
  }
}
