import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/homepage.dart';
import 'package:epics5/update_community_post.dart';
import 'package:flutter/material.dart';
import 'my_community_posts.dart';


class display_my_community_posts extends StatelessWidget {
  CollectionReference community = FirebaseFirestore.instance.collection('community');

  @override
  Widget build(BuildContext context) {
    display_image() {
      if (image == '') {
        return Center(
            child:Container(
              height:  MediaQuery. of(context). size. height*0.5,
              width: MediaQuery. of(context). size. width*0.9,
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
              height:  MediaQuery. of(context). size. height*0.5,
              width: MediaQuery. of(context). size. width*0.9,
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


    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/my_community_posts.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,

        appBar: AppBar(
            actions: <Widget>[
            IconButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => const update_community_post()));


    }, icon: const Icon(Icons.edit)),
              IconButton(onPressed: (){
                community.doc(id).delete();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => HomePage()), (Route route) => false);


              }, icon: const Icon(Icons.delete))
            ],
            leading: BackButton(
              onPressed: () => {},),
            backgroundColor: Colors.transparent,
            title: const Text("About my post"),

        ),

        body: SingleChildScrollView (

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  const SizedBox(
                    height: 20,
                  ),
                  display_image(),
                  const SizedBox(
                    height: 50,
                  ),


                     Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                        child:Container(
                          width: MediaQuery. of(context). size. width,
                            padding: const EdgeInsets.fromLTRB(25,0,0,0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.pinkAccent,
                                    width: 1
                                )
                            ),
                        child:Text(post, style: const TextStyle( fontSize: 25, fontWeight: FontWeight.bold,
                        ),textAlign: TextAlign.center
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                ]
            ),
          ),
        )

    );





  }
}


