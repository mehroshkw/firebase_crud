import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateData extends StatefulWidget {
  UpdateData({this.id});
  String? id;

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
TextEditingController nameC = TextEditingController();
TextEditingController phoneC = TextEditingController();
TextEditingController addressC = TextEditingController();
TextEditingController dobC = TextEditingController();
TextEditingController bioC = TextEditingController();

var snapshots = firestore.collection('userProfile');

class _UpdateDataState extends State<UpdateData> {
  void updateUser(
      {String? id,
      String? name,
      String? phone,
      String? address,
      String? dob,
      String? bio}) async {
    Map<String, Object> userProfile = {};
    if (name == "") {
    } else {
      userProfile['name'] = name!;
    }
    if (phone == "") {
    } else {
      userProfile['phone'] = phone!;
    }
    if (address == "") {
    } else {
      userProfile['address'] = address!;
    }
    if (dob == "") {
    } else {
      userProfile['dob'] = dob!;
    }
    if (bio == "") {
    } else {
      userProfile['bio'] = bio!;
    }
    await firestore.collection("userProfile").doc(id).update(userProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Data"),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore.collection("userProfile").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                              controller: nameC,
                              decoration: InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                              controller: phoneC,
                              decoration: InputDecoration(
                                labelText: "Phone",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                              controller: addressC,
                              decoration: InputDecoration(
                                labelText: "Address",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                              controller: dobC,
                              decoration: InputDecoration(
                                labelText: "DOB",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                              controller: bioC,
                              decoration: InputDecoration(
                                labelText: "Bio",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                              )),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            updateUser(
                                id: widget.id,
                                name: nameC.text,
                                phone: phoneC.text,
                                address: addressC.text,
                                dob: dobC.text,
                                bio: bioC.text);
                            Navigator.of(context, rootNavigator: true).pop();
                            print("updated");
                          },
                          child: Text("Update"),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();
            }));
  }
}
