import 'dart:io';

import 'package:firebase_getx/main.dart';
import 'package:firebase_getx/student/PageName/PageNameController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentsPage extends StatelessWidget {
  AddStudentsPage({Key? key}) : super(key: key);

  @override
  var _controller = Get.put<PageNameController>(PageNameController());
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  GetBuilder(
                      init: PageNameController(),
                      builder: (_) {
                        return CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          radius: 50,
                          child: _controller.new_photo == null
                              ? Icon(Icons.camera_alt)
                              : null,
                          backgroundImage: _controller.new_photo == null
                              ? null
                              : FileImage(
                                  File(_controller.new_photo.path),
                                ) as ImageProvider,
                        );
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      var file = await ImagePicker.platform
                          .getImageFromSource(source: ImageSource.gallery);

                      if (file == null) return;

                      _controller.updatePhoto(file);
                    },
                    color: Colors.deepPurple,
                    child: Text(
                      'Pick Image',
                      style: TextStyle(),
                    ),
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: TextField(
                              onChanged: (String? value) {
                                _controller.newNoob.first_name = value;
                              },
                              decoration: InputDecoration(
                                label: Text('First name'),
                                hintText: 'Enter first name',
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 100,
                            child: TextField(
                              onChanged: (String? value) {
                                _controller.newNoob.last_name = value;
                              },
                              decoration: InputDecoration(
                                label: Text('Last name'),
                                hintText: 'Enter Last name',
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 100,
                            child: TextField(
                              onChanged: (String? value) {
                                _controller.newNoob.email = value;
                              },
                              decoration: InputDecoration(
                                label: Text('Email'),
                                hintText: 'Enter Email',
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 50,
                      width: Get.size.width * .8,
                      child: RaisedButton(
                        onPressed: () async {
                          await EasyLoading.show(dismissOnTap: true);
                          await _controller.addNewNoobWithPhoto();
                          await EasyLoading.showSuccess('Done');
                        },
                        color: Colors.deepPurple,
                        child: Text(
                          'Add Noob',
                          style: TextStyle(),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 50,
                      width: Get.size.width * .8,
                      child: RaisedButton(
                        onPressed: () async {
                          Notifications.showNotifiction(
                              _controller.newNoob.first_name.toString(),
                              'Added ${_controller.newNoob.first_name} ${_controller.newNoob.last_name} !');
                        },
                        color: Colors.deepPurple,
                        child: Text(
                          'Show notification',
                          style: TextStyle(),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
