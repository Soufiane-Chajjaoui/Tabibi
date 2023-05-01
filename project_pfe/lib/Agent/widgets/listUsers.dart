import 'package:flutter/material.dart';
import 'package:project_pfe/Agent/widgets/UserCard.dart';



class ListUsers extends StatelessWidget {
  const ListUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 17,
      itemBuilder: (context, index) => const UserCard(),
    );
  }
}