import 'package:flutter/material.dart';

class cardDrawer extends StatelessWidget {
  const cardDrawer(
      {super.key,
      required this.icon,
      required this.title,
      required this.ontap});
  final Function ontap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: ListTile(
        minLeadingWidth: 9,
        onTap: () => ontap(),
        leading: Container(
          margin: EdgeInsets.zero,
          child: Icon(icon),
        ),
        title: Text(
          '${title}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Poppins_SemiBoldItalic',
          ),
        ),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
}
