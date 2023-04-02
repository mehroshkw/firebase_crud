import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name, studyprogram, id;
  String? cgpa;

  getStudentName(name) {
    this.name = name;
  }

  getStudentid(id) {
    this.id = id;
  }

  getStudentprogram(studyprogram) {
    this.studyprogram = studyprogram;
  }

  getStudentCGPA(cgpa) {
    this.cgpa = cgpa;
  }

  createData() {
    print("Create Data");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudent").doc(id);

    Map<String, dynamic> students = {
      "name": name,
      "id": id,
      "studyprogram": studyprogram,
      "cgpa": cgpa
    };
    documentReference.set(students).whenComplete(() {
      print("Student name created");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudent").doc(name);
    documentReference.get().then((datasnapshot) {
      // print(datasnapshot.data()['name']);
    });
    print(" Read");
  }

  updateData() {
    print(" Updated");
  }

  deleteData() {
    print(" Deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase CRUD")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Name",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  )),
              onChanged: (String name) {
                getStudentName(name);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "StudentID",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  )),
              onChanged: (String id) {
                getStudentid(id);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Study Program",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  )),
              onChanged: (String program) {
                getStudentprogram(studyprogram);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "CGPA",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  )),
              onChanged: (String cgpa) {
                getStudentCGPA(cgpa);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                      onPressed: () {
                        createData();
                      },
                      child: Text("Create")),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                      onPressed: () {
                        readData();
                      },
                      child: Text("Read")),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                      onPressed: () {
                        updateData();
                      },
                      child: Text("Update")),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ElevatedButton(
                      onPressed: () {
                        deleteData();
                      },
                      child: Text("Delete")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
