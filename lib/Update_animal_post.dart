import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'my_posts.dart';


class update_animal_post extends StatefulWidget {
  const  update_animal_post({Key? key}) : super(key: key);

  @override
  State< update_animal_post> createState() => _update_animal_post();
}

class _update_animal_post extends State<update_animal_post> {


  late String TypeOfAnimal_post_updated  ='';
  late String Count_post_updated ='';
  late String cit_post_updated ='';
  late String Stat_post_updated ='';
  late String addr_post_updated ='';
  late String land_post_updated ='';
  late String  locality_post_updated ='';
  late String features_post_updated ='';
  late String injury_post_updated ='';
  late String vet_post_updated ='';
  late String img_post_updated = '';




  bool showSpinner = false;
  CollectionReference info = FirebaseFirestore.instance.collection('info');


  display_image() {
    if (img_post == '') {
      return Center(
        child: ProfilePicture(
          name: "nnn",
          radius: 100,
          fontsize: 30,
          img: 'https://t4.ftcdn.net/jpg/04/81/13/43/360_F_481134373_0W4kg2yKeBRHNEklk4F9UXtGHdub3tYk.jpg',
        ),
      );
    }
    else {
      return Center(
        child: ProfilePicture(
          name: "nnn",
          radius: 100,
          fontsize: 30,
          img: img_post,
        ),
      );
    }
  }
  @override
  void initState() {

    display_image();
    super.initState();
  }
  String dropdownvalue = 'Yes';


  // List of items in our dropdown menu
  var items = [
    'Yes',
    'No',
    'Do not Know',
  ];




  @override
  Widget build(BuildContext context) {
    showImage(img) {
      if (img == ''){
        return Center (
          child: ProfilePicture(
            name: TypeOfAnimal_post,
            radius: 80,
            fontsize: 45,
          ),
        );
      }
      else{
        return Center (
          child: ProfilePicture(
            name: TypeOfAnimal_post,
            radius: 80,
            fontsize: 45,
            img: img,
          ),
        );
      }
    }

    ImagePicker imagePicker = ImagePicker();

    return ModalProgressHUD (
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
              onPressed: () => {

              }),
          backgroundColor: Color(0xFFF8AD9D),
          title: const Text('Update Event'),
        ),
        body: SingleChildScrollView (

          child: Column(

              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                showImage(img_post),

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
                      img_post_updated = await referenceImageToUpload.getDownloadURL();
                    }


                    catch (error){

                    }
                    setState(() {
                      showSpinner = false;
                    });


                  }, icon:  Icon(Icons.camera_alt)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text("Type of Animal",textAlign: TextAlign.right, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,  )
                ),

                TextField(
                  controller:
                  TextEditingController(text: TypeOfAnimal_post),
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 3, color:Color(0xFFF8AD9D),),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color(0xFFF8AD9D)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value){
                    TypeOfAnimal_post_updated = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                CSCPicker(

                  layout: Layout.vertical,
                  onCountryChanged: ( Count_post){

                    Count_post_updated =  Count_post;



                  },
                  onStateChanged: (state){
                    Stat_post_updated  =  Stat_post;

                    // if (state == null || state.isEmpty) {
                    // return 'Please enter some text';
                    // }
                    //return null;

                  },
                  onCityChanged: ( cit_post){
                    cit_post_updated = cit_post!;


                  },
                ),
                const Text(' "Nearest Address around where you spotted the stray animal',textAlign: TextAlign.right, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,  )
                ),
                TextField(
                  controller:
                  TextEditingController(text:  addr_post),
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Colors.lightBlueAccent),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color(0xFFF8AD9D)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: const TextStyle(fontSize: 25),
                  maxLines: 50,
                  minLines: 2,
                  onChanged: (value){
                    addr_post_updated = value;

                  },
                ),
                const SizedBox(
                  height: 40,
                ),

                const Text('Nearest Landmark around where you spotted the stray',textAlign: TextAlign.right, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,  )

                ),
                TextField(
                  controller:
                  TextEditingController(text:  land_post),
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Colors.lightBlueAccent),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color(0xFFF8AD9D)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: const TextStyle(fontSize: 25),
                  maxLines: 50,
                  minLines: 2,
                  onChanged: (value){
                    land_post_updated = value;

                  },
                ),
                const Text('Nearest Landmark around where you spotted the stray',textAlign: TextAlign.right, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,  )),
                TextField(
                  controller:
                  TextEditingController(text:  land_post),
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Colors.lightBlueAccent),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color(0xFFF8AD9D)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: const TextStyle(fontSize: 25),
                  maxLines: 50,
                  minLines: 2,
                  onChanged: (value){
                    land_post_updated = value;

                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Text("Your connections : ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Are you in contact with a local Veterinarian?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                //),
                DropdownButton(
                  isExpanded: true,

                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? vet_post) {
                    setState(() {
                      vet_post_updated  = vet_post!;
                    });
                  },
                ),



                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () async{



                    await info.doc(id_post).update({
                      'Type of animal': TypeOfAnimal_post_updated,
                      'Distinguishing features':  features_post_updated,

                      'Country': Count_post_updated,
                      'State': Stat_post_updated ,
                      'city': cit_post_updated,
                     // 'Seen in locality': seen,
                      'Nearest landmark': land_post_updated,
                      'Nearest address':  addr_post_updated,
                     // 'Contact with vet': vet,
                      'Image': img_post_updated,



                    }).then((value){
                      const snackBar = SnackBar(
                        content: Text('Updated'),
                      );

                    });

                    Navigator.pop(context);
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const My_posts()));

                    //  Navigator.popUntil(context, ModalRoute.withName('/teacher'));
                  },style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF8AD9D),),
                ),
              ]


          ),
        ),
      ),
    );
  }


}
