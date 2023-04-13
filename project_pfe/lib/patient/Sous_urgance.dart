import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/Sous_urgance.dart';
import 'package:project_pfe/patient/Reponse.dart';

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
                      return card_Sous_urg(list[i]);
                    },
                  );
          }),
    );
  }

  Card card_Sous_urg(Sous_urgance sous) {
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            settings: RouteSettings(
                arguments: {'id': sous.id, 'libell': sous.libell}),
            builder: (context) => Reponse_page(),
          ));
        },
        title: Text(
          "${sous.libell}",
          style: TextStyle(fontFamily: 'Poppins_SemiBoldItalic'),
        ),
        leading: Image.network("${sous.url}"),
        trailing: IconButton(
          icon: Icon(Icons.navigate_next_rounded),
          onPressed: () {},
        ),
      ),
    );
  }
}
