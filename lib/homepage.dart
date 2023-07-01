import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/Find%20others.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Display.dart';
import 'add_community_post.dart';
import 'community_page.dart';
import 'information.dart';
import 'main.dart';
import 'my_chats.dart';
import 'my_community_posts.dart';
import 'my_posts.dart';
import 'my_profile.dart';

late String uID;
late String IMAGE ;
late String NAME ;


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

List<String> docIds = [];

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  FirebaseAuth auth = FirebaseAuth.instance;

  getUID() {
    uID = auth.currentUser!.uid;
    FirebaseFirestore.instance.collection('profile').doc(uID).get().then((snapshot) => IMAGE = snapshot.data()!['image']);
    FirebaseFirestore.instance.collection('profile').doc(uID).get().then((snapshot) => NAME = snapshot.data()!['name']);
  }

  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Epics()));
  }

  @override
  void initState() {
    getUID();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    uID;
    getUID();
    super.dispose();
  }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF6F9),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        // leading: Icon(Icons.menu,color: Colors.black,),
        title: const Text("Home", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(child: Text("0")),
            ),
          )
        ],
      ),
      body: SingleChildScrollView (
        child: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image: NetworkImage('https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/v546batch3-mynt-31-badgewatercolor_1.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=e1ee6e84fa2c584170bab2733ea5a1b0'),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.4),
                                    Colors.black.withOpacity(.2),
                                  ]
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              const Text('Welcome Pawtector!!!' , style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold,), textAlign: TextAlign.center
                                ,),
                              const SizedBox(height: 30,),
                              Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(horizontal: 40),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent
                                ),
                                child: Center(child: Text("Start helping the furries now.", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold,fontSize: 20,backgroundColor: Colors.transparent),textAlign: TextAlign.center,)),
                              ),
                              const SizedBox(height: 30,),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 20
                      ),
                      Row(
                          children:[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Information()));
                              },
                              child: Card (

                                elevation: 30,
                                child : Container(
                                  width: 150,
                                  height: 190,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/one.png'),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  child: const Column( children: [
                                    SizedBox(height: 20,),
                                    Icon(Icons.add_circle_outlined,size: 100,),
                                    Text('Stray animal Information', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                  ],),

                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const displayinfo()));
                              },
                              child: Card (
                                elevation: 30,
                                child : Container(



                                  width: 150,
                                  height: 190,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/two.png'),
                                          fit: BoxFit.cover
                                      )
                                  ),



                                  child: Column( children: [
                                    const SizedBox(height: 20,),
                                    Container(
                                      height: 100,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('assets/paws.png'),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    const Text('Know about animals near you', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                  ],),


                                ),
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 30,),
                      Row(
                          children:[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const CommunityPage()));
                              },
                              child: Card(
                                elevation: 30,
                                child: Container(



                                  width: 150,
                                  height: 190,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/four.png'),
                                          fit: BoxFit.cover
                                      )
                                  ),



                                  child: const Column( children: [
                                    SizedBox(height: 20,),
                                    Icon(Icons.people,size: 100,),
                                    Text('Community', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                  ],),


                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const add_community_post()));
                              },
                              child: Card(
                                elevation: 30,
                                child: Container(
                                  width: 150,
                                  height: 190,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/five.png'),
                                          fit: BoxFit.cover
                                      )
                                  ),



                                  child: const Column( children: [
                                    SizedBox(height: 20,),
                                    Icon(Icons.add_box_outlined,size: 100,),
                                    Text('Add community posts', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                  ],),


                                ),
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          children:[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const my_community_posts()));
                              },
                              child: Card(
                                elevation: 30,
                                child: Container(

                                  width: 150,
                                  height: 190,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/six.png'),
                                          fit: BoxFit.cover
                                      )
                                  ),

                                  child: const Column( children: [
                                    SizedBox(height: 20,),
                                    Icon(Icons.perm_identity_rounded,size: 100,),
                                    Text('My Community posts', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                  ],),


                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const My_posts()));
                              },
                              child: Card(
                                elevation: 30,
                                child: Container(
                                  width: 150,
                                  height: 190,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/two.png'),
                                          fit: BoxFit.cover
                                      )
                                  ),



                                  child: const Column( children: [
                                    SizedBox(height: 20,),
                                    Icon(Icons.emoji_people_outlined,size: 100,),
                                    Text('My animals posts', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                  ],),


                                ),
                              ),
                            ),
                          ]
                      )
                    ]
                )
            )
        ),
      ),
      drawer: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd3P4HZC4UR_HCFbodKs5AgPpJu7Q9iuPNTCvsYu2w&s'),  fit: BoxFit.fill,)
              ), child:Stack(
            children: [

                ]
    )
            ),
            ListTile(
              title: const Text('My profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => my_profile()));
              },
            ),
            ListTile(
              title: const Text('Know about animals near you'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => displayinfo()));
              },
            ),
            ListTile(
              title: const Text('Community Page'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CommunityPage()));
              },
            ),
            ListTile(
              title: const Text('See your posts'),
              onTap: () {
                getdata();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const My_posts()));
              },
            ),
            ListTile(
              title: const Text('My community posts'),
              onTap: () {
                print('i got clicked');
                Navigator.push(context, MaterialPageRoute(builder: (context) => const my_community_posts()));
              },
            ),
            ListTile(
              title: const Text('Connect with other users'),
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => find_others()));
              },
            ),
            ListTile(
              title: const Text('My chats'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const my_chats()));
              },
            ),
            ListTile(
              title: const Text('Sign out'),
              onTap: () {
                signOut();
              },
            ),
            // ListTile(
            //   title: const Text('checkpost'),
            //   onTap: () {
            //     print('i got clicked');
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => checkpost()));
            //     // Update the state of the app
            //     // ...
            //     // Then close the drawer
    ]
    )
    )
    );

  }
  FirebaseFirestore db = FirebaseFirestore.instance;
  void getdata() {
    db.collection("profile").get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}