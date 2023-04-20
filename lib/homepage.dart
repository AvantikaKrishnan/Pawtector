import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/community_page.dart';
import 'package:epics5/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'Display.dart';
import 'information.dart';
import 'login.dart';
import 'main.dart';
import 'my_posts.dart';
import 'my_profile.dart';

late final String uID;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<String> docIds = [];

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  getUID() {
    uID = auth.currentUser!.uid;
  }

  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Epics()));
  }

  @override
  void initState() {
    getUID();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFCDC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF90E0EF),
        title: Text("EPICS"),
      ),
        body: SingleChildScrollView (
          child : Column(
            children: [
              Stack(
                children:[
              Transform.rotate(
                origin:Offset(30,-60),
              angle: 2.4,
              child: Container(
                margin:EdgeInsets.only(
                  left:75,
                  top:40,

                ),
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(80),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    colors: [Colors.cyanAccent , Colors.cyan]
                  )

                )
              )
    ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                  Text('Start helping the furries now!!!' ,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),

                  ),

                     SizedBox(
                      height: 10,
                     ),
                     Text('Enter information about them or veiw information about by choosing a location.',style: TextStyle(color: Colors.white,fontSize: 18),),

                  ] ,
              )

                ),

    ]
              ),
    GestureDetector(
    onTap: () {
    print('GestureDetector onTap Called');
    },child: Container(
    padding: EdgeInsets.all(35),
    margin: EdgeInsets.all(20),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black, width: 4),
    borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              colors: [Colors.cyanAccent , Color(0xFFE3F2FD)]
          )
    ),
    child: Text("View Information",
    style: TextStyle(fontSize: 25)),
    ),
    ),
    GestureDetector(
    onTap: () {
    print('GestureDetector onTap Called');
    },child: Container(
                padding: EdgeInsets.all(35),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        colors: [Colors.cyanAccent , Color(0xFFE3F2FD)]
                    )
                ),
                child: Text("Add Information",
                    style: TextStyle(fontSize: 25)),
              ),
    ),

    ],
          ),
        ),



      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
             const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add information about stray animals'),
              onTap: () {
                print('i got clicked');
                Navigator.push(context, MaterialPageRoute(builder: (context) => Information()));
                // Update the state of the app
                // ...
                // Then close the drawer

              },
            ),
            ListTile(
              title: const Text('Community Page'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CommunityPage()));
              },
            ),
            ListTile(
              title: const Text('Know about animals near you'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => displayinfo()));
                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('See your posts'),
              onTap: () {
                getdata();
                Navigator.push(context, MaterialPageRoute(builder: (context) => My_posts()));
                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('My profile'),
              onTap: () {


                Navigator.push(context, MaterialPageRoute(builder: (context) => my_profile()));
                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('Sign out'),
              onTap: () {
                signOut();
                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
          ],
        ),
      ),

    );











  }
  FirebaseFirestore db = FirebaseFirestore.instance;
  void getdata() {
    db.collection("profile").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }


}