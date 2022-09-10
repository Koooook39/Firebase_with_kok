import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/student/PageName/Models/StudentModel.dart';
import 'package:firebase_getx/student/PageName/Models/peopleModel.dart';
import 'package:firebase_getx/student/PageName/PageNameServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNameController extends GetxController {
  PageNameServices service = PageNameServices();

  RxList noobs = [].obs;
  var peopleList = [];

  StudentModel newNoob = StudentModel();

  getNoobs() async {
    noobs.value = await service.getNoobs();
  }

  updateList() {
    update();
  }

  var new_photo;
  updatePhoto(file) {
    new_photo = file;
    update();
  }

  addNewNoob() async {
    print(newNoob.first_name);
    print(newNoob.last_name);
    print(newNoob.email);
    await service.addNewNoob(newNoob);
  }

  addNewNoobWithPhoto() async {
    print(newNoob.first_name);
    print(newNoob.last_name);
    print(newNoob.email);
    await service.addNewNoobWithPhoto(newNoob, new_photo);
  }

  getSortedNoob() async {
    noobs.value = await service.getSortedNoobs();
  }
}
