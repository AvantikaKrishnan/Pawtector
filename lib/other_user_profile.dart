import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'Chat_room.dart';
import 'homepage.dart';

late final String documentId;
String name = "";
String image = "";
String mobile = "";
String profession = "";
String about = "";
String email = "";
List<String> docIds = [];

// class other_user_profile extends StatefulWidget {
//   const other_user_profile({Key? key}) : super(key: key);
//
//   @override
//   State<other_user_profile> createState() => _other_user_profileState();
// }

class other_user_profile extends StatelessWidget{

   late String uid;
   other_user_profile({super.key, required this.uid});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List allresults = [];


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
    String chatRoomId(String user1, String user2) {
      if (user1[0].toLowerCase().codeUnits[0] >
          user2.toLowerCase().codeUnits[0]) {
        return "$user1$user2";
      } else {
        return "$user2$user1";
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
                actions: <Widget>[

                  IconButton(onPressed: () async {
                      String roomId = chatRoomId(
                          NAME,
                          name);
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ChatRoom(
                                  chatRoomId: roomId,
                                  name: name,
                                  uid2: uid,
                                ),
                          )
                      );
                      await _firestore.collection('Chats')
                          .doc(uID).collection('chatroom').doc(roomId).set({
                        'Name': name,
                        'uid': uid,
                      });
                      await _firestore.collection('Chats')
                          .doc(uid).collection('chatroom').doc(roomId).set({
                        'Name': NAME,
                        'uid': uID,
                      });

                  },
                    icon: const Icon(Icons.message)
                  )
    ]
            ),
            body:   FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance.collection('profile').doc(uid).get(),
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
                                        const Text('User Profile' , textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 40)),
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
                                        Container(
                                          width: 300,
                                          height: 60,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.blueAccent,width: 3)
                                          ),
                                          child: Text(name, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17)) ,
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
                                        Container(
                                          width: 300,
                                          height: 50,

                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.blueAccent,width: 3)
                                          ),
                                          child: Text(about,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),softWrap: true, maxLines: 5,
                                            overflow: TextOverflow.fade,) ,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            String roomId = chatRoomId(
                                                NAME,
                                                name);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => ChatRoom(
                                                    chatRoomId: roomId,
                                                    name: name,
                                                    uid2: uid,
                                                  ),
                                                )
                                            );
                                            await _firestore.collection('Chats')
                                                .doc(uID).collection('chatroom').doc(roomId).set({
                                              'Name' : name,
                                              'uid' : uid,
                                            });
                                            await _firestore.collection('Chats')
                                                .doc(uid).collection('chatroom').doc(roomId).set({
                                              'Name': NAME,
                                              'uid' : uID,
                                            });


                                          },
                                            child:const Icon(Icons.message)

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
              ),
            );
  }
}
