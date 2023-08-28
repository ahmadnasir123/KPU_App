import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:kpu_ahmadnasir/db/db_local.dart';
import 'package:kpu_ahmadnasir/utility.dart';

class EntryData extends StatefulWidget {
  const EntryData({super.key});

  @override
  State<EntryData> createState() => _EntryDataState();
}

class _EntryDataState extends State<EntryData> {
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  DatabaseLocal databaseLocal = DatabaseLocal();

  TextEditingController dateinput = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noController = TextEditingController();
  TextEditingController lkController = TextEditingController();
  TextEditingController koorController = TextEditingController();

  //text editing controller for text field

  File? _imageFile;
  Future<File>? imgFileUpload;
  String? imageString;
  final _form = GlobalKey<FormState>(); //

  Future<void> _takePicture() async {
    try {
      final picker = ImagePicker();
      final imageFile = await picker.pickImage(source: ImageSource.camera);

      Future convertImage() async {
        imageString = Utility.base64String(await imageFile!.readAsBytes());
        print(imageString);
      }

      if (imageFile == null) {
        return;
      }
      setState(() {
        _imageFile = File(imageFile.path);
        convertImage();
      });
    } catch (e) {
      print("error: $e");
    }
  }

  Future<void> _galleryPicture() async {
    try {
      final picker = ImagePicker();
      final imageFile = await picker.pickImage(source: ImageSource.gallery);

      Future convertImage() async {
        imageString = Utility.base64String(await imageFile!.readAsBytes());
        print(imageString);
      }

      if (imageFile == null) {
        return;
      }
      setState(() {
        _imageFile = File(imageFile.path);
        convertImage();
      });
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  void initState() {
    dateinput.text = "";
    databaseLocal.database();
    //set the initial value of text field
    super.initState();
  }

  String? gender = "laki - laki";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Entry"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            TextFormField(
              controller: nikController,
              decoration: InputDecoration(labelText: "NIK"),
              maxLength: 16,
              keyboardType: TextInputType.number,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Email must be filled out';
                }
                return null;
              },
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nama"),
              maxLength: 50,
              keyboardType: TextInputType.name,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Email must be filled out';
                }
                return null;
              },
            ),
            TextFormField(
              controller: noController,
              decoration: InputDecoration(labelText: "No. Hp"),
              maxLength: 20,
              keyboardType: TextInputType.number,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Email must be filled out';
                }
                return null;
              },
            ),
            Text(
              "Jenis Kelamin",
              style: TextStyle(color: Colors.blueGrey),
            ),
            RadioListTile(
              title: Text("Laki - laki"),
              value: "laki - laki",
              groupValue: gender,
              activeColor: Colors.orange,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Perempuan"),
              value: "perempuan",
              groupValue: gender,
              activeColor: Colors.orange,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                controller: dateinput, //editing controller of this TextField
                decoration: InputDecoration(
                    //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: TextFormField(
                    controller: koorController,
                    decoration: const InputDecoration(
                      labelText: 'Koordinat',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () async {
                        await _getCurrentPosition();
                        koorController.text =
                            '${_currentPosition?.latitude} ${_currentPosition?.longitude}'
                                .toString();
                      },

                      //  () async {
                      //   await _getCurrentPosition();
                      //   koorController.text =
                      //       '${_currentPosition?.latitude} ${_currentPosition?.longitude}'
                      //           .toString();
                      // },
                      child: const Icon(Icons.gps_fixed),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey)),
                  child: _imageFile != null
                      ? Image.file(
                          _imageFile as File,
                          fit: BoxFit.cover,
                        )
                      : Center(child: Text("Belum ada gambar")),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _takePicture,
                      child: Icon(Icons.camera),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _galleryPicture,
                      child: Icon(Icons.photo_outlined),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () async {
                if (_form.currentState!.validate()) {
                  await databaseLocal.insert({
                    "nik": nikController.text,
                    "nama": nameController.text,
                    "noHp": noController.text,
                    "jk": gender,
                    "tglData": dateinput.text.toString(),
                    "koordinat": koorController.text,
                    "photoName": imageString,
                  });
                  Navigator.pushNamed(context, '/');
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
