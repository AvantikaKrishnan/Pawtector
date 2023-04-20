
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

late String name;

class my_profile extends StatefulWidget {
  const my_profile({Key? key}) : super(key: key);

  @override
  State<my_profile> createState() => _my_profileState();
}

class _my_profileState extends State<my_profile> {
  List allresults = [];

  late final String documentId;
  late String name = "";
  late String image = "";
  late String mobile = "";
  late String profession = "";
  late String email = "";
  List<String> docIds = [];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('profile').doc(uID).get(),
              builder: (BuildContext context, snapshot) {
                          try {
                            if (snapshot.hasData){
                              name = snapshot.data!['name'];
                              print('yes');
                              return Container(
                                  child: Text(name));
                            }
                            else
                            {
                              return Container(
                                child: Text('Data cannot be fetched!'),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                          return Container();
              })
      );
  }
}
