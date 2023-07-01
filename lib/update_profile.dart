import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/homepage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'my_profile.dart';


class update_profile extends StatefulWidget {
  const update_profile({Key? key}) : super(key: key);

  @override
  State<update_profile> createState() => _update_profileState();
}

bool showspinner = false;

class _update_profileState extends State<update_profile> {


  CollectionReference profile = FirebaseFirestore.instance.collection(
      'profile');




  late String imageurl = image;
  ImagePicker imagePicker = ImagePicker();

  display_image() {
    if (image == '') {
      return Center(
        child: ProfilePicture(
          name: name,
          radius: 80,
          fontsize: 30,
        ),
      );
    }
    else {
      return Center(
        child: ProfilePicture(
          name: name,
          radius: 80,
          fontsize: 30,
          img: image,
        ),
      );
    }
  }
  static final GlobalKey<FormState> _formKeyupdate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/my_profile.png'),
            fit: BoxFit.cover

        )
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading:
          IconButton(onPressed: ()
      {
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),
      ),
      body: SingleChildScrollView(
      child: Form(
      key: _formKeyupdate,
      child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child:ModalProgressHUD (
      inAsyncCall: showspinner,
      child: Column(
      children: <Widget>[

      Text('Edit your Profile' , textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 40)),
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
      showspinner = true;
      });

      try{
      await referenceImageToUpload.putFile(File(file!.path));
      image= await referenceImageToUpload.getDownloadURL();
      }


      catch (error){

      }

      print('pppp1= ' + image);
      imageurl = imageurl.toString();
      print('pppp2= ' + image);
      referenceImageToUpload.putFile(File(file!.path));

      setState(() {
      showspinner = false;
      });

      }, icon: Icon(Icons.camera_alt)),
      ),
      const SizedBox(
      height: 20,
      ),
      TextFormField(
      onChanged: (value){
      name = value;

      },

      controller: TextEditingController(text: name),
      decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
      borderSide:
      BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
      ),
        focusedBorder:OutlineInputBorder(
          borderSide:
          BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),
      )
      ),
      const SizedBox(
      height: 20,
      ),
      TextFormField(
      validator: (value) {
      if (value == null || value.isEmpty) {
      return 'Please enter some text';
      }
      return null;
      },
      onChanged: (value){
      email= value;

      },

      controller: TextEditingController(text: email),
      decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
      borderSide:
      BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
      ),
        focusedBorder:OutlineInputBorder(
          borderSide:
          BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),
      )
      ),
      const SizedBox(
      height: 20,
      ),
      TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            else if(value.length != 10)
            {
              return 'Mobile Number must be of 10 digit';
            }
            else
              return null;
          },
      onChanged: (value){
      about = value;

      },
      inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly],

      controller: TextEditingController(text: about),
      decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
      borderSide:
      const BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
      ),
        focusedBorder:OutlineInputBorder(
          borderSide:
          BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),
      )
      ),
      const SizedBox(
      height: 20,
      ),
      TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
      onChanged: (value){
      profession = value;

      },

      controller: TextEditingController(text: profession),
      decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
      borderSide:
      BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
      ),
        focusedBorder:OutlineInputBorder(
          borderSide:
          BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),

      ),

      ),
      const SizedBox(
      height: 20,
      ),
      ElevatedButton(
      child: Text('Submit'),
      onPressed: () async {
      await profile.doc(uID).update({
      'name': name,
      'about': about,
      'image': image,
      'profession': profession,
      }).then((value) {
      const snackBar = SnackBar(
      content: Text('Updated'),
      );
      });
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomePage()), (Route<dynamic> route) => false);
      }

      )
      ],
      ),
      ),
      )
      )
      )
      ),
    );
    }
}
