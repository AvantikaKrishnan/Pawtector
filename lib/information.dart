import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:epics5/Display.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

late String imageurl = '';
bool showSpinner = false;


class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.light,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      home: const TestPage(),
    );
  }

  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}


final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;


class _TestPageState extends State<TestPage> {
  late String imageurl = '';

  final GlobalKey<FormState> Keyinfo = GlobalKey<FormState>();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  late SingleValueDropDownController _cnt;
  late MultiValueDropDownController _cntMulti;

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    _cntMulti = MultiValueDropDownController();

    display_image();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    _cntMulti.dispose();
    super.dispose();
  }

  CollectionReference info = FirebaseFirestore.instance.collection('info');

  late String animal = '';
  late String feature = '';
  late String injury = '' ;
  late String count = '' ;
  late String?  st = '' ;
  late String? ci  = '' ;
  late String seen  = '' ;
  late String landmark  = '' ;
  late String addr  = '' ;
  late String vet  = '' ;

  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  display_image() {
    if (imageurl == '') {
      return Center(
        child:ProfilePicture(
          name: name,
          radius: 100,
          fontsize: 45,
          img: 'https://static.thenounproject.com/png/396915-200.png',
        ),

      );
    }

    else {
      return Center(
          child: ProfilePicture(
            name: name,
            radius: 80,
            fontsize: 45,
            img: imageurl,
          ),

      );
    }
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
    ImagePicker imagePicker = ImagePicker();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/information.png'),
          fit: BoxFit.cover
        )
      ),
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Information about Stray Animals'),
          ),
          body: SingleChildScrollView(

            child: Form(
              key: Keyinfo,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                      const SizedBox(
                        height: 20,
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
                          imageurl = await referenceImageToUpload.getDownloadURL();
                        }
                        catch (error){
                        }
                        imageurl = imageurl.toString();
                        referenceImageToUpload.putFile(File(file.path));

                        setState(() {
                          showSpinner = false;
                        });

                      }, icon:  const Icon(Icons.camera_alt)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child:Text("About the animal: ",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,


                              )
                          )

                      ),


                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        child: TextFormField(


                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:'Type of Animal',
                            hintText: 'Dog/Cat/Bird...',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (value){
                            animal = value;
                          },
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        child: TextFormField(

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:'Distinguishing characters of animal',
                            hintText: 'White fur/Brown spots/Curved tail',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (value){
                            feature = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Is the animal injured??",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //const SizedBox(
                      // height: 20,
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
                      onChanged: (String? newValue) {
                        setState(() {
                          injury = newValue!;
                        });
                      },
                    ),
                      const SizedBox(
                        height: 20,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: Text("Location Details : ",
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
                        "Where did you see the stray animal?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CSCPicker(
                        layout: Layout.vertical,
                        onCountryChanged: (country){
                          count = country;
                        },
                        onStateChanged: (state){
                          st = state;
                           // if (state == null || state.isEmpty) {
                             // return 'Please enter some text';
                           // }
                            //return null;
                        },
                        onCityChanged: (city){
                          ci = city;

                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Have you seen the stray animal in your locality before?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //  const SizedBox(
                      //  height: 50,
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
                      onChanged: (String? newValue) {
                        setState(() {
                          seen = newValue!;
                        });
                      },
                    ),

                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Nearest Landmark around where you spotted the stray animal",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:'Nearest Landmark around where you spotted the stray',
                            hintText: 'Bakery/Dentist/Fruit seller',
                          ),
                          onChanged: (value){
                            landmark = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Nearest Address around where you spotted the stray animal",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:'Nearest Address around where you spotted the stray',
                            hintText: 'House number/Lane Number',
                          ),
                          onChanged: (value){
                            addr = value;
                          },
                        ),
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
                      onChanged: (String? newValue) {
                        setState(() {
                          vet = newValue!;
                        });
                      },
                    ),

                      const SizedBox(
                        height: 30,
                      ),



            Center (child: Container(
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: [Colors.redAccent, Colors.pinkAccent])),
                child : ElevatedButton(
                          onPressed: () async
                          {
                            if (count.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Enter all location')));
                            }
                            // else if( st == null || st!.isEmpty)
                            //   {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         const SnackBar(
                            //             content: Text('Enter State')));
                            //
                            //   }
                            // else if( ci == null || ci!.isEmpty)
                            // {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content: Text('Enter City')));
                            //
                            // }
                            else {
                              if (Keyinfo.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );

                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => (const displayinfo())));
                                String id = DateTime.now().millisecondsSinceEpoch.toString();
                                await info.doc(id).set({
                                  'Type of animal': animal,
                                  'Distinguishing features': feature,
                                  'Is the animal injured': injury,
                                  'Country': count,
                                  'State': st,
                                  'city': ci,
                                  'Seen in locality': seen,
                                  'Nearest landmark': landmark,
                                  'Nearest address': addr,
                                  'Contact with vet': vet,
                                  'Image': imageurl,
                                  'uid' :uid,
                                  'id':id,
                                }).then((value) => print("worked"));
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Enter all fields')));
                              }
                            }
                          },style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent), child: const Text('Submit'),
                        ),
            ),
            )
                      // const SizedBox(
                      //   height: 50,
                  ],

                  //LOCATION PICKER


                ),
              ),
            ),

          ),

        ),
      ),
    );
  }
}
