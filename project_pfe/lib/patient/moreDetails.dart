import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Demand.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreDetails extends StatelessWidget {
  const MoreDetails({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic moreDetails = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("More Details"),
      ),
      body: WillPopScope(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Container(
                  child: Text(
                    "${moreDetails}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          bool confirmExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Confirmation",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 19)),
              content: Text('Est-ce que ces réponses sont satisfaites ?',
                  style: TextStyle(
                      fontFamily: 'Poppins_SemiBoldItalic', fontSize: 17)),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context, true); // Return true to allow pop
                      },
                      child: Text("Oui"),
                    ),
                    TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        var id_user = await prefs.getString('_id');

                        await Patient.demandDoctor(Demand(id_patient: id_user));

                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.pop(
                              context, true); // Return false to prevent pop
                        });
                      },
                      child: Text("Non"),
                    ),
                  ],
                )
              ],
            ),
          );

          if (confirmExit != null) {
            return confirmExit;
          }

          return true; // Default to true if confirmExit is null
        },
      ),
    );
  }
}
