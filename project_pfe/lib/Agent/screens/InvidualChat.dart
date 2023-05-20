import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Models/ChatUser.dart';
import '../widgets/messageUI.dart';

class ScreenChat extends StatelessWidget {
  const ScreenChat({super.key, required this.receptor});
  final ChatUser receptor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //  flexibleSpace:Widget() , in case you can charge widget such as appBar you can use this in Windows platform
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        leadingWidth: 10,
        title: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: receptor.image,
              width: 50,
              height: 50,
            ),
          ),
          title: Text(
            receptor.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('last seen ', overflow: TextOverflow.ellipsis),
        ),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                height: 7,
              ),
          padding: EdgeInsets.all(5),
          itemCount: 20,
          itemBuilder: (context, i) => Message()),
    );
  }
}
