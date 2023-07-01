import 'package:epics5/display_detail_community_post.dart';
import 'package:epics5/homepage.dart';
import 'package:epics5/other_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'my_profile.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

late String post;
late String image;
late String profilepic;
late String name;

class _CommunityPageState extends State<CommunityPage> {

  List allresults = [];
  displayimage(name , img){
      if (img == '') {
        return Center(
          child: ProfilePicture(
            name: name,
            radius: 60,
            fontsize: 30,
          ),
        );
      }
      else {

        return Center(
          child: ProfilePicture(
            name: name,
            radius: 60,
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
          return Center (
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

        image: AssetImage('assets/community_page.png'),
        fit: BoxFit.cover,
      ),
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
                      const SizedBox(height: 20,),

                      displayimage(NAME , IMAGE),

                      const Text('Pawtectors', style: TextStyle(
                        fontSize: 20.0,
                      ),),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Welcome to our community!', style: TextStyle(color: Colors.black54, ),),
                      ),
                      const SizedBox(
                          height : 50)
                    ],
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('community').orderBy('id', descending: true).snapshots(),
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
                        GestureDetector(
                          onTap: (){
                            if(data['uid'] == uID ) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const my_profile()));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => other_user_profile( uid: data['uid'],)));
                            }

                          },
                         child: Row(
                        children: [

                        showImage(data['name'], data ['profilepic']),
                          const SizedBox(width: 10,),
                          Column(
                          children: [
                            Text(data['name'], textAlign: TextAlign.start,),
                            ],
                          ),
                        ]
                      ),
                        ),
                          const SizedBox(height: 20,),
                          GestureDetector(
                            onTap:  (){
                              name = data['name'];
                              profilepic = data['profilepic'];
                              image = data['image'];
                              post = data['post'];
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const display_detail_community_post()));
                            },
                          child: Card(
                            shape: const RoundedRectangleBorder( //<-- SEE HERE
                              side: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
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
        )
    );
  }
}
