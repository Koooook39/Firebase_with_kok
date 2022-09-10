import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/student/PageName/Models/StudentModel.dart';
import 'package:firebase_getx/student/PageName/PageNameController.dart';
import 'package:firebase_getx/student/PageName/PageNameServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PageNameScreen extends StatelessWidget {
  PageNameScreen({Key? key}) : super(key: key);
  var _controller = Get.put<PageNameController>(PageNameController());
  List noobs = <StudentModel>[
    StudentModel(
        first_name: 'Micky', last_name: 'Mouse', email: 'HoHO@gmail.com'),
    StudentModel(
        first_name: 'Rissoto', last_name: 'Nero', email: 'RI550t0@gmail.com'),
    StudentModel(
        first_name: 'Imapct', last_name: 'Bryhem', email: 'Kohoo@gmail.com'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'The Noobs',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: () {
                _controller.updateList();
              },
              textColor: Colors.white,
              color: Colors.deepPurple,
              child: Text('Get them Now !'),
            ),
            SizedBox(
              height: 400,
              child: GetBuilder(
                  init: PageNameController(),
                  builder: (controller) => FutureBuilder(
                      future: _controller.getNoobs(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Column(
                                  children: const [
                                    CircularProgressIndicator(
                                      color: Colors.deepPurple,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text('Loading...'),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ListView.builder(
                            itemCount: _controller.noobs.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(_controller.noobs.value[index].email);

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: NoobCard(
                                  name: _controller
                                          .noobs.value[index].first_name +
                                      ' ' +
                                      _controller.noobs.value[index].last_name,
                                  email: _controller.noobs.value[index].email,
                                  url: _controller.noobs.value[index].url,
                                ),
                              );
                            },
                          );
                        }
                      })),
            ),
          ],
        ),
      ),
    );
  }
}

class NoobCard extends StatelessWidget {
  NoobCard({Key? key, this.email, this.name, this.url}) : super(key: key);

  @override
  final name;
  final email;
  final url;
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        child: url == null
            ? Center(
                child: Icon(Icons.people_alt),
              )
            : null,
        backgroundImage:
            url == null ? null : NetworkImage(url) as ImageProvider,
      ),
      title: Text(
        name.toString(),
        style: TextStyle(color: Colors.deepPurple),
      ),
      subtitle: Text(email.toString()),
    );
  }
}
