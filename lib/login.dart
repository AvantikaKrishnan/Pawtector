import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'email_verification_page.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username;
  late String password;
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    name.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:
        IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:const Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    const Text ("Login", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(height: 20,),
                    Text("Welcome back ! Login with your credentials",style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),),
                    const SizedBox(height: 30,)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40

                  ),
                  child: Column(
                    children: [
                      const Text('Email',style:TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87
                      ),),
                      const SizedBox(height: 5,),
                      TextField(
                        controller: name,
                        obscureText: false,
                        onChanged: (value){
                          username = value;
                        },

                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),

                      const Text('Password',style:TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87
                      ),),
                      const SizedBox(height: 5,),
                      TextField(
                        controller: pass,
                        obscureText: true,
                        onChanged: (value){
                          password = value;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3,left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: const Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black)
                        )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height:60,
                      onPressed: () async {
                        setState(() {

                        });
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: username,
                              password: password
                          );
                          if(isEmailVerified = false)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Email not verified')),
                              );
                            }
                          else if (credential != null) {
                            name.clear();
                            pass.clear();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomePage()),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),
                       // );


                      },
                      color: Colors.indigoAccent[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: const Text("Login",style: TextStyle(
                          fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white70
                      ),),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                      },
                    child:const Text("Sign Up",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                    ),
                    ),
                  ],
               //  ),
               // Text('Email not verified?'),
               //  GestureDetector(
               //    onTap: () {
               //      Navigator.push(context, MaterialPageRoute(builder: (context) => EmailVerificationScreen()));
               //    },
               //    child:Text("Verify email",style: TextStyle(
               //
               //        fontWeight: FontWeight.w600,
               //        fontSize: 18
               //    ),
               //    ),
               //  ),


            ),
          ],
        ),
    ]
      ),
    )
    );
  }
}

class MakeInput extends StatelessWidget {
  const MakeInput({Key? key, required this.label, required this.controller, required this.obsure}) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool obsure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style:const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        const SizedBox(height: 5,),
        TextField(
          controller: controller,
          obscureText: obsure,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
            ),
          ),
        ),
        const SizedBox(height: 30,)

      ],
    );
  }
}
