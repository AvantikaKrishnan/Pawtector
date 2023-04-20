import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'Get_information.dart';
import 'firebase_constants.dart';

late String name;

class my_profile extends StatefulWidget {
  const my_profile({Key? key}) : super(key: key);

  @override
  State<my_profile> createState() => _my_profileState();
}

class _my_profileState extends State<my_profile> {
  List allresults = [];


  // getInfoStream () async{
  //  // var uid = (await FirebaseAuth.instance.currentUser!).uid;
  //  var email = '${auth.currentUser?.email}';
  //   // var data = FirebaseFirestore.instance.collection('info').where('uid', isEqualTo: uid).orderBy('Type of animal').get();
  //   var data = await FirebaseFirestore.instance.collection('profile').where('email', isEqualTo: email).orderBy('Type of animal').get();
  //
  //   for (var ids in data.docs){
  //     docIds.add(ids.reference.id);
  //   }
  //
  //   print(docIds);
  //
  //   setState(() {
  //     allresults = data.docs;
  //   });
  //
  // }


  late final String documentId;
  late String name = "";
  late String image = "";
  late String mobile = "";
  late String profession = "";
  late String email = "";


  List<String> docIds = [];

  // var email = '${auth.currentUser?.email}';
  //
  // getDocIds() async {
  //   await FirebaseFirestore.instance.collection('profile').where('email', isEqualTo: email).get().then((snapshot) => snapshot.docs.forEach((document) {
  //     print(document.reference);
  //      docIds.add(document.reference.id);
  //      name = document['name'].toString();
  //      image = document['image'].toString();
  //      mobile = document['mobilenumber'].toString();
  //      profession = document['profession'].toString();
  //     // print(name);
  //     // print( document['name']);
  //     // print('worked?');
  //
  //
  //   }),
  //   );
  //}
  var uid;

  getUid() async {
    uid = (await FirebaseAuth.instance.currentUser!).uid;
    print(uid);
  }

  getData() {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('profile').doc(uid).get(),
        builder: (BuildContext context, snapshot) {
          try {
            if (snapshot.hasData){
              name = snapshot.data!['name'];
              print(name);
            }
            else
            {
              print('No!!!!!!');
            }
            return Container(
              child: Text(name),
            );
          } catch (e) {
            print(e);
          }

          return Text('Hy');
        });
  }

  @override
  void initState() {
    getUid();
    getData();

    // email = '${auth.currentUser?.email}';
    //
    // FirebaseFirestore.instance.collection('profile').where('email', isEqualTo: email).get().then((snapshot) => snapshot.docs.forEach((document) {
    //   print(document.reference);
    //   docIds.add(document.reference.id);
    //   name = document['name'].toString();
    //   image = document['image'].toString();
    //   mobile = document['mobilenumber '].toString();
    //   profession = document['profession'].toString();
    //  // print(name);
    //    print(mobile);
    //  //  print(image);
    //   // print(email);
    //   // print(profession);

    super.initState();
  }

  // showImage(img) {
  //   if (img == ''){
  //     return Center (
  //       child: ProfilePicture(
  //         name: ,
  //         radius: 80,
  //         fontsize: 45,
  //       ),
  //     );
  //   }
  //   else{
  //     ;        return Center (
  //       child: ProfilePicture(
  //         name: TypeOfAnimal,
  //         radius: 80,
  //         fontsize: 45,
  //         img: img,
  //       ),
  //     );
  //   }


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
      body: getData(),
    );
  }
}
