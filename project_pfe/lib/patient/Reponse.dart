import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Demand.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/Reponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reponse_page extends StatefulWidget {
  const Reponse_page({super.key});

  @override
  State<Reponse_page> createState() => _Reponse_pageState();
}

class _Reponse_pageState extends State<Reponse_page> {
  final contolllerScroll = ScrollController();
  String? id_urgance;
  double? height;
  PageController pc = PageController();
  @override
  Widget build(BuildContext context) {
    dynamic get_urgance = ModalRoute.of(context)?.settings.arguments;
    id_urgance = get_urgance['libell'];
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reponse ${get_urgance['libell']}'),
      ),
      body: FutureBuilder(
          future: Patient.get_reponse(get_urgance['id']),
          builder: (context, snapshot) {
            List<Reponse>? list = snapshot.data as List<Reponse>?;
            return !snapshot.hasData
                ? const Center(child: CircularProgressIndicator())
                : PageView.builder(
                    controller: pc,
                    itemCount: list!.length,
                    itemBuilder: (context, i) {
                      return pageView(list[i]);
                    });
          }),
    );
  }

  Stack pageView(Reponse rep) => Stack(
        clipBehavior: Clip.none,
        children: [
          rep.url == ''
              ? Center(child: etatUrgance(context))
              : Align(
                  alignment: Alignment.topCenter,
                  child: Image.network(
                    "${rep.url}",
                    // semanticLabel: 'such as title in html',
                    fit: BoxFit.fitWidth,
                    height: height! / 2,
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: rep.description == ''
                ? etatUrgance(context)
                : Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 170, 185, 189),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        height: height! / 3.2,
                        width: double.infinity,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Scrollbar(
                              child: SingleChildScrollView(
                                  controller: contolllerScroll,
                                  child: Text(
                                    "${rep.description}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsExtraLight'),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    style: IconButton.styleFrom(
                                        foregroundColor: Colors.greenAccent,
                                        backgroundColor:
                                            Color.fromARGB(193, 106, 103, 103)),
                                    onPressed: () {
                                      contolllerScroll.animateTo(
                                          contolllerScroll
                                              .position.maxScrollExtent,
                                          duration: Duration(
                                              seconds:
                                                  (rep.description!.length / 40)
                                                      .toInt()),
                                          curve: Curves.linear);
                                    },
                                    icon: const Icon(
                                      Icons.expand_more_rounded,
                                      size: 28,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          )
        ],
      );

  Column etatUrgance(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(flex: 2, child: Container()),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Est-ce que ces réponse sont satisfait ?',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 22),
            ),
          ),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      backgroundColor: Color.fromARGB(141, 200, 207, 207)),
                  onPressed: () {},
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins_SemiBoldItalic'),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      backgroundColor: Color.fromARGB(141, 193, 205, 203)),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    var id_user = prefs.getString('_id');
                    await Patient.demandDoctor(Demand(id_patient: id_user));
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins_SemiBoldItalic'),
                  )),
            ],
          ),
          Expanded(flex: 3, child: Container()),
        ],
      );
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.cyan[300],
      content: const Text(
        "Votre Demand ete bien enregistrer ,Please attend Reponse par Doctor",
        style: TextStyle(
            color: Color.fromARGB(255, 88, 63, 112),
            fontWeight: FontWeight.w200,
            fontFamily: 'Poppins'),
      ),
      duration: const Duration(seconds: 1),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.all(15 // Inner padding for SnackBar content.
          ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ));
  }
}
