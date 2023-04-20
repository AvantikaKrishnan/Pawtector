import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/Set_Profile.dart';
import 'package:epics5/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'firebase_constants.dart';

class select_profile extends StatefulWidget {
  const select_profile({Key? key}) : super(key: key);

  @override
  State<select_profile> createState() => _select_profileState();
}
late String imageUrl='';
bool showSpinner = false;

class _select_profileState extends State<select_profile> {

  CollectionReference profile = FirebaseFirestore.instance.collection('profile');

  late String imageUrl='';
  late String email = '${auth.currentUser?.email}';

  display_image() {
    if (imageUrl == '') {
      return Center(
        child: ProfilePicture(
          name: name,
          radius: 100,
          fontsize: 30,
        ),
      );
    }
    else {
      return Center(
        child: ProfilePicture(
          name: "nnn",
          radius: 100,
          fontsize: 30,
          img: imageUrl,
        ),
      );
    }
  }
  @override
  void initState() {
    imageUrl;
    display_image();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    ImagePicker imagePicker = ImagePicker();

    return ModalProgressHUD (
        inAsyncCall: showSpinner,
        child: Scaffold(
        appBar: AppBar(
        leading: BackButton(
        onPressed: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => set_profile()))
        }),
              backgroundColor: Color(0xFFFFCFD2),
              title: const Text('Select Profile Picture'),
             ),
                    body: SingleChildScrollView (
                    child: Column(
                    children: <Widget>[
                      const SizedBox(
                      height: 150,
                     ),
                     display_image(),
                      Center (
                       child: IconButton(onPressed:() async{
                         XFile? file = await imagePicker.pickImage(source:ImageSource.gallery);
                           print('${file?.path}');
                           if(file == null) {
                             print ('DID NOT WORK');
                             return;
                           }

                           String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                           Reference referanceRoot = FirebaseStorage.instance.ref();
                           Reference referenceDirImages = referanceRoot.child('images');
                           Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                           setState(() {
                             showSpinner = true;
                           });

                           try{
                             await referenceImageToUpload.putFile(File(file!.path));
                             imageUrl = await referenceImageToUpload.getDownloadURL();
                           }


                           catch (error){

                           }
                           setState(() {
                             showSpinner = false;
                           });

                           print(imageUrl);

                           }, icon:  Icon(Icons.camera_alt)),
    ),
                      const SizedBox(
                        height: 50,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: const Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black)
                              )
                          ),


                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 40,
                            onPressed: () async {
                              var uid = (await FirebaseAuth.instance.currentUser!).uid;
                              await profile.doc(uid).set({
                                'name': name,
                                'email' : email,
                                'mobilenumber ': Mobilenumber,
                                 'profession' : Profession,
                                 'image': imageUrl,

                              }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())));
                              Navigator.pop(context);

                            },
                            color: Color(0xFFFFCFD2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)
                            ),

                            child: const Text("Set up Account", style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16,

                            ),),
                          ),

                        ),
                      ),
                      const Text("You can submit with default image as well."),
    ]

    )
    )
        )
    );
  }
}
