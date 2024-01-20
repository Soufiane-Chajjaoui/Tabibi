import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_pfe/Agent/widgets/LoadingNotification.dart';
import 'package:project_pfe/Agent/widgets/NotificationCard.dart';
import 'package:project_pfe/actions/Agent.dart';
import 'package:project_pfe/actions/Notification.dart';

class ListNotifications extends StatefulWidget {
  const ListNotifications({super.key});

  @override
  State<ListNotifications> createState() => _ListNotificationsState();
}

class _ListNotificationsState extends State<ListNotifications> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Agent.getNotifications(),
        builder: (context, snapshot) {
          List<NotificationDemand>? list =
              snapshot.data as List<NotificationDemand>?;
          if (snapshot.hasData) {
            return list!.isEmpty
                ? Center(
                    child: Lottie.network(
                        "https://assets2.lottiefiles.com/packages/lf20_wadicnu2.json",
                        width: 100,
                        height: 100),
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => Dismissible(
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: const Color.fromARGB(137, 144, 133, 91),
                        child: const Icon(Icons.delete),
                      ),
                      onDismissed: (direction) async {
                        if (await Agent.removeDemand(list[index].idPatient)) {
                          setState(() {
                            list.removeAt(index);
                          });
                        }
                      },
                      direction: DismissDirection.endToStart,
                      key: Key(list[index].id as String),
                      child: CardNotification(
                        acceptDemand: () async {
                          await Agent.acceptDemand(
                              list[index].id, list[index].idPatient);
                          setState(() {
                            list.removeAt(index);
                          });
                        },
                        notificationDemand: list[index],
                      ),
                    ),
                  );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Lottie.network(
                  "https://assets10.lottiefiles.com/packages/lf20_45z9ii41.json"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonCardNotification();
              },
            );
          } else {
            return ListView.builder(
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonCardNotification();
              },
            );
          }
        });
  }
}
