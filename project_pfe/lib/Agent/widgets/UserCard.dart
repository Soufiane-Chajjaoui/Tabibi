import 'package:flutter/material.dart';
import 'package:project_pfe/Chat/screens/invidualChat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_pfe/actions/UserChat.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key, required this.User});

  UserChat User;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ChatInvidual(
                userInvidual: User,
              ))),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 1,
                  child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          imageUrl:
                              "https://res.cloudinary.com/dw2qfkws9/image/upload/v1684929857/uploads/q1fc07m0qy1dmbggrist.jpg",
                          fit: BoxFit.cover,
                          width: 50,
                          height: 55,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: Image.network(
                                "https://res.cloudinary.com/dw2qfkws9/image/upload/v1684929857/uploads/q1fc07m0qy1dmbggrist.jpg"),
                          ),
                          errorWidget: (context, url, error) =>const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ))),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${User.username}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins_Reguler'),
                      ),
                      Text('last Message', overflow: TextOverflow.ellipsis)
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text('12:20'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
