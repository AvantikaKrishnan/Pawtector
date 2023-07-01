import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:epics5/my_community_posts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'homepage.dart';


class update_community_post extends StatefulWidget {
  const update_community_post({Key? key}) : super(key: key);

  @override
  State<update_community_post> createState() => _update_community_postState();
}

class _update_community_postState extends State<update_community_post> {


  CollectionReference community = FirebaseFirestore.instance.collection('community');
  bool showSpinner = false;
  static GlobalKey<FormState> Keycommunity = GlobalKey<FormState>();

  display_image() {
    if (image == '') {
      return Center(
          child:Container(
            height: MediaQuery. of(context). size. height*0.5,
            width: MediaQuery. of(context). size. width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://t4.ftcdn.net/jpg/04/81/13/43/360_F_481134373_0W4kg2yKeBRHNEklk4F9UXtGHdub3tYk.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          )
      );
    }
    else {
      return Center(
          child:Container(
            height:  MediaQuery. of(context). size. height*0.5,
            width: MediaQuery. of(context). size. width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    ImagePicker imagePicker = ImagePicker();
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/my_community_posts.png'),
              fit: BoxFit.cover,
            )
        ),
        child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(

          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text("Update post"),
          ),
          body:SingleChildScrollView(

                child: Form(
                  key: Keycommunity,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(

                          children: <Widget> [
                            const SizedBox(
                              height: 20,
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
                                  image = await referenceImageToUpload.getDownloadURL();
                                }


                                catch (error){

                                }
                                setState(() {
                                  showSpinner = false;
                                });

                                print(image);

                              }, icon:  Icon(Icons.camera_alt)),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              controller:
                              TextEditingController(text: post),
                              onChanged: (value){
                                post = value;
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 3, color: Colors.pinkAccent), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.pinkAccent), //<-- SEE HERE
                                    borderRadius: BorderRadius.circular(50.0),
                                  )
                              ),
                              keyboardType: TextInputType.multiline,
                              minLines: 1,//Normal textInputField will be displayed
                              maxLines: 5,

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                          colors: [Colors.blueAccent, Colors.pinkAccent])),

                                  child : ElevatedButton(onPressed: () async {
                                    await community.doc(id).update({
                                      'image' : image,
                                      'post' : post,

                                    }).then((value) => print("worked"));
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

                                  }, style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent), child: const Text('Post')),
                                )
                            )

                          ]
                      )
                  ),
                )
            ),
          ),
        )


    );
}
}

