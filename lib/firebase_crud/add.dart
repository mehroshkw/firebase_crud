import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/firebase_crud/read.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController dobC = TextEditingController();
  TextEditingController bioC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Future<void> addData(String name, String phone, String address, String dob,
        String bio) async {
      if (formKey.currentState!.validate()) {
        await firestore.collection("userProfile").add({
          "name": name,
          "phone": phone,
          "address": address,
          "dob": dob,
          "bio": bio
        }).whenComplete(
            () => Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ReadData();
                })));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data to Firebase"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            Text("Fill the Form to Add Data to Firebase"),
            SizedBox(height: 10.0),
            Form(
              key: formKey,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: nameC,
                    validator: (v) {
                      if (nameC.text.isEmpty) {
                        return "Please Enter Your Name";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: phoneC,
                    validator: (v) {
                      if (phoneC.text.length <= 11) {
                        return "Phone number should be 11 digits";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Phone",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: addressC,
                    validator: (v) {
                      if (addressC.text.isEmpty) {
                        return "Please Enter Your Address";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Address",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: dobC,
                    validator: (v) {
                      if (dobC.text.isEmpty) {
                        return "Please Enter Your DOB";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "DOB",
                        hintText: "DD/MM/YYYY",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: bioC,
                    validator: (v) {
                      if (bioC.text.isEmpty) {
                        return "Please Enter Your Name";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Bio",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addData(nameC.text, phoneC.text, addressC.text, dobC.text,
                        bioC.text);
                  },
                  child: Text("Save Data"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ReadData();
                      }));
                    },
                    child: Text("Skip to Home"))
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
