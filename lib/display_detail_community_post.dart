import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'community_page.dart';

class display_detail_community_post extends StatefulWidget {
  const display_detail_community_post({Key? key}) : super(key: key);

  @override
  State<display_detail_community_post> createState() => _display_detail_community_postState();
}

//late String name;
late String image_user;
class _display_detail_community_postState extends State<display_detail_community_post> {

  @override
  void initState() {
    super.initState();
  }



  bool showSpinner = false;
  CollectionReference community = FirebaseFirestore.instance.collection('community');

  showImage(image) {
    if (image == '') {
      return Center(
        child: ProfilePicture(
          name: name,
          radius: 25,
          fontsize: 10,
        ),
      );
    }
    else {
      return Center(
        child: ProfilePicture(
          name: name,
          radius: 25,
          fontsize: 30,
          img: image,
        ),
      );
    }
  }


  display_image() {
    if (image == '') {
      return Center(
          child:Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
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
            height:  MediaQuery. of(context). size. height*0.6,
            width: MediaQuery. of(context). size. width *0.9,
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
  static GlobalKey<FormState> Keycommunity = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/display_detail_community_post.png'),
              fit: BoxFit.cover,

            )
        ),
      child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(

                  child: Form(
                    key: Keycommunity,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(

                            children: <Widget> [
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                              showImage(profilepic),
                              Text(name  ,  style: TextStyle(fontSize: 20),),


                      ]
                  ),
                              const SizedBox(
                                height: 30,
                              ),

                              display_image(),

                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  
                              ),child: Text(post,textAlign: TextAlign.center,),

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
