// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyImageListWidget extends StatefulWidget {
  @override
  _MyImageListWidgetState createState() => _MyImageListWidgetState();
}

class _MyImageListWidgetState extends State<MyImageListWidget> {
  List<dynamic> _images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future _loadImages() async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8080/images').replace(host: "192.168.1.3"));
    if (response.statusCode == 200) {
      setState(() {
        _images = jsonDecode(response.body);
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test loading images from server'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _images.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 50,
              height: 200,
              child: CircleAvatar(
                radius: 5,
                child: CircularProgressIndicator(),
                foregroundImage: MemoryImage(
                  base64.decode(_images[index]['data']),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
