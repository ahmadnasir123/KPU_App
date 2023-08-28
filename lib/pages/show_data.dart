import 'package:flutter/material.dart';
import 'package:kpu_ahmadnasir/db/db_local.dart';
import 'dart:convert';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  DatabaseLocal databaseLocal = DatabaseLocal();

  Future _refresh() async {
    setState(() {});
  }

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    databaseLocal.database();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Data Pemilih"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: () {
                databaseLocal.deleteAll();
                setState(() {});
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: databaseLocal.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.data!.length == 0) {
                return Center(
                  child: Text("Belum terdapat pemilih yang ditambahkan"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print(snapshot.data![index].photoName);
                  // final decodedBytes =
                  //     base64Decode(snapshot.data![index].photoName!);
                  // var file = Io.File("image[$index].png");
                  // file.writeAsBytesSync(decodedBytes);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nama"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("NIK"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("No HP"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Jenis - Kelamin"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Tgl Pendataan"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Koordinat Rumah"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Foto Pendataan"),
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(': ${snapshot.data![index].nama}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(': ${snapshot.data![index].nik}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(': ${snapshot.data![index].noHp}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(': ${snapshot.data![index].jk}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    ': ${DateTime.parse(snapshot.data![index].tglData!)}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(': ${snapshot.data![index].koordinat}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(": "),
                                    Container(
                                      height: 220,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.grey)),
                                      child: Image.memory(base64Decode(
                                          snapshot.data![index].photoName!)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      // child: Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text("Nama"),
                      //         Text(': ${snapshot.data![index].nama}')
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text("NIK"),
                      //         Text(': ${snapshot.data![index].nik}')
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text("No. HP"),
                      //         Text(': ${snapshot.data![index].noHp}')
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text("Jenis Kelamin"),
                      //         Text(': ${snapshot.data![index].jk}')
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text("Tanggal Didata"),
                      //         Text(
                      //             "${DateTime.parse(snapshot.data![index].tglData!)}")
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text("Titik Koordinat"),
                      //         Text(': ${snapshot.data![index].koordinat}')
                      //       ],
                      //     )
                      //   ],
                      // ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Gagal memuat data"),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                        ),
                        onPressed: _refresh,
                        child: const Text("Refresh"),
                      ),
                    ]),
              );
            }
          },
        ),
      ),
    );
  }
}
