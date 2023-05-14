import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScreenChat extends StatelessWidget {
  const ScreenChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        leadingWidth: 10,
        title: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: 'https://i.stack.imgur.com/l60Hf.png',
              width: 60,
              height: 60,
            ),
          ),
          title: Text(
            'Name user',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('last seen ', overflow: TextOverflow.ellipsis),
        ),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, i) => Container(
                child: Text('message'),
              )),
    );
  }
}
