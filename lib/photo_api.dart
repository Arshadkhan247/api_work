import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_work/Model/photo_model.dart';

class PhotoApi extends StatefulWidget {
  const PhotoApi({super.key});

  @override
  State<PhotoApi> createState() => _PhotoApiState();
}

class _PhotoApiState extends State<PhotoApi> {
  List<Photos> photoList = [];

  Future<List<Photos>> getPhoto() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url']);

        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Photo API'),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
