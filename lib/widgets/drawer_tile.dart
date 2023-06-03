import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final Widget destinstion;
  const DrawerTile({super.key, required this.title,required this.destinstion});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.white,
      title:  Center(
        child: Text(
          title,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => destinstion ,
          ),
        );
      },
    );
  }
}
