import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfilePicture(
                  name: 'Goldy', radius: 50, fontsize: 30,
                ),
                Column(
                  children: [
                    Text('Community Name', style: TextStyle(
                      fontSize: 20.0,
                    ),),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Description of the community!', style: TextStyle(color: Colors.black54, ),),
                    ),
                  ],
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('Pictures').snapshots(),
                builder: (BuildContext context, snapshots){
                  List images = [];

                  if (snapshots.hasData){
                    var dataBox = snapshots.data!;

                    for (var data in dataBox.docs){
                      images.add(SizedBox(
                        width: 100,
                        height: 200,
                        child: Column(
                          children: [
                            const Text('Goldy Gour'),
                            Container(
                              width: 300,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(data['image'],),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Text('UserName'),
                          ],
                        ),
                      ));
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
    );
  }
}
