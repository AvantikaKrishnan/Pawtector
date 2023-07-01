import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/homepage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class add_community_post extends StatefulWidget {
  const add_community_post({Key? key}) : super(key: key);

  @override
  State<add_community_post> createState() => _add_community_postState();
}

late String name;
late String image_user;
getInfoStream () async{

  var snapshot = FirebaseFirestore.instance.collection('profile').doc(uID).get().then((snapshot) =>
  name = snapshot.data()!['name']);
  var snap = FirebaseFirestore.instance.collection('profile').doc(uID).get().then((snapshot) =>
  image_user = snapshot.data()!['image']);

}



class _add_community_postState extends State<add_community_post> {

  late String imageUrl='';
  late String post ='';


  void initState() {
    getInfoStream();
    imageUrl="";
    post="";
    super.initState();
  }



  bool showSpinner = false;
  CollectionReference community = FirebaseFirestore.instance.collection('community');


  display_image() {
    if (imageUrl == '') {
      return Center(
          child:Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
        height: 400,
        width: 400,
      decoration: BoxDecoration(
    image: DecorationImage(
    image: NetworkImage(imageUrl),
    fit: BoxFit.cover,
    ),
    ),
    )
      );
    }
  }
  static GlobalKey<FormState> Keycommunity = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ImagePicker imagePicker = ImagePicker();
    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/add_community_post.png'),fit: BoxFit.cover

    ),
        ),

        child: ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text("Add post"),
        ),
        body:SingleChildScrollView(

            child: Form(
              key: Keycommunity,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        const SizedBox(
                          height: 60,
                        ),

                        display_image(),
            Center (
              child: IconButton(onPressed:() async{

                XFile? file = await imagePicker.pickImage(source:ImageSource.gallery);

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
                  await referenceImageToUpload.putFile(File(file.path));
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                }


                catch (error){

                }
                setState(() {
                  showSpinner = false;
                });

              }, icon:  const Icon(Icons.camera_alt)),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              onChanged: (value){
                post = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 3, color: Colors.pinkAccent), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  )
              ),
              keyboardType: TextInputType.multiline,
              minLines: 1,//Normal textInputField will be displayed
              maxLines: 5,

            ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [Colors.redAccent, Colors.pinkAccent])),
                          child : ElevatedButton(onPressed: () async {
                            if(Keycommunity.currentState!.validate()){
                              //do your setState stuff
                              setState(() async {
                                String id = DateTime
                                    .now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                await community.doc(id).set({
                                  'image': imageUrl,
                                  'post': post,
                                  'uid': uID,
                                  'name': name,
                                  'profilepic': image_user,
                                  'id': id,

                                }).then((value) => print("worked"));
                              });
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => HomePage()));
                            }



                          }, style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent), child: const Text('Post')
                          ),
                        )
                        )

            ]
      )
          ),
        )
        ),
    )
        )


    );
  }
}
