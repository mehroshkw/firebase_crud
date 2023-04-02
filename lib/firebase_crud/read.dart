import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/firebase_crud/update.dart';
import 'package:flutter/material.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void deleteUser(String id) async {
    await firestore.collection("userProfile").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read Data"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("userProfile").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (c, i) {
                  var result = snapshot.data!.docs[i];
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              // title: Text("What Do you Wanna Do?"),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return UpdateData(
                                          id: result.id,
                                          // snapshot.data.docs[i].get(id);
                                        );
                                      }));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal[200],
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteUser(result.id);
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal[200],
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    child: Card(
                      color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(result['name']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(result['phone']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(result['address']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(result['dob']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(result['bio']),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
