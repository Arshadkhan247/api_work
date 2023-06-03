import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_work/Model/user_model.dart';
import 'package:api_work/widgets/reusable_row.dart';

class UserApi extends StatefulWidget {
  const UserApi({super.key});

  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  List<UserModel> usersList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      usersList.clear();
      for (var i in data) {
        usersList.add(UserModel.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('USER API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!
                        .length, // can also access the length of List... by userList.length
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        child: Card(
                          shape: Border.all(
                              color: Colors.blueGrey, width: 3, strokeAlign: 1),
                          elevation: 5,
                          shadowColor: const Color.fromARGB(255, 37, 66, 81),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: 'Id',
                                    value: snapshot.data![index].id.toString()),
                                ReusableRow(
                                    title: 'Name',
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReusableRow(
                                    title: 'Title',
                                    value: snapshot.data![index].username
                                        .toString()),
                                ReusableRow(
                                    title: 'Email',
                                    value:
                                        snapshot.data![index].email.toString()),
                                ReusableRow(
                                    title: 'Street',
                                    value: snapshot.data![index].address!.street
                                        .toString()),
                                ReusableRow(
                                    title: 'Suite',
                                    value: snapshot.data![index].address!.suite
                                        .toString()),
                                ReusableRow(
                                    title: 'City',
                                    value: snapshot.data![index].address!.city
                                        .toString()),
                                ReusableRow(
                                    title: 'ZipCode',
                                    value: snapshot
                                        .data![index].address!.zipcode
                                        .toString()),
                                ReusableRow(
                                    title: 'Latitude',
                                    value: snapshot
                                        .data![index].address!.geo!.lat
                                        .toString()),
                                ReusableRow(
                                    title: 'Longtidue',
                                    value: snapshot
                                        .data![index].address!.geo!.lng
                                        .toString()),
                                ReusableRow(
                                    title: 'Phone#',
                                    value:
                                        snapshot.data![index].phone.toString()),
                                ReusableRow(
                                    title: 'Website',
                                    value: snapshot.data![index].website
                                        .toString()),
                                ReusableRow(
                                    title: 'Company_Name',
                                    value: snapshot.data![index].company!.name
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
