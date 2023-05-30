import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Notification.dart';

class CardNotification extends StatelessWidget {
  CardNotification(
      {super.key,
      required this.notificationDemand,
      required this.acceptDemand});

  NotificationDemand notificationDemand;
  final Function acceptDemand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    imageUrl: "${notificationDemand.imageurl}",
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'images/user.png',
                      fit: BoxFit.cover,
                      height: 55,
                      width: 55,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${notificationDemand.nameEmitter}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins_Reguler'),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      onPressed: () async => await acceptDemand(),
                      icon: Icon(Icons.done))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
