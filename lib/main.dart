import 'package:epics5/Set_Profile.dart';
import 'package:epics5/homepage.dart';
import 'package:epics5/login.dart';
import 'package:epics5/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'community.dart';
import 'my_profile.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Epics(),

  ));
}

class Epics extends StatefulWidget {
  const Epics({Key? key}) : super(key: key);

  @override
  State<Epics> createState() => _EpicsState();
}

class _EpicsState extends State<Epics> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        resizeToAvoidBottomInset : false,
        body:SingleChildScrollView(


        child: Container(

            //  image:DecorationImage(image: AssetImage('assets/paw.png'))

        width: double.infinity,
       // height: MediaQuery.of(context).size.height,
    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
    constraints: null,


    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        height: 30,
      ),

      Text(
    "Welcome Pawtector!",
        textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
    ),
    SizedBox(height: 30,),
    Text("The superheroes to your furry friends. Join us in our quest to save the animals around us and become a Pawtector.",
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.grey[700],
    fontSize: 15
    ),
    ),
      Container(
      height: MediaQuery.of(context).size.height/3,
      margin: const EdgeInsets.all(20),
      child: const Image(
        width: 200,
        height: 200,
        image: NetworkImage(
            'https://cdn-icons-png.flaticon.com/512/1581/1581594.png'),
      ),
      ),
      const SizedBox(
        height: 20,
      ),


    ],


    ),
          MaterialButton(
            minWidth: double.infinity,
            height:60,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

            },
            color: Colors.indigoAccent[400],
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(40)
            ),
            child: Text("Login",style: TextStyle(
                fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white70

            ),
            ),
          ),
      const SizedBox(
        height: 20,
      ),
      MaterialButton(
        minWidth: double.infinity,
        height:60,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));

        },
        color: Colors.redAccent,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(40)
        ),
        child: Text("Sign up",style: TextStyle(
          fontWeight: FontWeight.w600,fontSize: 16,

        ),),
      ),
    ],
    ),

    ),
    )
    );



  }
}
