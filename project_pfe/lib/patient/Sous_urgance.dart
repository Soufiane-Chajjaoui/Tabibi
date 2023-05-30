import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/Sous_urgance.dart';
import 'package:project_pfe/patient/Reponse.dart';
import 'package:project_pfe/patient/SousSous.dart';

class Sous_urgance_widget extends StatefulWidget {
  const Sous_urgance_widget({super.key});

  @override
  State<Sous_urgance_widget> createState() => _Sous_urgance_widgetState();
}

class _Sous_urgance_widgetState extends State<Sous_urgance_widget> {
  @override
  Widget build(BuildContext context) {
    dynamic get_urgance = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(get_urgance['urgance_libell']),
      ),
      body: FutureBuilder(
          future: Patient.get_sous_urgance(get_urgance['id']),
          builder: (context, snapshot) {
            List<Sous_urgance>? list = snapshot.data as List<Sous_urgance>?;
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: list!.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(title: card_Sous_urg(list[i]));
                    },
                  );
          }),
    );
  }

  Card card_Sous_urg(Sous_urgance sous) {
    return Card(
      elevation: 3,
      child: Container(
        height: 70,
        alignment: Alignment.center,
        child: ListTile(
          onTap: () {
            print(sous.id);
            Navigator.of(context).push(MaterialPageRoute(
              settings: RouteSettings(
                  arguments: {'id': sous.id, 'libell': sous.libell}),
              builder: (context) => SousSousUrgance(),
            ));
          },
          title: Text(
            "${sous.libell}",
            style: TextStyle(
                fontFamily: 'Poppins_SemiBoldItalic',
                overflow: TextOverflow.ellipsis),
          ),
          leading: CachedNetworkImage(
            imageUrl: "${sous.url}",
            height: 70,
            width: 70,
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'images/user.png',
              fit: BoxFit.cover,
              height: 170,
              width: 170,
            ),
          ),
          trailing: Icon(Icons.navigate_next_rounded),
        ),
      ),
    );
  }
}
