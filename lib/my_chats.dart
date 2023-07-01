import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Chat_room.dart';
import 'homepage.dart';


class my_chats extends StatefulWidget {
  const my_chats({Key? key}) : super(key: key);

  @override
  State<my_chats> createState() => _My_ChatsState();
}

class _My_ChatsState extends State<my_chats> {
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
  late String name;
  late String uid ;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/my_chats.jpg'),
            fit: BoxFit.cover
        )
      ),

      child: Scaffold(



          backgroundColor: Colors.transparent,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,


        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('Chats').doc(uID).collection('chatroom').snapshots(),
    builder: (BuildContext context, snapshots){
          if(snapshots.hasData)
    {
    return ListView.separated(
      itemCount: snapshots.data!.docs.length,
      itemBuilder: (context,index) {
        return ListTile(
          shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.only(topRight: Radius.circular(22), bottomRight: Radius.circular(22),topLeft: Radius.circular(22),bottomLeft:  Radius.circular(22))),
          tileColor: Colors.white70,

          onTap: () {
            String roomId = chatRoomId(
                NAME,
                snapshots.data!.docs[index].get('Name'));

            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChatRoom(
                    chatRoomId: roomId,
                    name: snapshots.data!.docs[index].get('Name'),
                    uid2 : snapshots.data!.docs[index].get('uid'),
                  ),
                )
            );

          },
          title: Text( snapshots.data!.docs[index].get('Name'))
         // subtitle: Text(resultList[index]['profession']),
          //trailing: Text(resultList[index]['city']),

        );
      }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
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
            }

        )
  )
    );




  }
}
