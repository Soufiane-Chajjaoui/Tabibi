import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/Reponse.dart';

class Reponse_page extends StatefulWidget {
  const Reponse_page({super.key});

  @override
  State<Reponse_page> createState() => _Reponse_pageState();
}

class _Reponse_pageState extends State<Reponse_page> {
  final contolllerScroll = ScrollController();

  double? height;
  PageController pc = PageController();
  @override
  Widget build(BuildContext context) {
    dynamic get_urgance = ModalRoute.of(context)?.settings.arguments;
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
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.confirmation_num_outlined),
                  label: const Text('Yes')),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.not_interested),
                  label: const Text('No')),
            ],
          ),
          Expanded(flex: 3, child: Container()),
        ],
      );
}
