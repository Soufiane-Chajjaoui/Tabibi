import 'package:flutter/material.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Color(0xff99d8d7),

      body: CustomScrollView(
        //double? cacheExtent,
        slivers: [
          SliverAppBar(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(40),
            //   ),
            // ),
            expandedHeight: 240,
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            centerTitle: true,
            forceElevated: true,
            elevation: 4,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Container(
                  color: Color.fromARGB(255, 112, 111, 106),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recherche',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              centerTitle: true,
              title: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Wrap(
                    children: [
                      TextFormField(
                        cursorColor: Color.fromARGB(255, 74, 66, 66),
                        cursorHeight: 20,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(1),
                            hintStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            hintText: 'Urgance,Medciane...',
                            border: OutlineInputBorder(
                                // gapPadding: 10,
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  // strokeAlign: StrokeAlign.center,
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            prefixIcon: const Icon(Icons.search_outlined),
                            filled: true,
                            fillColor: Color.fromARGB(59, 175, 212, 177)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
