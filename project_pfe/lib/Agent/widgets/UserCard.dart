import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Models/ChatUser.dart';
import '../screens/InvidualChat.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.chatUser});
  final ChatUser chatUser;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ScreenChat(
                receptor: chatUser,
              ))),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: EdgeInsets.only(bottom: 3),
        child: ListTile(
          title: Text(
            '${chatUser.name}',
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${chatUser.about}',
            overflow: TextOverflow.ellipsis,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "https://lh3.googleusercontent.com/a/AGNmyxbGce06sdAnZyhjghs_z1VvkZP2Lm3U0IbiZuhP=s96-c",
              //  placeholder: (context, url) => CircularProgressIndicator(),
            ),
          ),
          trailing: CircleAvatar(
            radius: 7,
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
