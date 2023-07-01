// import 'package:chat_app/Authenticate/Methods.dart';
// import 'package:chat_app/Screens/ChatRoom.dart';
// import 'package:chat_app/group_chats/group_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/homepage.dart';
import 'package:epics5/my_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Chat_room.dart';

class find_others extends StatefulWidget {
  @override
  _find_othersState createState() => _find_othersState();
}

class _find_othersState extends State<find_others> with WidgetsBindingObserver {

  List<String> docIds = [];
  final myController = TextEditingController();
  List allresults = [];
  List resultList = [];

  getInfoStream () async{
    var data = await FirebaseFirestore.instance.collection('profile').orderBy('name').get();
    for (var ids in data.docs){
      docIds.add(ids.reference.id);
    }



    setState(() {
      allresults = data.docs;
    });
    searchResultList();
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus('Online');

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    getInfoStream();
    super.didChangeDependencies();
  }

  void _printLatestValue() {
    searchResultList();
  }

  searchResultList() async {
    var showResults = [] ;
    if(myController.text != "")
    {
      for(var InfoSnapshot in allresults)
      {
        var name = InfoSnapshot['name'].toString().toLowerCase();
        var email = InfoSnapshot['email'].toString().toLowerCase();
        var profession = InfoSnapshot['profession'].toString().toLowerCase();

        if(name.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);

        }
        else if(email.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);


        }
        else if(profession.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);


        }
      }
    }
    else
    {
      showResults = List.from(allresults);
    }
    setState(() {
      resultList = showResults;
    });


  }
  late String name;
  late String uid2;

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  void setStatus(String status) async {
    await _firestore.collection('profile').doc(_auth.currentUser!.uid).update({
      'status': status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor : Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CupertinoSearchTextField(
            controller: myController,
          ),
        ),

        body:
        ListView.separated(
          itemCount: resultList.length,
          itemBuilder: (context,index) {
            return ListTile(
              shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.only(topRight: Radius.circular(22), bottomRight: Radius.circular(22),topLeft: Radius.circular(22),bottomLeft:  Radius.circular(22))),
              tileColor: Colors.white60,

              onTap: () async {
                uid2 = resultList[index]['uid'];
                name = resultList[index]['name'];

                if(uid2 == uID) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const my_profile()));
                } else {
                  String roomId = chatRoomId(
                      NAME,
                      resultList[index]['name']);

                  // uid2 = resultList[index]['uid'];
                  // name = resultList[index]['name'];


                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            ChatRoom(
                              chatRoomId: roomId,
                              name: name,
                              uid2: uid2,
                            ),
                      )
                  );
                }

              },
              title: Text(resultList[index]['name']),
              subtitle: Text(resultList[index]['profession']),
              //trailing: Text(resultList[index]['city']),

            );


          }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
        )

    );
  }
}