import 'package:epics5/Select_profile.dart';
import 'package:flutter/material.dart';
import 'firebase_constants.dart';

class set_profile extends StatefulWidget {
  const set_profile({Key? key}) : super(key: key);

  @override
  State<set_profile> createState() => _set_profileState();
}
late String  name = '';
late String  Mobilenumber= '';
late String  Profession = '';
late String  about = '';
class _set_profileState extends State<set_profile> {

  final GlobalKey<FormState> Keyprofile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading:
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: Keyprofile,
        child: SizedBox(
        height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text("Set up your Profile", style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 30,)
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40
                            ),
                            child: Column(

                                children: [
                                  const Text('Name',style:TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87
                                  ),),
                                  const SizedBox(height: 5,),
                                  TextFormField(

                                    obscureText: false,
                                    onChanged: (value){
                                      name = value;

                                      },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue)
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 30,),

                                  const Text('Email id',style:TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87
                                  ),),
                                  const SizedBox(height: 5,),
                                  Container(
                                    width: 300,
                                    height: 50,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.blueAccent)

                                      ),
                                    child: Text('${auth.currentUser?.email}', textAlign: TextAlign.center,),
                                    ),
                                  const SizedBox(height: 30,),

                                            const Text('Profession',style:TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87
                                            ),),
                                            const SizedBox(height: 5,),
                                            TextFormField(
                                              obscureText: false,
                                              onChanged: (value){
                                                Profession = value;

                                              },
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue)
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                            ),
                                  const SizedBox(height: 30,),



                                            const Text('Write something about yourself',style:TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87
                                            ),),
                                            const SizedBox(height: 5,),
                                            TextFormField(

                                              obscureText: false,
                                              onChanged: (value){
                                                about = value;


                                              },
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue)
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter some text';
                                                }

                                                else
                                                  return null;
                                              },
                                              maxLines: 5,
                                              minLines: 3,
                                            ),
                                  const SizedBox(height: 30,),

                      ]
                  ),


                                                ),


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
                                              if ( Keyprofile.currentState!.validate()) {

                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')),);
                                                Navigator.pop(context);
                                                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const select_profile()));

                                              }
                                              else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                        content: Text('Enter all fields')));
                                              }
                                           },
                                             color: Colors.redAccent,
                                            shape: RoundedRectangleBorder(
                                                     borderRadius: BorderRadius.circular(40)
                                          ),

                                                   child: const Text("Next", style: TextStyle(
                                                   fontWeight: FontWeight.w600, fontSize: 16,

                                          ),),
                                         ),
                                   ),
                         ),
                             const SizedBox(height: 20,),
]
            ),
              ]

    )
    )
        )
        )
    );





  }
}
