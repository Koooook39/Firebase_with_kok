import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/student/PageName/Models/StudentModel.dart';
import 'package:firebase_getx/student/PageName/Models/peopleModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class PageNameServices {
  getNoobs() async {
    List noobs = <StudentModel>[];
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print(element.data());
          noobs.add(StudentModel(
            first_name: element.data()['first_name'],
            last_name: element.data()['last_name'],
            email: element.data()['email'],
            url: element.data()['url'],
          ));
        });
      });
      return noobs;
    } catch (e) {
      print('wleeeeeeeeeeeeeeeeeeeeeee');
      return [];
    }
  }

  addNewNoob(StudentModel item) async {
    try {
      String id = await FirebaseFirestore.instance
          .collection('student')
          .doc()
          .id
          .toString();
      await FirebaseFirestore.instance.collection('student').doc(id).set({
        'first_name': item.first_name,
        'last_name': item.last_name,
        'email': item.email,
        'id': id,
      });
    } catch (e) {
      print('Wleeeeeeeeeeeee');
    }
  }

  addNewNoobWithPhoto(StudentModel item, var file) async {
    try {
      String url = await uploadfileToFirebase(
          file: file,
          destination:
              '/profiles/students/${item.first_name} ${item.last_name}');
      String id = await FirebaseFirestore.instance
          .collection('student')
          .doc()
          .id
          .toString();
      await FirebaseFirestore.instance.collection('student').doc(id).set({
        'first_name': item.first_name,
        'last_name': item.last_name,
        'email': item.email,
        'id': id,
        'url': url,
      });
    } catch (e) {
      print(e);
      print('Wleeeeeeeeeeeee');
    }
  }

  getSortedNoobs() async {
    List noobs = <StudentModel>[];
    try {
      print('Hello');
      await FirebaseFirestore.instance
          .collection('student')
          .orderBy('age')
          .startAt(['20'])
          .endAt(['25'])
          .get()
          .then((value) {
            value.docs.forEach((element) {
              print(element.data());
              noobs.add(StudentModel(
                first_name: element.data()['first_name'],
                last_name: element.data()['last_name'],
                email: element.data()['start_date'],
                url: element.data()['url'],
              ));
            });
          });
      return noobs;
    } catch (e) {
      print('wleeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      return [];
    }
  }

  Future uploadfileToFirebase({var file, String? destination}) async {
    print('upload start');

    if (file == null) return;
    var task = await FirebaseStorage.instance.ref(destination);
    await task.putFile(File(file.path));
    var urlDownload = await task.getDownloadURL();
    print('Download-link : $urlDownload');

    return urlDownload;
  }
}
