import 'package:epics5/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'display_my_community_posts.dart';

class my_community_posts extends StatefulWidget {
  const my_community_posts({Key? key}) : super(key: key);

  @override
  State<my_community_posts> createState() => _my_community_postsState();
}
late String post;
late String image;
late String profilepic;
late String name;
late String id;

class _my_community_postsState extends State<my_community_posts> {

  List allresults = [];
  displayimage(name , img){
    if (img == '') {
      return Center(
        child: ProfilePicture(
          name: name,
          radius: 50,
          fontsize: 30,
        ),
      );
    }
    else {

      return Center(
        child: ProfilePicture(
          name: name,
          radius: 50,
          fontsize: 30,
          img: img,
        ),
      );
    }
  }


  showImage(name , img) {
    if (img == ''){
      return Center (
        child: ProfilePicture(
          name: name,
          radius: 20,
          fontsize: 10,
        ),
      );
    }
    else{
      ;        return Center (
        child: ProfilePicture(
          name: name,
          radius: 20,
          fontsize: 30,
          img: img,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://static.vecteezy.com/system/resources/previews/001/984/280/original/floral-background-with-cherry-blossoms-in-full-bloom-isolated-on-a-white-background-free-vector.jpg'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(

                    children: [
                      displayimage(NAME , IMAGE),

                      const Text('Welcome Pawtectors', style: TextStyle(
                        fontSize: 20.0,
                      ),),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Here are your posts', style: TextStyle(color: Colors.black54, ),),
                      ),
                      const SizedBox(
                          height : 50)
                    ],
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance.collection('community').where('uid', isEqualTo: uID).orderBy('id', descending: true).snapshots(),
                  builder: (BuildContext context, snapshots){



                    List images = [];

                    if (snapshots.hasData){
                      var dataBox = snapshots.data!;
                      for (var data in dataBox.docs){
                        images.add(SizedBox(
                          width: 300,
                          height: 350,
                          child: Column(
                            children: [
                              Row(
                                  children: [
                                    showImage(data['name'], data ['profilepic']),

                                    Column(
                                      children: [
                                        Text(data['name'], textAlign: TextAlign.start,),
                                        const SizedBox(height: 3,)
                                      ],
                                    ),
                                  ]
                              ),
                              GestureDetector(
                                onTap:  (){
                                  name = data['name'];
                                  profilepic = data['profilepic'];
                                  image = data['image'];
                                  post = data['post'];
                                  id = data['id'];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => display_my_community_posts()));
                                },
                                child: Card(
                                  elevation: 50,
                                  child: Container(
                                    width: 300,
                                    height: 200,
                                    decoration: BoxDecoration(

                                      image: DecorationImage(
                                        image: NetworkImage(data['image'],),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.transparent
                                ),
                                padding: const EdgeInsets.all(20),
                                child:Text(data['post'],style: const TextStyle(fontWeight: FontWeight.bold),),

                              ),
                            ],
                          ),
                        )
                        );
                      }
                      // print(images);

                      return MasonryGridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return images[index];
                        },
                      );
                    }

                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
