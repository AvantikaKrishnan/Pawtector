import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'email_verification_page.dart';
import 'firebase_constants.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  //const SignupPage(Set set, {Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();

}

class _SignupPageState extends State<SignupPage> {

  late String  username = '';
  late String password = '';
  late String confirm = '';
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();

  bool submitValid = false;
  bool _isLoading = false;




  EmailAuth emailAuth = EmailAuth(sessionName: 'Test');

  Map<String, String>? get remoteServerConfiguration => null;
  @override
  // void initState() {
  //   super.initState();
  //   // Initialize the package
  //   emailAuth = new EmailAuth(
  //
  //     sessionName: "Sample session",
  //   );

    /// Configuring the remote server
   // emailAuth.config(remoteServerConfiguration!);
  //}

  // void sendOtp() async {
  //   bool result = await emailAuth.sendOtp(
  //       recipientMail: _emailcontroller.value.text, otpLength: 5);
  //   if (result) {
  //     print('OTP SENT!!!!!!!');
  //     setState(() {
  //       submitValid = true;
  //     });
  //   }
  // }
  // void verify() {
  //   print(emailAuth?.validateOtp(
  //       recipientMail:  _emailcontroller.value.text,
  //       userOtp: _otpcontroller.value.text));
  // }

  static Future<User?> signUp(
      {required String userEmail,
        required String password,
        required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email:  userEmail , password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
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
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("Sign up", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 20,),
                        Text("Create an Account,Its free", style: TextStyle(
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
                            controller: _emailcontroller,
                            obscureText: false,
                            onChanged: (value){
                              username = value;
                              // print(username);
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
                            obscureText: true,
                            onChanged: (value){
                              password = value;
                              print(password);
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: const EdgeInsets.only(top: 3, left: 3),
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
                          height: 60,
                          onPressed: () async {
                            //sendOtp();
                            setState(() {
                              _isLoading = true;
                            });
                            await signUp(userEmail: username, password: password, context: context);

                            if(auth.currentUser != null){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const EmailVerificationScreen()));
                            }

                            setState(() {
                              _isLoading = false;
                            });
                            //
                            // try {
                            //   print(username);
                            //   print(password);
                            //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            //     email: username,
                            //     password: password,
                            //
                            //   );
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),
                            //   );
                            //  } on FirebaseAuthException catch (e) {
                            //   if (e.code == 'weak-password') {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         const SnackBar(
                            //             content: Text('The password provided is too weak.')));
                            //
                            //   } else if (e.code == 'email-already-in-use') {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         const SnackBar(
                            //             content: Text('The account already exists for that email.')));
                            //
                            //    }
                            // } catch (e) {
                            //   print(e);
                            // }



                          },
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          ),

                          child: const Text("Sign Up", style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16,

                          ),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                          child: const Text("Login", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                          ),
                        )

                      ],
                    )
                  ],

                ),
                    )
              ],
            ),
            ]
          ),
        ),
      ),
    )
    );
  }
}