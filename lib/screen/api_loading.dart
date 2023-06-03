import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_work/screen/user_api.dart';
import 'package:api_work/screen/photo_api.dart';
import 'package:api_work/Model/post_model.dart';

class ApiLoading extends StatefulWidget {
  const ApiLoading({super.key});

  @override
  State<ApiLoading> createState() => _ApiLoadingState();
}

class _ApiLoadingState extends State<ApiLoading> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/posts',
      ),
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear();
      for (var i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          children: [
            const DrawerHeader(
              curve: Curves.decelerate,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Center(
                child: Text(
                  'Arshad khan',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23),
                ),
              ),
            ),
            ListTile(
              textColor: Colors.white,
              selectedColor: Colors.amber,
              title: const Center(
                child: Text(
                  'POST API',
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ApiLoading(),
                  ),
                );
              },
            ),
            ListTile(
              textColor: Colors.white,
              selectedColor: Colors.amber,
              title: const Center(
                child: Text(
                  'PHOTO API',
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PhotoApi(),
                  ),
                );
              },
            ),
            ListTile(
              textColor: Colors.white,
              selectedColor: Colors.amber,
              title: const Center(
                child: Text(
                  'USER API',
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserApi(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('POST API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: Border.all(
                                color: Colors.blueGrey,
                                width: 2,
                                strokeAlign: 3),
                            elevation: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(postList[index].title.toString()),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    postList[index].body.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
