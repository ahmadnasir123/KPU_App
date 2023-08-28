import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/menu_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100, bottom: 50),
            child: Image(
              image: NetworkImage(
                  "https://www.kpu.go.id/images/1627539868logo-kpu.png"),
              height: 100,
            ),
          ),
          const MenuItem(
            name: "informasi",
            icon: Icon(Icons.info),
            page: "/info",
          ),
          const MenuItem(
            name: "Form Entry",
            icon: Icon(Icons.assignment_add),
            page: "/form_entry",
          ),
          const MenuItem(
            name: "Lihat Data",
            icon: Icon(Icons.assignment),
            page: "/show_data",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton.icon(
                icon: Icon(Icons.logout),
                label: const Align(
                    alignment: Alignment.center, child: Text("Keluar")),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
