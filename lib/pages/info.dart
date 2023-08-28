import 'package:flutter/material.dart';

class InfoPemilu extends StatelessWidget {
  const InfoPemilu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Informasi Pemilu"),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Image(
                image: NetworkImage(
                    "https://panjangrejo-bantul.desa.id/assets/files/artikel/sedang_1676259705WhatsAppImage20230212at12.57.46.jpeg")),
          ),
        ));
  }
}

