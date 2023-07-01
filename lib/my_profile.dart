
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'homepage.dart';

late final String documentId;
String name = "";
String image = "";
String about = "";
String profession = "";
String email = "";
List<String> docIds = [];

class my_profile extends StatefulWidget {
  const my_profile({Key? key}) : super(key: key);

  @override
  State<my_profile> createState() => _my_profileState();
}

class _my_profileState extends State<my_profile> {
  List allresults = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    showImage(img) {
      if (img == ''){
        return Center (
          child: ProfilePicture(
            name: name,
            radius: 80,
            fontsize: 45,
          ),
        );
      }
      else{
                return Center (
          child: ProfilePicture(
            name: name,
            radius: 80,
            fontsize: 45,
            img: img,
          ),
        );
      }
    }


    return Container(
     decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/profile.jpg'),fit: BoxFit.cover
    ),
    ),
        child:Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading:
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        child:  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance.collection('profile').doc(uID).get(),
                builder: (BuildContext context, snapshot) {
                            try {
                              if (snapshot.hasData){
                                image = snapshot.data!['image'];
                                name = snapshot.data!['name'];
                                about = snapshot.data!['about'];
                                profession =  snapshot.data!['profession'];
                                email = snapshot.data!['email'];
                                return
                                  Center(
                                      child: Column(
                                  children: <Widget>[
                                    const Text('Your Profile' , textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 40)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    showImage(image),

                                    const SizedBox(
                                      height: 30,
                                    ),

                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Text("Name" , textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                                    Container(
                                      width: 300,
                                      height: 60,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent,width: 3)
                                      ),

                                      child: Text(name, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 17)) ,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: 300,
                                      height: 60,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(

                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent, width: 3),



                                        ),
                                      child: Text(email,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)) ,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(

                                      width: 300,
                                      height: 100,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent,width: 3)
                                      ),
                                      child: Text(about,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17), softWrap: true,
                                        maxLines: 5,
                                        overflow: TextOverflow.fade,) ,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: 300,
                                      height: 50,

                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blueAccent,width: 3)
                                      ),
                                      child: Text(profession,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17)) ,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                      Center (child: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                  colors: [Colors.black, Colors.blueAccent])),
                                          child : ElevatedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const update_profile()));
                                      },style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              shadowColor: Colors.transparent),
                                           child: const Text('Edit Profile',textAlign: TextAlign.center,))
                                      )
                                      )


                                ]
                            )
                                  );
                              }
                              else
                              {
                                return const  Center(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 300,),
                                    CircularProgressIndicator(
                                  value: 0.9,
                                  color: Colors.blue,
                                  backgroundColor: Colors.grey,
                                )
                                      ]
                                )
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                            return Container();
                }),
      )
        )
      );
  }
}
