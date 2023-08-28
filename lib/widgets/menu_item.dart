import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key, required this.name, required this.icon, required this.page});

  final String name;
  final dynamic icon;
  final String page;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SizedBox(
          width: 100,
          height: 50,
          child: ElevatedButton.icon(
            icon: icon,
            label: Align(alignment: Alignment.center, child: Text("${name}")),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            onPressed: () {
              Navigator.pushNamed(context, page);
            },
          ),
        ));
  }
}
